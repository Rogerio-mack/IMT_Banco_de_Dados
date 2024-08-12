-- CERTIFICACOES CISCO 2023
/* Esquema do BD Controle de Certificacoes
Modulo ( sigla_modulo(PK), Nome_modulo, Carga_Horaria , Sigla_cert(FK))
Aluno ( num_matricula(pk), nome_aluno, sexo_aluno, end_aluno, fone_aluno )
Certificacao ( Sigla_cert(PK), Nome_Cert, Descr_cert, Carga_Horaria_Total)
Aluno_Modulo ( num_matricula(PK)(FK), sigla_modulo(PK)(FK), trimestre_cursado(PK), nota_final, freq_final, resultado_final)
               num_matricula referencia Aluno
               sigla_modulo referencia Modulo
Instrutor ( cod_instrutor(pk), nome_instr, sexo_instr, end_instr, fone_instr)
Aluno_certificacao( num_matricula(PK)(FK), sigla_cert(PK)(FK), dt_conclusao)
               num_matricula referencia Aluno
               sigla_cert referencia certificacao
Instrutor_modulo ( cod_instr(PK)(FK), sigla_modulo(PK)(FK), dt_inicio_leciona(PK), dt_termino_leciona)
               cod_instr referencia Instrutor
               sigla_modulo referencia Modulo
Instrutor_certificacao ( cod_instr(PK)(FK), sigla_cert(PK)(FK), local_cert, dt_conclusao_cert)
               cod_instr referencia Instrutor
               sigla_cert referencia certificacao
         
*/

-- create database tti204
drop database if exists tti204;
create database tti204;
use tti204;
SET GLOBAL lc_time_names=pt_BR;
SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1 ;

/* desabilita 
SET foreign_key_checks = 0;
SET SQL_SAFE_UPDATES = 0; */

-- excluindo as tabelas que tenham FKs
DROP TABLE IF EXISTS aluno_modulo CASCADE ;
DROP TABLE IF EXISTS aluno_certificacao CASCADE ;
DROP TABLE IF EXISTS instrutor_modulo CASCADE ;
DROP TABLE IF EXISTS instrutor_certificacao CASCADE;
DROP TABLE IF EXISTS certificacoes_instrutor CASCADE;
DROP TABLE IF EXISTS modulo CASCADE;
DROP TABLE IF EXISTS aluno CASCADE; 
DROP TABLE IF EXISTS certificacao CASCADE; 
DROP TABLE IF EXISTS instrutor CASCADE; 

SHOW TABLES ;

-- tabela aluno
CREATE TABLE aluno (
num_matricula INTEGER auto_increment PRIMARY KEY,
Nome_Aluno VARCHAR (30) ,
Sexo_aluno CHAR(1) NOT NULL,
end_aluno VARCHAR (60),
fone_aluno NUMERIC(11)) ENGINE = InnoDB;

DESC aluno;
INSERT INTO aluno VALUES (null,'João Ricardo','m','Rua Alfa,10', 1199887761);
INSERT INTO aluno VALUES (0,'Maria Silva','F','Rua Beta,10',1199887762 ); 
INSERT INTO aluno VALUES (null,'Ari Pereira Jr','M','Rua Beta,10', 1199887763 ); 
 
SELECT * FROM aluno ;

UPDATE aluno SET sexo_aluno = 'M' WHERE num_matricula = 1 ;
                              
