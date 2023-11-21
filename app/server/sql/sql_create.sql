-- Active: 1700573411126@@127.0.0.1@3306@7code
CREATE DATABASE  7Code;

USE  7Code;
CREATE TABLE USER (
    CPF BIGINT not null PRIMARY KEY,
    NOME VARCHAR(90) NOT NULL,
    EMAIL VARCHAR(90) NOT NULL,
    SENHA VARCHAR(90) NOT NULL,
    DATA_NASC DATE
);
CREATE TABLE BANKACCOUNT (
    ACCOUNT_ID INT PRIMARY KEY AUTO_INCREMENT,
    CPF BIGINT,
    SALDO DECIMAL(10,2) DEFAULT 0.00,
    ACCOUNT_TYPE VARCHAR(80) DEFAULT 'CORRENTE',
    IS_ENABLE BIT DEFAULT 1,
    DATA_ABERTURA DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (CPF) REFERENCES USER(CPF)
);
CREATE TABLE USERPHOTO (
    ID_PHOTO INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL ,
    CAMINHO VARCHAR(255) NOT NULL,
    CPF BIGINT,
    FOREIGN KEY (CPF) REFERENCES USER(CPF)
);


DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_USER`(
    CPF_USER BIGINT,
    NOME_USER VARCHAR(90),
    EMAIL_USER VARCHAR(90),
    DATA_NASC_USER DATE,
    SENHA_USER VARCHAR(90)
)
BEGIN
    INSERT INTO user (CPF, NOME, EMAIL, DATA_NASC, SENHA) VALUES (
        CPF_USER,
        NOME_USER,
        EMAIL_USER,
        DATA_NASC_USER,
        SENHA_USER
    );
END;
//
DELIMITER;


DELIMITER //
CREATE TRIGGER trig_user_insert
AFTER INSERT ON USER
FOR EACH ROW
BEGIN
    -- Gera um ACCOUNT_ID aleatório
    SET @account_id := FLOOR(RAND() * 1000000000) + 1;


    -- Insere os dados na tabela BANKACCOUNT
    INSERT INTO BANKACCOUNT (CPF, ACCOUNT_ID)
    VALUES (NEW.CPF, @account_id);

END;
//
DELIMITER ;

SELECT * FROM USER;
SELECT * FROM bankaccount;

select * from userPhoto