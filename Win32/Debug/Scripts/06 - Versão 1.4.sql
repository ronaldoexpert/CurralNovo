/*
-- 1.4.0 --
- Opção para marcar o animal como morto (14/10/2018)

*/

INSERT INTO VERSAO VALUES(4, '10/14/2018', 'Versao 1.4');

Alter table ANIMAL add MORTO VARCHAR(1);
UPDATE ANIMAL SET MORTO = 'N'

Alter table ANIMAL add DT_MORTE TIMESTAMP;
UPDATE ANIMAL SET DT_MORTE = '01/01/1900';