INSERT INTO aluno VALUES (0,'Rita Tavares','F','Rua Delta,20', 1199887764);
INSERT INTO aluno VALUES (0,'Jorge Matos','M','Rua Beta,10', 1199887765);
INSERT INTO aluno VALUES (0,'Talita Franco','F','Rua Zeta Beta,30', 1199887766);
INSERT INTO aluno VALUES (0,'Walter Severo','M','Rua Beta,10', 1199887767);
INSERT INTO aluno VALUES (0,'João Gomes','M','Rua Omega,20', 1199887726);
INSERT INTO aluno VALUES (0,'Cristina Silva','F','Rua Gama,10', 1199887366 );                                         
INSERT INTO aluno VALUES (0,'Alvaro Susuki','M','Rua Gama,10', 1199887466 );                                    
INSERT INTO aluno VALUES (0,'Petronio Peres','F','Rua Zeta,30', 1199887566);
INSERT INTO aluno VALUES (0,'Pedro Tadeu Boker','M','Rua Phi,30', 1199887066);
INSERT INTO aluno VALUES (0,'Carla Talarico Freitas','F','Rua Kapa,30', 1199881766 );                                         
INSERT INTO aluno VALUES (0,'Aldo Martins','M','Rua Phi,30', 1199887366 );                                    
INSERT INTO aluno VALUES (0,'Sandra Rosa e Cruz','F','Rua Zeta,30', 1199887866);
INSERT INTO aluno VALUES (0,'Ana Carolina Sa','F','Rua Alfa,10', 1199817766);
INSERT INTO aluno VALUES (0,'Ricardo Neves','M','Rua Gama,10', 1199827766 );                                         
INSERT INTO aluno VALUES (0,'Roberto Carlos Schimidt','M','Rua Zeta,30', 1199387766 );                                    
INSERT INTO aluno VALUES (0,'Cristovao Buarque de Holanda','M','Rua Omega,20', 1199487766);

SELECT * FROM aluno ;

-- verificando o proximo numero da sequencia
SELECT Auto_increment 
FROM information_schema.tables 
WHERE table_name='aluno';

-- tabela certificacao 
CREATE TABLE certificacao
( sigla_cert CHAR(5) PRIMARY KEY, 
nome_cert VARCHAR(60) NOT NULL ,
descr_cert VARCHAR(200) NOT NULL ,
carga_horaria_total SMALLINT ) ENGINE = InnoDB ;

INSERT INTO certificacao VALUES ( 'CCENT' , 'Cisco Certified Entry Networking Technician', 'Redes', 140) ;
INSERT INTO certificacao VALUES ( 'CCNP' , 'Cisco Certified Network Professional', 'Redes', 280) ;
INSERT INTO certificacao VALUES ( 'CCNA' , 'Cisco Certified Network Associate', 'Redes', 280) ;

SELECT * FROM certificacao ;

-- tabela modulo
CREATE TABLE modulo (
sigla_modulo CHAR(5) PRIMARY KEY,
Nome_modulo VARCHAR(60) NOT NULL,
descr_modulo VARCHAR(200) NOT NULL ,
Carga_horaria_modulo SMALLINT,
sigla_cert CHAR(5) NOT NULL,
FOREIGN KEY (sigla_cert)  REFERENCES certificacao (sigla_cert)
ON DELETE CASCADE ON UPDATE CASCADE ) ENGINE = InnoDB ;

INSERT INTO modulo VALUES ('ICND1','Interconexão de Dispositivos de Redes Cisco - Básico', 'Redes', 160, 'CCNA'  );
INSERT INTO modulo VALUES ('ICND2','Interconexão de Dispositivos de Redes Cisco - Avançado','Redes',160 , 'CCNP' );
INSERT INTO modulo VALUES ('CCNA1','Noções Básicas de Redes','Redes',80, 'CCNA' );
INSERT INTO modulo VALUES ('CCNA2','Conceitos e Protocolos de roteamento','Redes',80, 'CCNA' );
INSERT INTO modulo VALUES ('CCNA3','LAN Switching e Wireless','Redes',80, 'CCNP'  );
INSERT INTO modulo VALUES ('CCNA4','Acesso à WAN','Redes',80, 'CCNP' );
INSERT INTO modulo VALUES ('CCNP1','Capacitação em Roteamento(Routing) Avançado','Redes', 80, 'CCENT');
INSERT INTO modulo VALUES ('CCNP2', 'Capacitação em Acesso Remoto','Redes',80, 'CCENT');
INSERT INTO modulo VALUES ('CCNP3', 'Capacitação em Swithces Multi-Layer','Redes',80, 'CCENT' );
INSERT INTO modulo VALUES ('CCNP4', 'Capacitação em Resolução de Problemas de Redes','Redes',80, 'CCNP' );

