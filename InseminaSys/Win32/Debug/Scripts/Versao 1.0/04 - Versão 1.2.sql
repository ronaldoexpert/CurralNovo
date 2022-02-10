/*
-- 1.2.0 --
- Criação do log por arquivo de texto (04/07/2018)
- Criação da tabela para controle de versão (04/07/2018)

*/

Create table VERSAO (
ID INTEGER NOT NULL PRIMARY KEY,
DATA_ATUALIZACAO TIMESTAMP,
VERSAO VARCHAR(20)
);

INSERT INTO VERSAO VALUES(1, '05/16/2018', 'Versao 1.1');
INSERT INTO VERSAO VALUES(2, '07/04/2018', 'Versao 1.2');