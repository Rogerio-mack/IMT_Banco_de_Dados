CREATE DATABASE dbprojetos;
USE dbprojetos;

CREATE TABLE Departamentos
	(idDepto INTEGER  UNIQUE, 
	nomeDepto VARCHAR(40),
	
	PRIMARY KEY(idDepto)); 

CREATE TABLE Funcionarios
	(idFunc INTEGER  UNIQUE,
	nomeFunc VARCHAR(40), CPF CHAR(14) UNIQUE, 
	
	PRIMARY KEY(idFunc), idDepto INTEGER,
	FOREIGN KEY(idDepto) REFERENCES Departamentos(idDepto) 
	ON DELETE CASCADE);

CREATE TABLE Projetos 
	(idProjeto INTEGER UNIQUE,
	nomeProjeto VARCHAR(40),
	
	PRIMARY KEY (idProjeto));

CREATE TABLE Funcionarios_Projetos
	(idFunc INTEGER, IdProjeto INTEGER,
	funcaoFunc VARCHAR(40), dataInicio date,
	
	PRIMARY KEY(dataInicio, idFunc, idProjeto),
	FOREIGN KEY(idFunc) REFERENCES Funcionarios(idFunc)
	ON DELETE CASCADE,
	FOREIGN KEY(idProjeto) REFERENCES Projetos(idProjeto));
	
-- Ou linha a linha
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (10, "Compras"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (20, "Vendas"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (30, "Marketing"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (40, "Engenharia"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (50, "RH"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (60, "TI"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (70, "Almoxarifado"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (80, "Manutenção"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (90, "Segurança"); 
INSERT INTO Departamentos (idDepto, nomeDepto) VALUES (100, "Contabilidade"); 

-- Ou em lotes
INSERT INTO Funcionarios(idFunc, nomeFunc, CPF, idDepto) VALUES 
(1000, 'Paulo de Souza Alves', '234.876.855-10', 10),
(1001, 'Ana da Silva', '666.876.855-10', 10),
(1002, 'Pedro Candido', '444.876.855-10', 10),
(1010, 'Antonio Alves', '269.876.855-45', 20),
(1021, 'Henrique Souza Alves', '903.876.855-42', 20),
(1032, 'Beatriz Silva Santos', '084.457.123-42', 30),
(1034, 'Fernando Xavier Santos', '991.670.120-77', 30),
(1045, 'Pedro Diógenes Santos', '042.668.234-22', 40),
(1056, 'Santos Gimenez', '816.803.129-33', 50),
(1067, 'Carlos Eduardo Bognar', '775.662.127-33', 60),
(1068, 'Mauro Favoretto', '225.662.127-33', 60),
(1078, 'Maria Aparecida Flores', '388.800.120-49', 70),
(1081, 'Saulo de Souza', '691.389.114-91', 80),
(1098, 'Ivo de Alcantara', '892.339.966-66', 90),
(1099, 'Carlos Alberto de Macedo', '447.100.590-19', 90),
(1101, 'Renato Carioca', '778.124.801-17', 100);

INSERT INTO Funcionarios_Projetos(idProjeto, nomeProjeto) VALUES 
(100, 'ABC'),
(200, 'XYZ'),
(300, 'YB88'),
(400, 'Z3400'),
(500, 'UFY78');

INSERT INTO Funcionarios_Projetos(idFunc, idProjeto, funcaoFunc, dataInicio) VALUES 
(1021, '100', 'Programador', '2020-10-01'),
(1021, '100', 'Gerente', '2021-10-31'),
(1021, '100', 'Assistente', '2021-11-10'),
(1034, '200', 'Secretário', '2021-10-10'),
(1081, '300', 'Gerente', '2019-12-12'),
(1081, '300', 'Programador Junior', '2020-12-12'),
(1081, '300', 'Programador Junior', '2020-12-31'),
(1101, '400', 'Gerente', '2021-12-01'),
(1101, '400', 'Gerente', '2022-01-05');



