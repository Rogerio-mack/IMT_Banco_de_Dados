-- Questão 2.a) - Consulta de 2 Tabelas
-- Liste o nome dos alunos e as datas em que eles se matricularam em algum curso, ordenando pela data de matrícula mais recente.

SELECT a.nome, m.data_matricula
FROM alunos a
INNER JOIN matriculas m ON a.id_aluno = m.id_aluno
ORDER BY m.data_matricula DESC;

-- Questão 2.b) - INNER JOIN de 3 Tabelas (1)
-- Liste os nomes dos alunos, os cursos em que estão matriculados e as respectivas notas,
-- apenas para os cursos com carga horária superior a 70 horas.
-- Apresente as soluções com a condição de junção na clásula WHERE e com a sintaxe de JOIN.

SELECT a.nome AS aluno, c.nome AS curso, m.nota
FROM alunos a
INNER JOIN matriculas m ON a.id_aluno = m.id_aluno
INNER JOIN cursos c ON m.id_curso = c.id_curso
WHERE c.carga_horaria > 70
ORDER BY a.nome, c.nome;

SELECT a.nome AS aluno, c.nome AS curso, m.nota
FROM alunos a
JOIN matriculas m USING (id_aluno) 
JOIN cursos c USING (id_curso) 
WHERE c.carga_horaria > 70
ORDER BY a.nome, c.nome;

SELECT a.nome AS aluno, c.nome AS curso, m.nota
FROM alunos a, matriculas m, cursos c
WHERE a.id_aluno = m.id_aluno AND
m.id_curso = c.id_curso AND 
c.carga_horaria > 70
ORDER BY a.nome, c.nome;

-- Questão 2.c) - INNER JOIN de 3 Tabelas (2)
-- Liste os nomes dos alunos, os cursos em que estão matriculados e os nomes dos professores, 
-- apenas para os alunos que obtiveram nota igual ou superior a 8.0 e não informaram email @maua.br.

SELECT a.nome AS aluno, c.nome AS curso, c.professor, m.nota
FROM alunos a
INNER JOIN matriculas m ON a.id_aluno = m.id_aluno
INNER JOIN cursos c ON m.id_curso = c.id_curso
WHERE m.nota >= 8.0 AND
a.email NOT LIKE '%maua.br'
ORDER BY m.nota DESC;

-- Questão 2.d) - NOT IN ou OUTTER JOIN...
-- Liste todos os cursos sem alunos matriculados. Apresente duas soluções, uma com NOT IN outra com OUTTER JOIN

SELECT c.nome AS curso
FROM cursos c
WHERE c.nome NOT IN 
	(SELECT c.nome 
	FROM cursos c
	INNER JOIN matriculas m ON c.id_curso = m.id_curso)
ORDER BY curso;

SELECT c.nome AS curso 
FROM matriculas m  
RIGHT JOIN cursos c ON m.id_curso = c.id_curso 
WHERE m.id_curso IS NULL
ORDER BY curso; 

-- Questão 2.e) - OUTTER JOINs
-- Crie duas listas (dois selects) de nomes dos alunos e os respectivos cursos em que estão matriculados 
-- incluindo na primeira lista mesmo os alunos não matriculados em nenhum curso, e na segunda
-- mesmo os cursos sem nenhum aluno matriculado. Ordene a primeira por nome de curso e a segunda por nome de aluno. 

SELECT a.nome AS aluno, c.nome AS curso 
FROM cursos c
INNER JOIN matriculas m ON m.id_curso = c.id_curso
RIGHT JOIN alunos a ON a.id_aluno = m.id_aluno
-- INNER JOIN cursos c ON m.id_curso = c.id_curso -- indiferente aqui
ORDER BY curso;

-- (cursos JOIN matriculas) RIGHT JOIN alunos

SELECT a.nome AS aluno, c.nome AS curso 
FROM alunos a
LEFT JOIN matriculas m ON a.id_aluno = m.id_aluno
LEFT JOIN cursos c ON m.id_curso = c.id_curso
-- INNER JOIN cursos c ON m.id_curso = c.id_curso -- não é indiferente aqui
ORDER BY curso; 

-- (alunos LEFT JOIN matriculas) LEFT JOIN cursos, se o segundo for inner matriculas NULL não irão participar do relacionamento

SELECT a.nome AS aluno, c.nome AS curso 
FROM alunos a
INNER JOIN matriculas m ON a.id_aluno = m.id_aluno
-- RIGHT JOIN matriculas m ON a.id_aluno = m.id_aluno -- indiferente aqui
RIGHT JOIN cursos c ON m.id_curso = c.id_curso 
ORDER BY curso; 
 
-- Questão 2.f) - FULL OUTTER JOIN
-- Liste os nomes dos alunos e os respectivos cursos em que estão matriculados incluindo na lista 
-- os alunos não matriculados em nenhum curso, como também os cursos sem nenhum aluno. Ordene por nome de curso. 

SELECT a.nome AS aluno, c.nome AS curso 
FROM alunos a
INNER JOIN matriculas m ON a.id_aluno = m.id_aluno
RIGHT JOIN cursos c ON m.id_curso = c.id_curso
UNION
SELECT a.nome AS aluno, c.nome AS curso 
FROM alunos a
LEFT JOIN matriculas m ON a.id_aluno = m.id_aluno
LEFT JOIN cursos c ON m.id_curso = c.id_curso
ORDER BY curso; 
 
SELECT a.nome AS aluno, c.nome AS curso 
FROM alunos a
INNER JOIN matriculas m ON a.id_aluno = m.id_aluno
RIGHT JOIN cursos c ON m.id_curso = c.id_curso
UNION
SELECT a.nome AS aluno, c.nome AS curso 
FROM alunos a
LEFT JOIN matriculas m ON a.id_aluno = m.id_aluno
LEFT JOIN cursos c ON m.id_curso = c.id_curso
ORDER BY curso; 


