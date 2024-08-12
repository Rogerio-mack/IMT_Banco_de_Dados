/************************************************************************************************************************************/
/* SELECTS */
/************************************************************************************************************************************/
USE tti204 ;
-- 1 - conversao de tipos
SELECT CAST(num_matricula AS CHAR) 
FROM aluno ;

SELECT CAST(dt_conclusao AS CHAR) 
FROM instrutor_certificacao ;

-- 2 - concatenador - concatena duas strings removendo espaços em branco
SELECT CONCAT(nome_aluno, '  é aluno ') 
FROM aluno;

SELECT CONCAT(nome_aluno, CONCAT(' tem matricula ',  CAST(num_matricula AS CHAR))) AS "Matricula aluno"
FROM aluno;

SELECT CONCAT(nome_aluno, CONVERT(num_matricula, CHAR))
FROM aluno;

-- 3 - funções de data
SELECT NOW(), curdate(), curtime(), current_date , current_timestamp;
SELECT EXTRACT( YEAR_MONTH FROM curdate()), EXTRACT(HOUR FROM now());
SELECT EXTRACT(MONTH FROM current_timestamp);
SELECT EXTRACT(WEEK FROM current_timestamp) + 3 ;

-- 4 - Formatação de string
SELECT LCASE(resultado_final) FROM aluno_modulo
WHERE UPPER(resultado_final) = 'APROVADO' ;
-- SELECT INITCAP(nome_aluno) FROM aluno ;

-- 5 - Extract - matriculados este mês
SELECT * FROM aluno_certificacao
WHERE EXTRACT(YEAR_MONTH FROM curdate())  = EXTRACT(YEAR_MONTH FROM dt_matricula) ;
-- mês passado
SELECT * FROM aluno_certificacao
WHERE EXTRACT(YEAR_MONTH FROM curdate())  -1  = EXTRACT(YEAR_MONTH FROM dt_matricula) ;

SELECT  EXTRACT(YEAR_MONTH FROM curdate())  -1;
-- Interval
SELECT curDate() + INTERVAL '38' DAY , curDate() + INTERVAL '3' YEAR;

-- JUNÇÃO INTERNA
-- 6 - Mostrar nome do aluno , modulo e resultado final para os alunos aprovados
-- dando apelido/ alias para a tabela
SELECT a.nome_aluno AS Nome, am.sigla_modulo
FROM aluno a, aluno_modulo am
-- WHERE a.num_matricula = am.num_matricula -- junção no where
WHERE am.resultado_final = 'Aprovado' ;

-- 7  - utillizando sintaxe INNER JOIN
SELECT a.nome_aluno, am.sigla_modulo
FROM aluno a JOIN aluno_modulo am
ON a.num_matricula = am.num_matricula 
WHERE am.resultado_final = 'Aprovado' ;

-- 8 - usando operador LIKE
SELECT a.nome_aluno, m.nome_modulo, am.resultado_final AS Resultado
FROM aluno a INNER JOIN aluno_modulo am
ON a.num_matricula = am.num_matricula 
INNER JOIN modulo m
ON am.sigla_modulo = m.sigla_modulo
WHERE UPPER(am.resultado_final) LIKE '%APRO%' ;

-- 9 - subconsulta( select dentro de select) - alunos que cursaram os mesmos módulos que a Maria Silva
SELECT a.nome_aluno, am.sigla_modulo,  am.resultado_final
FROM aluno a, aluno_modulo am
WHERE a.num_matricula = am.num_matricula
AND am.sigla_modulo IN (
                         SELECT am.sigla_modulo
                         FROM aluno a, aluno_modulo am
                         WHERE a.num_matricula = am.num_matricula
                         AND UPPER(a.nome_aluno) LIKE 'ANA%' ) ;

/**********************************************
Funções de Grupo : COUNT, MAX, MIN, AVG, SUM 
Subconsultas
***********************************************/
/* 10 - Mostrar todos os dados da modulo com maior carga horária.*/
SELECT m.* FROM modulo m
WHERE m.carga_horaria_modulo = (
                                     SELECT MAX(carga_horaria_modulo) FROM modulo );

/* 11 - Mostrar a quantidade de alunos que cursam/cursaram cada modulo */
SELECT m.nome_modulo, COUNT(*) AS Qtde_alunos
FROM aluno a, aluno_modulo am, modulo m
INNER JOIN aluno_modulo am
ON a.num_matricula = am.num_matricula 
INNER JOIN modulo m
ON am.sigla_modulo = m.sigla_modulo
GROUP BY m.nome_modulo
ORDER BY 2 DESC ;

/* 12 - Mostrar o nome das certificacões que já ultrapassaram 100 alunas matriculadas ( sexo feminino) ao longo do tempo.*/

SELECT c.nome_cert AS Certificacao, COUNT(*)
FROM aluno a , certificacao c, aluno_certificacao ac
WHERE a.sexo_aluno = 'F'
AND a.num_matricula = ac.num_matricula 
AND ac.sigla_cert = c.sigla_cert
GROUP BY c.nome_cert
HAVING COUNT(certificacao) > 1;

/* 13 - Média das notas dos alunos nos módulos */
SELECT m.nome_modulo, AVG(am.nota_final) AS Média_modulo, COUNT(*) AS Qtde_alunos
FROM aluno a INNER JOIN aluno_modulo am
ON a.num_matricula = am.num_matricula 
INNER JOIN modulo m
ON am.sigla_modulo = m.sigla_modulo
GROUP BY m.nome_modulo
ORDER BY 3 DESC ;

DESC aluno_modulo ;


/*********************************
testes de validação da integridade referencial
update e delete em cascata 
**********************************/
DELETE FROM certificacao WHERE sigla_cert  = 'CCNA' ; -- excluiu e não deveria
SELECT * FROM certificacao ;
SELECT * FROM aluno_certificacao ;

DELETE FROM certificacao WHERE sigla_cert  = 'CCENT' ; 