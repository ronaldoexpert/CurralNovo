/*
----- 1.6.0 -----
- Grava Cria na mesma tabela de Animal (09/11/2018 - RS)
- Grava foto no banco de dados em campo blob (09/11/2018 - RS)
- Faz o calculo da idade da cria (09/11/2018 - RS)

----- 1.6.0 -----
- Faz movimentação de produto diversos (20/11/2018 - RS)
- Criação do campo no cadastro de produto para saber se é semem ou não (20/11/2018 - RS)

----- 1.6.1 -----
- Criado o movimento de estoque de produto (20/11/2018 - RS)

----- 1.6.2 -----
- Corrigido problema da tela de login ficar aberta ao minimizar tela principal (09/01/2019 - RS)

----- 1.6.3 -----
- CadProprietario, Inserido edit para colocar qual a propriedade (16/01/2019 - RS)

----- 1.6.4 -----
- Opção para imprimir relatorio individual de cria como paisagem (19/03/2019 - RS)

*/

INSERT INTO VERSAO VALUES(6, '11/09/2018', 'Versao 1.6');


ALTER TABLE ANIMAL ADD TIPO VARCHAR(10);
UPDATE ANIMAL SET TIPO = 'Animal';
ALTER TABLE ANIMAL ADD PAI INTEGER;
ALTER TABLE ANIMAL ADD MAE INTEGER;
ALTER TABLE ANIMAL ADD DATA_NASCIMENTO DATE;
ALTER TABLE ANIMAL ADD IDADE VARCHAR(30);
ALTER TABLE ANIMAL ADD OBSERVACAO BLOB;
ALTER TABLE ANIMAL ADD FOTOANIMAL BLOB;
ALTER TABLE PRODUTOR ADD PROPRIEDADE VARCHAR(100);


/*** 1.6.1 ***/
ALTER TABLE PRODUTO ADD SEMEM VARCHAR(1);
UPDATE PRODUTO SET SEMEM = 'S';

