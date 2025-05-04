-- Questão 1.a) - INNER JOIN
-- Liste o nome dos funcionários, seus cargos, salários e o nome do departamento onde trabalham. Ordene pelo nome do departamento.
-- i. Empregue a sintaxe INNER JOIN ON
-- ii. Empregue a sintaxe JOIN USING
-- iii. Empregue a a condição de JOIN em uma clásula WHERE

SELECT f.nome, f.cargo, f.salario, d.nome as departamento
FROM funcionarios f
INNER JOIN departamentos d ON f.id_departamento = d.id_departamento
ORDER BY d.nome;

SELECT f.nome, f.cargo, f.salario, d.nome as departamento
FROM funcionarios f
INNER JOIN departamentos d USING (id_departamento)
ORDER BY d.nome;

SELECT f.nome, f.cargo, f.salario, d.nome as departamento
FROM funcionarios f, departamentos d
WHERE f.id_departamento = d.id_departamento
ORDER BY d.nome;

-- Questão 1.b) - INNER JOIN + WHERE
-- Liste o nome dos funcionários, seus cargos, salários e o nome do departamento onde trabalham
-- que estejam localizados no Prédio A.

SELECT f.nome, f.cargo, f.salario, d.nome as departamento
FROM funcionarios f
INNER JOIN departamentos d ON f.id_departamento = d.id_departamento
WHERE d.localizacao = 'Prédio A' 
-- WHERE d.localizacao LIKE '%Prédio A%' 
ORDER BY d.nome;

-- Questão 1.c) - LEFT JOIN or RIGHT JOIN
-- Liste todos os funcionários e seus respectivos departamentos, incluindo aqueles que não estão alocados em nenhum departamento. 
-- Mostre o nome do funcionário, cargo, nome do departamento e localização do departamento.

SELECT f.nome, f.cargo, d.nome as departamento, d.localizacao
FROM funcionarios f
LEFT JOIN departamentos d ON f.id_departamento = d.id_departamento;

SELECT f.nome, f.cargo, d.nome as departamento, d.localizacao
FROM departamentos d
RIGHT JOIN funcionarios f ON f.id_departamento = d.id_departamento;

-- Questão 1.d) - LEFT JOIN or RIGHT JOIN, LIKE
-- Acrescente a condição do exercício anterior, listar somente os funcionários que tenham "Dias" como parte do nome. 

SELECT f.nome, f.cargo, d.nome as departamento, d.localizacao
FROM departamentos d
RIGHT JOIN funcionarios f ON f.id_departamento = d.id_departamento
WHERE f.nome LIKE '%Dias%';

-- Questão 1.e) - INNER JOIN
-- Liste todos os funcionários que têm salário acima da média da empresa e seus respectivos cargos e departamentos. 
-- Ordene do mais alto salário para o menor.

SELECT f.nome, f.cargo, d.nome as departamento
FROM departamentos d
INNER JOIN funcionarios f ON f.id_departamento = d.id_departamento
WHERE f.salario > (SELECT AVG(salario) FROM funcionarios)
ORDER BY f.salario DESC;