-- tabela aluno cursa modulo
CREATE TABLE aluno_modulo
( num_matricula integer NOT NULL ,
  sigla_modulo CHAR(5) NOT NULL  ,
  trimestre_cursado CHAR(6) NOT NULL,
  nota_final NUMERIC(5,2),
  freq_final NUMERIC(5,2),
  resultado_final CHAR(15),
  CONSTRAINT cursa_modulo_pkey PRIMARY KEY (num_matricula, sigla_modulo, trimestre_cursado),
  FOREIGN KEY (num_matricula) REFERENCES aluno (num_matricula) 
              ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (sigla_modulo) REFERENCES modulo (sigla_modulo)  
              ON DELETE CASCADE ON UPDATE CASCADE ) ;
  
INSERT INTO aluno_modulo VALUES (1,'ICND1','2020-1',9.0,54,'ReproFalta'); -- ok
INSERT INTO aluno_modulo VALUES (2,'ICND2','2020-2',4.0,95,'ReproNota' );
INSERT INTO aluno_modulo VALUES (3,'ICND2','2021-1',7.5,83,'Aprovado' );                                                                
INSERT INTO aluno_modulo VALUES (4,'CCNP1','2020-1',7.0,92, 'Aprovado' );                                         
INSERT INTO aluno_modulo VALUES (5,'ICND2','2022-1',8.0,69,'ReproFalta'  );                                    
INSERT INTO aluno_modulo VALUES (6,'ICND1','2020-2',5.0,67,'ReproFalta' );                                         
INSERT INTO aluno_modulo VALUES (7,'CCNA2','2021-2',6.0,79, 'Aprovado');                                    
INSERT INTO aluno_modulo VALUES (8,'ICND2','2022-1',7.5,89,'Aprovado' );                                         
INSERT INTO aluno_modulo VALUES (9,'ICND1','2020-2',8.0,92,'Aprovado' );                                    
INSERT INTO aluno_modulo VALUES (10,'CCNP2','2021-1',7.0,83, 'Aprovado' );                                         
INSERT INTO aluno_modulo VALUES (11,'ICND2','2022-2',8.0,54,'Cursando'  );                                    
INSERT INTO aluno_modulo VALUES (12,'ICND1','2020-3',5.0,67,'ReproFalta' );                                         
INSERT INTO aluno_modulo VALUES (12,'ICND1','2020-1',6.0,92,'Aprovado' );                                         
INSERT INTO aluno_modulo VALUES (13,'CCNA3','2022-2',6.0,83, 'Cursando');                                    
INSERT INTO aluno_modulo VALUES (14,'ICND1','2021-2',9.0,67,'ReproFalta');
INSERT INTO aluno_modulo VALUES (15,'CCNA3','2023-4',4.0,83,'ReproNota' );
INSERT INTO aluno_modulo VALUES (15,'ICND1','2020-2',9.0,92,'Aprovado');
INSERT INTO aluno_modulo VALUES (16,'ICND2','2020-1',9.5,89,'Aprovado');
INSERT INTO aluno_modulo VALUES (16,'CCNA2','2021-4',4.0,95,'ReproNota' );
INSERT INTO aluno_modulo VALUES (17,'CCNA1','2020-1',7.5,95,'Aprovado' );                                         
INSERT INTO aluno_modulo VALUES (18,'CCNA2','2021-1',7.0,100, 'Aprovado' );                                         
INSERT INTO aluno_modulo VALUES (19,'CCNA3','2020-1',9.0,92, 'Aprovado' );                                         
INSERT INTO aluno_modulo VALUES (1,'CCNA4','2023-1',10.0,79, 'Aprovado' );                                        
INSERT INTO aluno_modulo VALUES (4,'CCNA1','2020-2',7.0,89,'Aprovado'  );                                   
INSERT INTO aluno_modulo VALUES (4,'CCNA3','2020-4',9.0,83, 'Aprovado');
INSERT INTO aluno_modulo VALUES (5,'CCNA1','2021-2',9.0,79, 'Aprovado');
INSERT INTO aluno_modulo VALUES (5,'CCNA2','2021-1',6.5,89,'Aprovado' );
INSERT INTO aluno_modulo VALUES (6,'ICND1','2023-2',6.0,100,'Aprovado' );                                         
INSERT INTO aluno_modulo VALUES (6,'CCNA3','2020-2',3.0,79, 'ReproNota'); 
INSERT INTO aluno_modulo VALUES (7,'ICND2','2022-1',4.5,79,'ReproNota' );
INSERT INTO aluno_modulo VALUES (7,'CCNA1','2021-2',9.0,95, 'Aprovado');                               
INSERT INTO aluno_modulo VALUES (11,'ICND2','2021-3',2.5,95,'ReproNota' );
INSERT INTO aluno_modulo VALUES (12,'ICND2','2020-1',6.0,64,'ReproFalta' );  
INSERT INTO aluno_modulo VALUES (12,'ICND2','2020-2',6.0,100,'Aprovado' );  

