CREATE DATABASE IF NOT EXISTS dbemployee;
-- DDL para a tabela funcionarios
USE dbemployee;

CREATE TABLE IF NOT EXISTS funcionarios (
    idFuncionario INT PRIMARY KEY,
    nomeFuncionario VARCHAR(255),
    dataAdmissaoFuncionario DATE,
    salarioFuncionario DECIMAL(10, 2),
    funcaoFuncionario VARCHAR(255),
    idSupervisor INT,
    FOREIGN KEY (idSupervisor) REFERENCES funcionarios(idFuncionario)
);

-- DDL para a tabela automoveis
CREATE TABLE IF NOT EXISTS automoveis (
    idAutomovel INT PRIMARY KEY,
    fabricanteAutomovel VARCHAR(255),
    anoAutomovel INT,
    modeloAutomovel VARCHAR(255),
    chassiAutomovel VARCHAR(255),
    idFuncionario INT,
    FOREIGN KEY (idFuncionario) REFERENCES funcionarios(idFuncionario)
);

-- DML para popular as tabelas com os dados fornecidos

INSERT INTO funcionarios (idFuncionario, nomeFuncionario, dataAdmissaoFuncionario, salarioFuncionario, funcaoFuncionario, idSupervisor) VALUES
(1, 'Pedro Paulo', '2001-10-31', 25000.00, 'Gerente de Sistemas de Software', null),
(2, 'Ana da Silva', '2009-01-30', 15000.00,'Programadora de Sistemas', 1),
(3, 'André de Souza', '2020-04-29', 16000.00, 'Engenheiro de Software', 1),
(4, 'Carlos Macedo', '1988-09-27', 23000.00,'Gerente de Suporte Técnico', null),
(5, 'Benededito da Silva', '1995-09-28',16500.00, 'Analista de Sistemas', 4),
(6, 'Carlos Aguiar Souza', '2012-11-28',9500.00, 'Analista Front End',4),
(7, 'Sandra de Souza Freitas', '2015-07-30',11500.00,'Analista Back End',4),
(8, 'Saulo André Magalhães', '2016-10-10', 12000.00,'Analista de Suporte Técnico', 1),
(9, 'Pio de Souza Xavier', '2017-05-25', 14500.00,'Programador Java Senior',4),
(10, 'Pedro Paulo Andrade', '2018-01-27',6500.00, 'Programador Java Junior', 4),
(11, 'Beatriz Silveira', '2015-01-21', 9500.00, 'Gerente de Vendas', null),
(12, 'Carlos Bitencourt', '2018-08-26', 3800.00, 'Analista de Vendas', 11),
(13, 'José Alencar Brito', '2001-07-16', 7800.00, 'Analista de Vendas', 11),
(14, 'Emerson Godoy', '2013-01-23', 11500.00, 'Gerente de Marketing', null),
(15, 'Kemelly Andrade', '2021-02-24', 7900.00, 'Analista de Marketing', 14),
(16, 'Armando Queiroz', '2022-02-01', 5900.00, 'Analista de Marketing', 14),
(17, 'Fernando Marins', '1997-01-23', 31500.00, 'Gerente de Produção', null),
(18, 'Fernando Marins', '2001-01-29', 18500.00, 'Engenheiro de Produção', 17),
(19, 'Sandro Xavier', '2003-01-13', 19500.00, 'Engenheiro de Produção', 17),
(20, 'Camila de Souza Rocha Xavier', '2006-01-18', 19500.00,'Engenheira de Produção', 17);

INSERT INTO automoveis (idAutomovel, fabricanteAutomovel, anoAutomovel, modeloAutomovel, chassiAutomovel, idFuncionario) VALUES
(100, 'Volkswagen', 2010, 'Fox', 'BW5987654W0001', null),
(200, 'GM', 2011, 'Celta', 'BF4398373770003', 20),
(300, 'Fiat', 2020, 'Toro', 'WBY9998770885', 17),
(400, 'Volkswagen', 2021, 'Passat', 'BWW234871349871239', 12),
(500, 'Volkswagen', 2005, 'Gol', 'BWW3248917398471', 10),
(600, 'Fiat', 2015, 'Mile', 'BWW3249081340981', 9),
(700, 'Toyota', 2020, 'Corolla', 'BWW1239041234890', 6),
(800, 'Toyota', 2022, 'Camry', 'BWW14238901234890', 5),
(900, 'GM', 2009, 'Corsa', 'BWW790-79034563465', null);

-- 5. Consultas (DML)

-- a) Listar todos os automóveis cadastrados no banco de dados.
SELECT * FROM automoveis;

-- b) Listar todos os automóveis cadastrados no banco de dados em ordem alfabética crescente de ano.
SELECT * FROM automoveis ORDER BY anoAutomovel ASC;

-- c) Listar todos os automóveis fabricados pela Volkswagen e ordem crescente de ano de Fabricação.
SELECT * FROM automoveis WHERE fabricanteAutomovel = 'Volkswagen' ORDER BY anoAutomovel ASC;

-- d) Listar todos os automóveis que estão reservados para algum funcionário, ordenados em ordem decrescente do ano de Fabricação.
SELECT * FROM automoveis WHERE idFuncionario IS NOT NULL ORDER BY anoAutomovel DESC;

