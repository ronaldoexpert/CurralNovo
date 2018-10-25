/*
-- 1.1.0 --
- Criado trigger para dar entrada ou saida em estoque de produto e semem de animal (16/05/2018)
- Função para inserir em movi_produto para ativar a TRIGGER  (16/05/2018)
- Alterado o campo identificação parar aceitar letras (04/06/2018)

-- 1.1.1 --
- Corrigido erro quando filtrava por proprietário na confirmação da inseminação (15/06/2018)


*/


ALTER TABLE MOVI_PRODUTO ADD ID_INSEMINACAO INTEGER;
ALTER TABLE MOVI_PRODUTO ADD CONSTRAINT FK_ID_MOVI_INSEMINACAO FOREIGN KEY (ID_INSEMINACAO) REFERENCES INSEMINACAO (ID) on delete cascade;


/*** 25/05/2018 ***/
ALTER TABLE INSEMINACAO ADD NOMETOURO VARCHAR(50);
UPDATE INSEMINACAO SET NOMETOURO = (SELECT A.NOME FROM ANIMAL A WHERE A.ID = ID_TOURO);

/*** 04/06/2018 ***/
alter table ANIMAL alter column IDENTIFICACAO TYPE VARCHAR(30)