SELECT * FROM aluno_modulo ;

-- tabela aluno cursa certificacao - precisou turar os nomes das constraints
CREATE TABLE aluno_certificacao
( num_matricula integer NOT NULL,
  sigla_cert CHAR(5) NOT NULL,
  dt_matricula DATE,
  dt_conclusao DATE,
  CONSTRAINT cursa_cert_pkey PRIMARY KEY (num_matricula, sigla_cert),
  FOREIGN KEY (sigla_cert) REFERENCES certificacao (sigla_cert) 
       ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (num_matricula) REFERENCES aluno (num_matricula) 
      ON DELETE CASCADE ON UPDATE CASCADE  ) ;


INSERT INTO aluno_certificacao VALUES ( 1, 'CCNA', current_date - INTERVAL '100' DAY, current_date - INTERVAL '70' DAY) ;
INSERT INTO aluno_certificacao VALUES ( 2,  'CCNA', current_date - INTERVAL '90' DAY, current_date - INTERVAL '50' DAY) ;
INSERT INTO aluno_certificacao VALUES ( 3,  'CCNA', current_date - INTERVAL '80' DAY, current_date - INTERVAL '40' DAY) ;
INSERT INTO aluno_certificacao VALUES ( 4, 'CCNP', current_date - INTERVAL '30' DAY, current_date - INTERVAL '10' DAY) ;
INSERT INTO aluno_certificacao VALUES ( 5, 'CCENT', current_date - INTERVAL '20' DAY, current_date - INTERVAL '5' DAY) ;
INSERT INTO aluno_certificacao VALUES ( 1, 'CCNP', current_date - INTERVAL '10' DAY, null) ;
INSERT INTO aluno_certificacao VALUES ( 2,  'CCNP', current_date - INTERVAL '7' DAY, null) ;
INSERT INTO aluno_certificacao VALUES ( 3,  'CCNP', current_date - INTERVAL '3' DAY, null) ;
INSERT INTO aluno_certificacao VALUES ( 4, 'CCENT', current_date - INTERVAL '1' DAY, null ) ;

-- tabela instrutor
CREATE TABLE instrutor (
cod_instrutor NUMERIC(5) PRIMARY KEY,
nome_instrutor VARCHAR (30) ,
Sexo_instrutor CHAR(1) ,
end_instrutor VARCHAR (60),
fone_instrutor NUMERIC(11)) ;

INSERT INTO instrutor VALUES (10,'Julio Ricardo','M','Rua Alfa,40', 1199427760);
INSERT INTO instrutor VALUES (11,'Ana Silva','F','Rua Beta,60',1199787761 );                                         
INSERT INTO instrutor VALUES (12,'Pedro Pereira Jr','M','Rua Beta,50', 11999377662);                                 
INSERT INTO instrutor VALUES (13,'Alessandra Tavares','F','Rua Delta,23', 1199757763);
INSERT INTO instrutor VALUES (14,'Ryck Matos','M','Rua Beta,20', 1199127764);
INSERT INTO instrutor VALUES (15,'Tania Franco','F','Rua Zeta Beta,40', 1198807765);

SELECT * FROM instrutor;

-- tabela instrutor leciona modulo
DROP TABLE instrutor_modulo CASCADE ;
CREATE TABLE instrutor_modulo
( cod_instrutor NUMERIC(5) NOT NULL,
  sigla_modulo CHAR(5) NOT NULL,
  dt_inicio_leciona DATE NOT NULL,
  dt_termino_leciona DATE ,
 PRIMARY KEY (cod_instrutor, sigla_modulo, dt_inicio_leciona),
 FOREIGN KEY (sigla_modulo) REFERENCES modulo (sigla_modulo) 
  ON DELETE CASCADE ON UPDATE CASCADE ,
 FOREIGN KEY (cod_instrutor) REFERENCES instrutor (cod_instrutor)
  ON DELETE CASCADE ON UPDATE CASCADE );

