(* ===================================================================== *)
(* FILE          : Definition.sml                                        *)
(* DESCRIPTION   : Principles of type definition, constant specification *)
(*                 and constant definition.                              *)
(*                                                                       *)
(* AUTHOR        : (c) Mike Gordon, University of Cambridge              *)
(* TRANSLATOR    : Konrad Slind, University of Calgary                   *)
(* DATE          : September 11, 1991  -- translated                     *)
(* DATE          : October 1, 2000     -- union of previous 3 modules    *)
(* ===================================================================== *)

signature Definition =
sig
  type term = Term.term
  type thm  = Thm.thm

  val new_type_definition : string * thm -> thm
  val new_definition      : string * term -> thm
  val new_specification   : string * string list * thm -> thm

  val new_definition_hook : ((term -> term list * term) *
                             (term list * thm -> thm)) ref
end

(* ===================================================================== *)
(*                                                                       *)
(*                    TYPE DEFINITION                                    *)
(*                                                                       *)
(* --------------------------------------------------------------------- *)
(*                                                                       *)
(* new_type_definition: define a new logical type.                       *)
(*                                                                       *)
(* USAGE: new_type_definition(name, thm)                                 *)
(*                                                                       *)
(* ARGUMENTS: name --- a string giving the name of the new type or       *)
(*                     type operator that is to be defined.              *)
(*                                                                       *)
(*            thm  --- a theorem asserting the existence of some         *)
(*                     object of type ty that satisfies a predicate      *)
(*                     pred. pred defines a subset of an existing type   *)
(*                     (ty say) that is to represent the new type.       *)
(*                     The type of pred must be "ty -> bool" and pred    *)
(*                     must contain no free variables.    The theorem    *)
(*                     must be of the form "|- ?x. pred x" for some      *)
(*                     variable x. The theorem must have no              *)
(*                     assumptions.                                      *)
(*                                                                       *)
(* SIDE EFFECTS: 1) Introduces a new type (type operator) with the       *)
(*                  given name. The arity of the new type operator       *)
(*                  is the same as the number of type variables in the   *)
(*                  predicate pred.                                      *)
(*                                                                       *)
(*              2) Asserts an axiom stating that there is an isomorphism *)
(*                 from the new type to the subset of ty defined by the  *)
(*                 predicate pred.  The name of this axiom will have     *)
(*                 the form "name_TY_DEF".                               *)
(*                                                                       *)
(*                 The behaviour will be as follows:                     *)
(*                                                                       *)
(*                     new_type_definition("ty", |- ?x. P x)             *)
(*                                                                       *)
(*                 yields the axiom:                                     *)
(*                                                                       *)
(*                     ty_TY_DEF = |- ?rep. TYPE_DEFINITION P rep        *)
(*                                                                       *)
(*                 I.e. there is a function rep from the new type to     *)
(*                 the representing type ty that is one to one and onto  *)
(*                 the subset defined by P.                              *)
(*                                                                       *)
(* RETURNS: the axiom as a theorem.                                      *)
(*                                                                       *)
(* ===================================================================== *)


(* ===================================================================== *)
(*                                                                       *)
(*         CONSTANT DEFINITION                                           *)
(*                                                                       *)
(* --------------------------------------------------------------------- *)
(*                                                                       *)
(*  new_definition ("name", `c = rhs`)                                   *)  
(*  declares c as a new constant and then does                           *)
(*  new_axiom("name", `c = rhs`).   It is required that rhs be a         *)
(*  closed term, and that every type variable occurring in rhs also      *)
(*  occurs in c.                                                         *)
(*                                                                       *)
(* ===================================================================== *)


(* ===================================================================== *)
(*                                                                       *)
(*         CONSTANT SPECIFICATION                                        *)
(*                                                                       *)
(* --------------------------------------------------------------------- *)
(*                                                                       *)
(*  new_specification ("name",[c1,...,cn], |- ?x1 ... xn. P x1 ... xn)   *)  
(*  declares c1, ..., cn as new constants and then does                  *)
(*  new_axiom("name", `P c1 ... cn`).   To avoid Roger Jones type        *)
(*  problems, it is required that there be no type variables in types    *)
(*  of subterms of "P c1 ... cn" that do not occur in the type of any    *)
(*  ci, (1 <= i <= n). This rules out, for example,                      *)
(*                                                                       *)
(*     new_specification(tok, ["Wonk"], |- ?b:bool. b = !x y:'a. x=y)    *)
(*                                                                       *)
(*  which would define a constant "Wonk" of type "bool" by the           *)
(*  inconsistent axiom:                                                  *)
(*                                                                       *)
(*     |- Wonk = !x y:*. x=y                                             *)
(*                                                                       *)
(* ===================================================================== *)
