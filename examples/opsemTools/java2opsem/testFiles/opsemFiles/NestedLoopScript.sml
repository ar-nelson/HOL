(* This file has been generated by java2opSem from /usr/local/provers/HOL/examples/opsemTools/java2opsem/testFiles/javaFiles/NestedLoop.java*)


open HolKernel Parse boolLib
stringLib IndDefLib IndDefRules
finite_mapTheory relationTheory
newOpsemTheory
computeLib bossLib;

val _ = new_theory "NestedLoop";

(* Method nestedLoop*)
val MAIN_def =
  Define `MAIN =
    RSPEC
    (\state.
      T)
      (Seq
        (Assign "s"
          (Const 0)
        )
        (Seq
          (Assign "i"
            (Const 1)
          )
          (Seq
            (While 
              (LessEq 
                (Var "i")
                (Var "n")
              )
              (Seq
                (Assign "j"
                  (Const 1)
                )
                (Seq
                  (While 
                    (LessEq 
                      (Var "j")
                      (Var "n")
                    )
                    (Seq
                      (Assign "s"
                        (Plus 
                          (Var "s")
                          (Const 1)
                        )
                      )
                      (Assign "j"
                        (Plus 
                          (Var "j")
                          (Const 1)
                        )
                      )
                    )
                  )
                  (Assign "i"
                    (Plus 
                      (Var "i")
                      (Const 1)
                    )
                  )
                )
              )
            )
            (Assign "Result"
              (Var "s")
            )
          )
        )
      )
    (\state1 state2.
      (ScalarOf (state2 ' "Result")=ScalarOf (state1 ' "n")*ScalarOf (state1 ' "n")))
    `

  val _ = export_theory();
