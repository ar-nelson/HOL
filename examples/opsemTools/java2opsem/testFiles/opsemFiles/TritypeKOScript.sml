(* This file has been generated by java2opSem from /home/helen/Recherche/hol/HOL/examples/opsemTools/java2opsem/testFiles/javaFiles/TritypeKO.java*)


open HolKernel Parse boolLib
stringLib IndDefLib IndDefRules
finite_mapTheory relationTheory
newOpsemTheory
computeLib bossLib;

val _ = new_theory "TritypeKO";

(* Method tritype*)
val MAIN_def =
  Define `MAIN =
    RSPEC
    (\state.
      ((ScalarOf (state ' "i")>=0)/\(ScalarOf (state ' "j")>=0)/\(ScalarOf (state ' "k")>=0)))
      (Seq
        (Assign "trityp" (Const 0))
        (Seq
          (Cond
            (Or
              (Or
                (Equal
                  (Var "i")
                  (Const 0)
                )
                (Equal
                  (Var "j")
                  (Const 0)
                )
              )
              (Equal
                (Var "k")
                (Const 0)
              )
            )
            (Assign "trityp"
              (Const 4)
            )
            (Seq
              (Assign "trityp"
                (Const 0)
              )
              (Seq
                (Cond
                  (Equal
                    (Var "i")
                    (Var "j")
                  )
                  (Assign "trityp"
                    (Plus
                      (Var "trityp")
                      (Const 1)
                    )
                  )
                  Skip
                )
                (Seq
                  (Cond
                    (Equal
                      (Var "i")
                      (Var "k")
                    )
                    (Assign "trityp"
                      (Plus
                        (Var "trityp")
                        (Const 2)
                      )
                    )
                    Skip
                  )
                  (Seq
                    (Cond
                      (Equal
                        (Var "j")
                        (Var "k")
                      )
                      (Assign "trityp"
                        (Plus
                          (Var "trityp")
                          (Const 3)
                        )
                      )
                      Skip
                    )
                    (Cond
                      (Equal
                        (Var "trityp")
                        (Const 0)
                      )
                      (Cond
                        (Or
                          (Or
                            (LessEq
                              (Plus
                                (Var "i")
                                (Var "j")
                              )
                              (Var "k")
                            )
                            (LessEq
                              (Plus
                                (Var "j")
                                (Var "k")
                              )
                              (Var "i")
                            )
                          )
                          (LessEq
                            (Plus
                              (Var "i")
                              (Var "k")
                            )
                            (Var "j")
                          )
                        )
                        (Assign "trityp"
                          (Const 4)
                        )
                        (Assign "trityp"
                          (Const 1)
                        )
                      )
                      (Cond
                        (Less
                          (Const 3)
                          (Var "trityp")
                        )
                        (Assign "trityp"
                          (Const 3)
                        )
                        (Cond
                          (And
                            (Equal
                              (Var "trityp")
                              (Const 1)
                            )
                            (Less
                              (Var "k")
                              (Plus
                                (Var "i")
                                (Var "j")
                              )
                            )
                          )
                          (Assign "trityp"
                            (Const 2)
                          )
                          (Cond
                            (And
                              (Equal
                                (Var "trityp")
                                (Const 1)
                              )
                              (Less
                                (Var "j")
                                (Plus
                                  (Var "i")
                                  (Var "k")
                                )
                              )
                            )
                            (Assign "trityp"
                              (Const 2)
                            )
                            (Cond
                              (And
                                (Equal
                                  (Var "trityp")
                                  (Const 3)
                                )
                                (Less
                                  (Var "i")
                                  (Plus
                                    (Var "j")
                                    (Var "k")
                                  )
                                )
                              )
                              (Assign "trityp"
                                (Const 2)
                              )
                              (Assign "trityp"
                                (Const 4)
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
          )
          (Assign "Result"
            (Var "trityp")
          )
        )
      )
    (\state1 state2.
      (((((ScalarOf (state1 ' "i")+ScalarOf (state1 ' "j"))<=ScalarOf (state1 ' "k"))\/((ScalarOf (state1 ' "j")+ScalarOf (state1 ' "k"))<=ScalarOf (state1 ' "i"))\/((ScalarOf (state1 ' "i")+ScalarOf (state1 ' "k"))<=ScalarOf (state1 ' "j")))) ==> (((ScalarOf (state2 ' "Result")=4))))/\(((~(((ScalarOf (state1 ' "i")+ScalarOf (state1 ' "j"))<=ScalarOf (state1 ' "k"))\/((ScalarOf (state1 ' "j")+ScalarOf (state1 ' "k"))<=ScalarOf (state1 ' "i"))\/((ScalarOf (state1 ' "i")+ScalarOf (state1 ' "k"))<=ScalarOf (state1 ' "j")))/\((ScalarOf (state1 ' "i")=ScalarOf (state1 ' "j"))/\(ScalarOf (state1 ' "j")=ScalarOf (state1 ' "k"))))) ==> (((ScalarOf (state2 ' "Result")=3))))/\(((~(((ScalarOf (state1 ' "i")+ScalarOf (state1 ' "j"))<=ScalarOf (state1 ' "k"))\/((ScalarOf (state1 ' "j")+ScalarOf (state1 ' "k"))<=ScalarOf (state1 ' "i"))\/((ScalarOf (state1 ' "i")+ScalarOf (state1 ' "k"))<=ScalarOf (state1 ' "j")))/\~((ScalarOf (state1 ' "i")=ScalarOf (state1 ' "j"))/\(ScalarOf (state1 ' "j")=ScalarOf (state1 ' "k")))/\((ScalarOf (state1 ' "i")=ScalarOf (state1 ' "j"))\/(ScalarOf (state1 ' "j")=ScalarOf (state1 ' "k"))\/(ScalarOf (state1 ' "i")=ScalarOf (state1 ' "k"))))) ==> (((ScalarOf (state2 ' "Result")=2))))/\(((~(((ScalarOf (state1 ' "i")+ScalarOf (state1 ' "j"))<=ScalarOf (state1 ' "k"))\/((ScalarOf (state1 ' "j")+ScalarOf (state1 ' "k"))<=ScalarOf (state1 ' "i"))\/((ScalarOf (state1 ' "i")+ScalarOf (state1 ' "k"))<=ScalarOf (state1 ' "j")))/\~((ScalarOf (state1 ' "i")=ScalarOf (state1 ' "j"))/\(ScalarOf (state1 ' "j")=ScalarOf (state1 ' "k")))/\~((ScalarOf (state1 ' "i")=ScalarOf (state1 ' "j"))\/(ScalarOf (state1 ' "j")=ScalarOf (state1 ' "k"))\/(ScalarOf (state1 ' "i")=ScalarOf (state1 ' "k"))))) ==> (((ScalarOf (state2 ' "Result")=1)))))
    `

    val intVar_def =
  	     Define `intVar =["i";"j";"k";"trityp";"Result"]  `

    val arrVar_def =
  	     Define `arrVar =[]: string list  `

  val _ = export_theory();
