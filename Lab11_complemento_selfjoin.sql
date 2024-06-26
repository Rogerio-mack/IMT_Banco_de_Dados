DROP DATABASE SELFTESTE;
CREATE DATABASE SELFTESTE;
USE SELFTESTE;

CREATE TABLE DEPTO(
E_NAME VARCHAR(10),
E_ID INT,
S_ID INT,
PRIMARY KEY (E_ID),
FOREIGN KEY (S_ID) references DEPTO(E_ID)
);

INSERT INTO DEPTO VALUES('DANIEL',1,1);
INSERT INTO DEPTO VALUES('ANNA',2,1);
INSERT INTO DEPTO VALUES('HENRIQUE',3,1);
INSERT INTO DEPTO VALUES('LUCIA',4,3);
INSERT INTO DEPTO VALUES('ADRIANA',5,3);

SELECT D1.E_NAME, D1.E_ID, D2.E_NAME AS 'SUPERVISOR', D2.E_ID AS 'ID_SUPERVISOR'
FROM DEPTO AS D1 JOIN DEPTO AS D2 ON D1.S_ID=D2.E_ID;

-- CUIDADO!
-- SELECT D1.E_NAME, D1.E_ID, D2.E_NAME AS 'SUPERVISOR', D2.E_ID AS 'ID_SUPERVISOR'
-- FROM DEPTO AS D1 JOIN DEPTO AS D2 ON D1.S_ID=D2.E_ID;

CREATE TABLE EMPRESA(
E_NAME VARCHAR(10),
E_ID INT,
E_DEPT VARCHAR(10),
E_LOC VARCHAR(10)
);
INSERT INTO EMPRESA VALUES('DANIEL',1,'RH','SP');
INSERT INTO EMPRESA VALUES('DANIEL',1,'VENDAS','SP');
INSERT INTO EMPRESA VALUES('ANNA',2,'TI','RJ');
INSERT INTO EMPRESA VALUES('ANNA',2,'MARKETING','SP');
INSERT INTO EMPRESA VALUES('HENRIQUE',3,'FINANCAS','RS');
INSERT INTO EMPRESA VALUES('HENRIQUE',3,'FINANCAS','RS');

SELECT E1.E_NAME, E1.E_ID, E1.E_DEPT, E1.E_LOC 
FROM EMPRESA AS E1 JOIN EMPRESA AS E2 ON E1.E_ID=E2.E_ID ;

SELECT E1.E_NAME, E1.E_ID, E1.E_DEPT, E1.E_LOC 
FROM EMPRESA AS E1 JOIN EMPRESA AS E2 ON E1.E_ID=E2.E_ID
WHERE E1.E_DEPT<>E2.E_DEPT AND E1.E_LOC<>E2.E_LOC;




