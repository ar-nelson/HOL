(* This file has been generated by java2opSem from /home/helen/Recherche/hol/HOL/examples/opsemTools/java2opsem/testFiles/javaFiles/PartitionKO1.java*)


open HolKernel Parse boolLib
stringLib IndDefLib IndDefRules
finite_mapTheory relationTheory
newOpsemTheory
computeLib bossLib;

val _ = new_theory "PartitionKO1";

(* Method partition*)
val MAIN_def =
  Define `MAIN =
    RSPEC
    (\state.
      (ScalarOf (state ' "i")<ScalarOf (state ' "j"))/\(0<=ScalarOf (state ' "i"))/\(ScalarOf (state ' "i")<ScalarOf (state ' "aLength"))/\(0<=ScalarOf (state ' "j"))/\(ScalarOf (state ' "j")<ScalarOf (state ' "aLength")))
      (Seq
        (Assign "pivot"
          (Arr "a"
            (Var "i")
          )
        )
        (Seq
          (Assign "p"
            (Var "i")
          )
          (Seq
            (Assign "k"
              (Plus
                (Var "i")
                (Const 1)
              )
            )
            (Seq
              (While
                (LessEq
                  (Var "k")
                  (Var "j")
                )
                (Seq
                  (Cond
                    (Less
                      (Arr "a"
                        (Var "k")
                      )
                      (Var "pivot")
                    )
                    (Seq
                      (Assign "tmp"
                        (Arr "a"
                          (Var "p")
                        )
                      )
                      (Seq
                        (ArrayAssign "a"
                          (Var "p")
                          (Arr "a"
                            (Var "k")
                          )
                        )
                        (ArrayAssign "a"
                          (Var "k")
                          (Var "tmp")
                        )
                      )
                    )
                    Skip
                  )
                  (Assign "k"
                    (Plus
                      (Var "k")
                      (Const 1)
                    )
                  )
                )
              )
              (Seq
                (Assign "tmp2"
                  (Arr "a"
                    (Var "p")
                  )
                )
                (Seq
                  (ArrayAssign "a"
                    (Var "p")
                    (Arr "a"
                      (Var "i")
                    )
                  )
                  (Seq
                    (ArrayAssign "a"
                      (Var "i")
                      (Var "tmp2")
                    )
                    (Assign "Result"
                      (Var "p")
                    )
                  )
                )
              )
            )
          )
        )
      )
    (\state1 state2.
      ((0<=ScalarOf (state2 ' "Result"))/\(ScalarOf (state2 ' "Result")<ScalarOf (state1 ' "aLength")))/\(!i . ((0<=i)/\(i<Num(ScalarOf (state2 ' "Result"))))==>(((ArrayOf (state2 ' "a") ' (i))<(ArrayOf (state2 ' "a") ' (Num(ScalarOf (state2 ' "Result")))))))/\(!i . ((Num(ScalarOf (state2 ' "Result"))<i)/\(i<Num(ScalarOf (state1 ' "aLength"))))==>(((ArrayOf (state2 ' "a") ' (i))>=(ArrayOf (state2 ' "a") ' (Num(ScalarOf (state2 ' "Result"))))))))
    `

  val _ = export_theory();