SELECT current_date + INTERVAL '1' MONTH ;

INSERT INTO instrutor_modulo VALUES (10, 'ICND1', STR_TO_DATE("10/03/2023", "%d/%m/%Y" ), null);
INSERT INTO instrutor_modulo VALUES (10, 'ICND2', current_date - INTERVAL  '68' DAY , current_date - INTERVAL  '38' DAY );
INSERT INTO instrutor_modulo VALUES (11, 'CCNA1', current_date - INTERVAL  '100' DAY, current_date - INTERVAL  '70' DAY);
INSERT INTO instrutor_modulo VALUES (11, 'CCNA2', current_date - INTERVAL  '78' DAY, current_date - INTERVAL  '48' DAY); 
INSERT INTO instrutor_modulo VALUES (12, 'CCNA3', current_date - INTERVAL  '100' DAY, current_date - INTERVAL  '70' DAY);
INSERT INTO instrutor_modulo VALUES (12, 'CCNA4', current_date - INTERVAL  '58' DAY, current_date - INTERVAL  '38' DAY);
INSERT INTO instrutor_modulo VALUES (13, 'CCNP1', current_date - INTERVAL  '100' DAY, current_date - INTERVAL  '70' DAY);
INSERT INTO instrutor_modulo VALUES (13, 'CCNP2', current_date - INTERVAL  '48' DAY, current_date - INTERVAL  '28' DAY);
INSERT INTO instrutor_modulo VALUES (14, 'CCNP3', current_date - INTERVAL  '100' DAY, current_date - INTERVAL  '70' DAY);
INSERT INTO instrutor_modulo VALUES (14, 'CCNP4', current_date - INTERVAL  '38' DAY, current_date - INTERVAL  '18' DAY);
INSERT INTO instrutor_modulo VALUES (15, 'ICND1', current_date - INTERVAL  '10' DAY, null);
INSERT INTO instrutor_modulo VALUES (11, 'ICND2', current_date - INTERVAL  '8' DAY, null);

-- DELETE FROM instrutor_modulo ;
-- TRUNCATE TABLE instrutor_modulo ;
SELECT * FROM instrutor_modulo ;
show tables ;
describe instrutor ;

-- tabela instrutor habilitado na certificacao
CREATE TABLE instrutor_certificacao
( cod_instrutor NUMERIC(5) NOT NULL,
  sigla_cert CHAR(5) NOT NULL,
  dt_conclusao DATE NOT NULL,
  local_certificacao VARCHAR(50), 
  CONSTRAINT instr_cert_pkey PRIMARY KEY (cod_instrutor, sigla_cert),
  CONSTRAINT instr_cert_fkey2 FOREIGN KEY (sigla_cert) REFERENCES certificacao (sigla_cert) 
      ON DELETE CASCADE ON UPDATE CASCADE ,
  CONSTRAINT instr_cert_fkey20 FOREIGN KEY (cod_instrutor) REFERENCES instrutor (cod_instrutor) 
      ON DELETE CASCADE ON UPDATE CASCADE )  ENGINE = INNODB ;

INSERT INTO instrutor_certificacao VALUES ( 10, 'CCNA', current_date - INTERVAL '1000' DAY, 'Academia Cisco - Rio de Janeiro');
INSERT INTO instrutor_certificacao VALUES ( 11, 'CCNA', current_date - INTERVAL '500' DAY, 'Academia Cisco - Curitiba');
INSERT INTO instrutor_certificacao VALUES ( 12, 'CCNP', current_date - INTERVAL '500' DAY, 'Academia Cisco - Rio de Janeiro');
INSERT INTO instrutor_certificacao VALUES ( 13, 'CCNP', current_date - INTERVAL '400' DAY, 'Academia Cisco - São Paulo');
INSERT INTO instrutor_certificacao VALUES ( 14, 'CCENT', current_date - INTERVAL '400' DAY, 'Academia Cisco - Campinas');
INSERT INTO instrutor_certificacao VALUES ( 15, 'CCENT', current_date - INTERVAL '300' DAY, 'Academia Cisco - Santos');

