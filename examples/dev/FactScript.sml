
(*****************************************************************************)
(* High level (TFL) specification and implementation of factorial            *)
(*****************************************************************************)

(*****************************************************************************)
(* START BOILERPLATE                                                         *)
(*****************************************************************************)
(******************************************************************************
* Load theories
******************************************************************************)
(*
quietdec := true;
map load  ["compile"];
open arithmeticTheory pairLib pairTheory PairRules combinTheory
     composeTheory compileTheory compile;
infixr 3 THENR;
infixr 3 ORELSER;
quietdec := false;
*)

(******************************************************************************
* Boilerplate needed for compilation
******************************************************************************)
open HolKernel Parse boolLib bossLib;

(******************************************************************************
* Open theories
******************************************************************************)
open arithmeticTheory pairLib pairTheory PairRules combinTheory 
     composeTheory compile;
infixr 3 THENR;
infixr 3 ORELSER;

(*****************************************************************************)
(* END BOILERPLATE                                                           *)
(*****************************************************************************)

(*****************************************************************************)
(* Start new theory "Fact"                                                   *)
(*****************************************************************************)
val _ = new_theory "Fact";

(*****************************************************************************)
(* Implement iterative function as a step to implementing factorial          *)
(*****************************************************************************)
val (FactIter,FactIter_ind,FactIter_dev) =
 hwDefine
  `(FactIter (n,acc) =
      if n = 0 then (n,acc) else FactIter (n - 1,n * acc))
   measuring FST`;

(*****************************************************************************)
(* To implement `$*`` we build a naive iterative multiplier function         *)
(* (works by repeated addition)                                              *)
(*****************************************************************************)
val (MultIter,MultIter_ind,MultIter_dev) =
 hwDefine
  `(MultIter (m,n,acc) =
      if m = 0 then (0,n,acc) else MultIter(m-1,n,n + acc))
   measuring FST`;

(*****************************************************************************)
(* Verify that MultIter does compute multiplication                          *)
(*****************************************************************************)
val MultIterRecThm =  (* proof adapted from similar one from KXS *)
 save_thm
  ("MultIterRecThm",
   Q.prove
    (`!m n acc. SND(SND(MultIter (m,n,acc))) = (m * n) + acc`,
     recInduct MultIter_ind THEN RW_TAC std_ss []
      THEN RW_TAC arith_ss [Once MultIter]
      THEN Cases_on `m` 
      THEN FULL_SIMP_TAC arith_ss [MULT]));

(*****************************************************************************)
(* Create an implementation of a multiplier from MultIter                    *)
(*****************************************************************************)
val (Mult,_,Mult_dev) =
 hwDefine
  `Mult(m,n) = SND(SND(MultIter(m,n,0)))`;

(*****************************************************************************)
(* Verify Mult is actually multiplication                                    *)
(*****************************************************************************)
val MultThm =
 store_thm
  ("MultThm",
   Term`Mult = UNCURRY $*`,
   RW_TAC arith_ss [FUN_EQ_THM,FORALL_PROD,Mult,MultIterRecThm]);

(*****************************************************************************)
(* Use Mult_dev to refine ``DEV (UNCURRY $* )`` in FactIter_dev              *)
(*****************************************************************************)
val FactIter1_dev =
 REFINE (DEPTHR(LIB_REFINE[SUBS [MultThm] Mult_dev])) FactIter_dev;

(*****************************************************************************)
(* Use MultIter_dev to refine ``DEV MultIter`` in FactIter1_dev              *)
(*****************************************************************************)
val FactIter2_dev =
 REFINE (DEPTHR(LIB_REFINE[MultIter_dev])) FactIter1_dev;

(*****************************************************************************)
(* Lemma showing how FactIter computes factorial                             *)
(*****************************************************************************)
val FactIterRecThm =  (* proof from KXS *)
 save_thm
  ("FactIterRecThm",
   Q.prove
    (`!n acc. SND(FactIter (n,acc)) = acc * FACT n`,
     recInduct FactIter_ind THEN RW_TAC arith_ss []
      THEN RW_TAC arith_ss [Once FactIter,FACT]
      THEN Cases_on `n` 
      THEN FULL_SIMP_TAC arith_ss [FACT, AC MULT_ASSOC MULT_SYM]));

(*****************************************************************************)
(* Implement a function Fact to compute SND(FactIter (n,1))                  *)
(*****************************************************************************)
val (Fact,_,Fact_dev) =
 hwDefine
  `Fact n = SND(FactIter (n,1))`;

(*****************************************************************************)
(* Verify Fact is indeed the factorial function                              *)
(*****************************************************************************)
val FactThm =
 Q.store_thm
  ("FactThm",
   `Fact = FACT`,
   RW_TAC arith_ss [FUN_EQ_THM,Fact,FactIterRecThm]);

(*****************************************************************************)
(* Use FactIter2_dev to refine ``DEV FactIter`` in Fact_dev                  *)
(*****************************************************************************)
val Fact1_dev =
 REFINE (DEPTHR(LIB_REFINE[FactIter2_dev])) Fact_dev;

(*****************************************************************************)
(* REFINE all remaining DEVs to ATM                                          *)
(*****************************************************************************)
val Fact2_dev =
 REFINE (DEPTHR ATM_REFINE) Fact1_dev;

(*****************************************************************************)
(* Alternative derivation using refinement combining combinators             *)
(*****************************************************************************)
val Fact3_dev =
 REFINE
  (DEPTHR(LIB_REFINE[FactIter_dev])
    THENR DEPTHR(LIB_REFINE[SUBS [MultThm] Mult_dev])
    THENR DEPTHR(LIB_REFINE[MultIter_dev])
    THENR DEPTHR ATM_REFINE)
  Fact_dev;

(*****************************************************************************)
(* Finally, create implementation of FACT (HOL's native factorial function)  *)
(*****************************************************************************)
val FACT_dev =
 save_thm
  ("FACT_dev",
   REWRITE_RULE [FactThm] Fact3_dev);

val FACT_cir =
 save_thm
  ("Fact_cir",
   time MAKE_NETLIST FACT_dev);


(*****************************************************************************)
(* Temporary hack to work around a system prettyprinter bug                  *)
(*****************************************************************************)
val _ = temp_overload_on(" * ", numSyntax.mult_tm);

val _ = export_theory();
