signature CoreKernel = sig
  structure Tag  : Tag
  structure Type : Type
  structure Term : Term             where type hol_type = Type.hol_type

  structure Thm  : Thm              where type hol_type = Type.hol_type
                                      and type term     = Term.term
                                      and type tag      = Tag.tag

  structure Theory : Theory         where type hol_type = Type.hol_type
                                      and type term     = Term.term
                                      and type thm      = Thm.thm

  structure TheoryPP : TheoryPP     where type hol_type = Type.hol_type
                                      and type thm      = Thm.thm

  structure Net : Net               where type term = Term.term

  structure Definition : Definition where type term = Term.term
                                      and type thm  = Thm.thm
end;
