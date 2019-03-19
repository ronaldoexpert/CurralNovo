SET TERM ^ ;
  CREATE TRIGGER SUB_ESTOQUE_PRODUTO_ANIMAL FOR MOVI_INSEMINACAO
    ACTIVE
    BEFORE INSERT
    POSITION 0
  AS
  BEGIN
      UPDATE ANIMAL A SET A.ESTOQUE = A.ESTOQUE - 1 WHERE (NEW.ID_ANIMAL = (Select id_touro from INSEMINACAO));
      UPDATE PRODUTO P SET P.ESTOQUE = P.ESTOQUE - 1 WHERE (NEW.ID_PRODUTO = P.ID);
  END^
  SET TERM; ^