SELECT * FROM instrutor_certificacao;

/******************************
Alteração na estrutura das tabelas 
******************************/
-- adicionando e excluindo novas colunas
ALTER TABLE modulo ADD qtde_aulas TINYINT NOT NULL, ADD duracao_aula TINYINT NOT NULL ;
desc modulo ;

ALTER TABLE modulo DROP column qtde_aulas, DROP COLUMN duracao_aula ;

-- mudando o tipo de dado
DESCRIBE instrutor 
ALTER TABLE instrutor MODIFY nome_instrutor CHAR(30) ;

-- adicionando nova coluna 
ALTER TABLE aluno_certificacao ADD situacao_matricula CHAR(15) NOT NULL DEFAULT 'CURSANDO';
desc aluno_certificacao;

-- aumentando o tamanho da coluna
ALTER TABLE aluno MODIFY end_aluno VARCHAR(70) ;

-- mudando o tipo de dado
ALTER TABLE certificacao MODIFY carga_horaria_total integer ;

-- colocando valor default
ALTER TABLE aluno_certificacao MODIFY dt_matricula TIMESTAMP DEFAULT current_timestamp ;
ALTER TABLE instrutor_certificacao MODIFY dt_conclusao TIMESTAMP DEFAULT current_timestamp;

-- renomeando a coluna - clausula CHANGE
DESC aluno_certificacao
ALTER TABLE aluno_certificacao CHANGE dt_matricula dt_hora_matricula TIMESTAMP ; 
ALTER TABLE aluno_certificacao CHANGE dt_hora_matricula dt_matricula TIMESTAMP ; 
-- renomeando uma tabela
SHOW TABLES
ALTER TABLE instrutor_certificacao RENAME instrutor_certificacao_novo;
ALTER TABLE instrutor_certificacao_novo RENAME instrutor_certificacao ;
-- check em situação da matricula

SELECT * FROM aluno ;
SELECT * FROM certificacao ;
desc aluno_certificacao ;
SELECT * FROM aluno_certificacao
WHERE dt_conclusao IS NOT NULL ;
-- atualizando
SET SQL_SAFE_UPDATES = 0;
UPDATE aluno_certificacao 
SET situacao_matricula = 'CONCLUIDO'
WHERE dt_conclusao IS NOT NULL ;

-- populacao aluno matriculado na certificacao -- testando o gatilho do check da situacao
-- deprecated ALTER TABLE aluno_certificacao CHANGE situacao_matricula situacao_matricula CHAR(15) BINARY NOT NULL;
ALTER TABLE aluno_certificacao MODIFY situacao_matricula CHAR(15) COLLATE utf8mb4_bin;

INSERT INTO aluno_certificacao VALUES ( 5, 'CCENT', current_date - INTERVAL '10' DAY, null, 'teste' ) ;
INSERT INTO aluno_certificacao VALUES ( 5, 'CCNP', current_date - INTERVAL '10' DAY, null, 'cursando' ) ;
INSERT INTO aluno_certificacao VALUES ( 5, 'CCNA', current_date - INTERVAL '10' DAY, null, 'CURSANDO' ) ;
SELECT * FROM aluno_certificacao ;
DESC aluno_certificacao ;

/******************************************
testes de integridade referencial
***************************************/
show engines ;
select @@FOREIGN_KEY_CHECKS;

-- falta completar testes alterando uma PK, excluindo uma PK e verificando as Fks correspondentes
SELECT * FROM modulo ;
SELECT * FROM certificacao ;
UPDATE certificacao
SET sigla_cert = 'XYZW'
WHERE sigla_cert = 'CCENT' ;
DELETE FROM certificacao WHERE sigla_cert = 'XYZW' ;

-- instrutor modulo não tem CASCADE
SELECT * FROM instrutor_modulo ;
UPDATE modulo
SET sigla_modulo = '1234'
WHERE sigla_modulo = 'CCNA1' ;

DELETE from modulo WHERE sigla_modulo = 'CCNA1';