-- e) Listar todos os automóveis que estão sem reservas para funcionários, ordenados em ordem crescente do ano de Fabricação.
SELECT * FROM automoveis WHERE idFuncionario IS NULL ORDER BY anoAutomovel ASC;
SELECT fabricanteAutomovel, anoAutomovel, modeloAutomovel FROM automoveis ORDER BY anoAutomovel ASC;

-- f)* Selecionar idAutomovel, fabricanteAutomovel, anoAutomovel, modeloAutomovel, chassiAutomovel apenas dos automóveis do ano de 2005 a 2010.
SELECT idAutomovel, fabricanteAutomovel, anoAutomovel, modeloAutomovel, chassiAutomovel FROM automoveis WHERE anoAutomovel BETWEEN 2005 AND 2010;

-- g)* Listar os automóveis dos anos 2005, 2010 e 2020, ordenados pelo ano de fabricação.
SELECT fabricanteAutomovel, anoAutomovel, modeloAutomovel  FROM automoveis  WHERE anoAutomovel IN (2005, 2010, 2020) ORDER BY anoAutomovel;

-- h) Lista o fabricante e ano do automóvel reservado para o funcionário 10.
SELECT fabricanteAutomovel, anoAutomovel FROM automoveis WHERE idFuncionario = 10;

-- i)* Listar os automóveis que estão reservados para algum funcionário e que tenham ano de fabricação superior 
-- a 2005, ordenados pelo ano de fabricação.
SELECT * FROM automoveis WHERE idFuncionario IS NOT NULL AND anoAutomovel > 2005 ORDER BY anoAutomovel;

--  j)* Listar os fabricantes de automóveis cadastrados no banco de dados ordenados pelo nome do
-- fabricante
SELECT DISTINCT fabricanteAutomovel FROM automoveis ORDER BY fabricanteAutomovel;

-- k) Listar os fabricantes de automóveis cadastrados no banco de dados, sem duplicados, ordenados
-- pelo nome do fabricante.
SELECT DISTINCT fabricanteAutomovel FROM automoveis ORDER BY fabricanteAutomovel;

-- l) Listar os automóveis entre 2010 e 2020, ordenados pelo ano de fabricação.
SELECT * FROM automoveis WHERE anoAutomovel BETWEEN 2010 AND 2020 ORDER BY anoAutomovel;

-- m) Listar os automóveis com reserva para algum funcionário entre 2010 e 2020, ordenados pelo ano
-- de fabricação.
SELECT * FROM automoveis WHERE idFuncionario IS NOT NULL AND anoAutomovel BETWEEN 2010 AND 2020 ORDER BY anoAutomovel;

-- n) Listar os funcionários que ganham mais de 10000.00, ordenados pelo nome do Funcionário.
SELECT * FROM funcionarios WHERE salarioFuncionario > 10000.00 ORDER BY nomeFuncionario;

-- o) Listar os funcionários que são supervisionados pelo funcionário cujo idSupervisor = 4, ordenados
-- pelo nome do Funcionário;
SELECT * FROM funcionarios WHERE idSupervisor = 4 ORDER BY nomeFuncionario;

-- p) Listar os funcionários que foram admitidos na empresa a partir do ano 2010, ordenados pela data
-- de admissão.
SELECT * FROM funcionarios WHERE dataAdmissaoFuncionario >= '2010-01-01' ORDER BY dataAdmissaoFuncionario;

-- q) Listar os funcionários que tem ‘Souza’ no nome, ordenados pelo idFuncionario.
SELECT * FROM funcionarios WHERE nomeFuncionario LIKE '%Souza%' ORDER BY idFuncionario;

-- r) Listar os funcionários que tem o nome iniciado com a letra ‘P’, ordenados pelo idFuncionario.
SELECT * FROM funcionarios WHERE nomeFuncionario LIKE 'P%' ORDER BY idFuncionario;

-- s)* Listar o funcionário com o maior salário.
SELECT * FROM funcionarios WHERE salarioFuncionario = (SELECT MAX(salarioFuncionario) FROM funcionarios);

-- t) Listar o funcionário com o menor salário.
SELECT * FROM funcionarios WHERE salarioFuncionario = (SELECT MIN(salarioFuncionario) FROM funcionarios);

-- u)* Listar a média de salário dos funcionários cadastrados no banco de dados.
SELECT AVG(salarioFuncionario) AS mediaSalario FROM funcionarios;

-- v) Listar os dois maiores salários dos funcionários cadastrados no banco de dados.
SELECT * FROM funcionarios ORDER BY salarioFuncionario DESC LIMIT 2;

-- w) Listar os três maiores salários dos funcionários cadastrados no banco de dados.
SELECT * FROM funcionarios ORDER BY salarioFuncionario DESC LIMIT 3;

-- x) Listar os dois menores salários dos funcionários cadastrados no banco de dados.
SELECT * FROM funcionarios ORDER BY salarioFuncionario ASC LIMIT 2;

-- y) Listar os três menores salários dos funcionários cadastrados no banco de dados.
SELECT * FROM funcionarios ORDER BY salarioFuncionario ASC LIMIT 3;










