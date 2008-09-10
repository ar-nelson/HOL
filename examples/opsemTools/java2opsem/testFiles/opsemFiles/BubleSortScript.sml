(* This file has been generated by java2opSem from /usr/local/provers/HOL/examples/opsemTools/java2opsem/testFiles/javaFiles/BubleSort.java*)


open HolKernel Parse boolLib
stringLib IndDefLib IndDefRules
finite_mapTheory relationTheory
newOpsemTheory
computeLib bossLib;

val _ = new_theory "BubleSort";

(* Method bubbleSort*)
val MAIN_def =
  Define `MAIN =
    RSPEC
    (\state.
      T)
      (Seq
        (Assign "i"
          (Const 0)
        )
        (Seq
          (Assign "j"
            (Sub 
              (Var "aLength")
              (Const 1)
            )
          )
          (Seq
            (Assign "aux"
              (Const 0)
            )
            (Seq
              (Assign "stop"
                (Const 0)
              )
              (While 
                (Equal 
                  (Var "stop")
                  (Const 0)
                )
                (Seq
                  (Assign "stop"
                    (Const 1)
                  )
                  (Seq
                    (Assign "i"
                      (Const 0)
                    )
                    (Seq
                      (While 
                        (Less 
                          (Var "i")
                          (Var "j")
                        )
                        (Seq
                          (Cond 
                            (Less 
                              (Arr "a"
                                (Plus 
                                  (Var "i")
                                  (Const 1)
                                )
                              )
                              (Arr "a"
                                (Var "i")
                              )
                            )
                            (Seq
                              (Assign "aux"
                                (Arr "a"
                                  (Var "i")
                                )
                              )
                              (Seq
                                (ArrayAssign "a"
                                  (Var "i")
                                  (Arr "a"
                                    (Plus 
                                      (Var "i")
                                      (Const 1)
                                    )
                                  )
                                )
                                (Seq
                                  (ArrayAssign "a"
                                    (Plus 
                                      (Var "i")
                                      (Const 1)
                                    )
                                    (Var "aux")
                                  )
                                  (Assign "stop"
                                    (Const 0)
                                  )
                                )
                              )
                            )
                            Skip
                          )
                          (Assign "i"
                            (Plus 
                              (Var "i")
                              (Const 1)
                            )
                          )
                        )
                      )
                      (Assign "j"
                        (Sub 
                          (Var "j")
                          (Const 1)
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    (\state1 state2.
      (!i . (((i>=0)/\(i<ScalarOf (state1 ' "aLength")-1)))==>(((ArrayOf (state2 ' "a") ' (i))<=(ArrayOf (state2 ' "a") ' (i+1))))))
    `

  val _ = export_theory();
