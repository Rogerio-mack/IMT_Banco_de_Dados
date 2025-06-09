USE empresa_exemplo;

-- EXERCÍCIO 1:  
-- Liste o nome de cada funcionário e o nome de seu supervisor direto.
SELECT 
    f.nome AS funcionario,
    s.nome AS supervisor
FROM 
    funcionarios f
JOIN 
    funcionarios s ON f.supervisor_id = s.id;

-- EXERCÍCIO 1b:  
-- Liste o nome do supervisor e a quantidade de colaboradores, somente para aqueles supervisores com mais de um colaborador.
        
SELECT 
    s.nome AS supervisor,
    count(*)
	FROM 
		funcionarios f
	JOIN 
		funcionarios s ON f.supervisor_id = s.id
	GROUP BY s.nome
    HAVING count(*) > 1;
        
-- EXERCÍCIO 2:  
-- Liste os funcionários, seus supervisores e os nomes dos projetos em que os funcionários estão alocados.
SELECT 
    f.nome AS funcionario,
    s.nome AS supervisor,
    p.nome AS projeto
FROM 
    funcionarios f
LEFT JOIN 
    funcionarios s ON f.supervisor_id = s.id
LEFT JOIN 
    funcionario_projeto fp ON f.id = fp.funcionario_id
LEFT JOIN 
    projetos p ON p.id = fp.projeto_id;


-- EXERCÍCIO 3: 
-- Liste todos os projetos e, se houver, os nomes dos funcionários alocados. Inclua projetos sem funcionários.
SELECT 
    p.nome AS projeto,
    f.nome AS funcionario
FROM 
    projetos p
LEFT JOIN 
    funcionario_projeto fp ON p.id = fp.projeto_id
LEFT JOIN 
    funcionarios f ON f.id = fp.funcionario_id;

-- EXERCÍCIO 4:  
-- Liste todos os projetos e o número total de funcionários alocados em cada um (mesmo que zero).
SELECT 
    p.nome AS projeto,
    COUNT(fp.funcionario_id) AS total_funcionarios
FROM 
    projetos p
LEFT JOIN 
    funcionario_projeto fp ON p.id = fp.projeto_id
GROUP BY 
    p.id, p.nome;

-- EXERCÍCIO 5: 
-- Com SUBSELECT com EXISTS liste os nomes dos funcionários que participam de pelo menos um projeto.

SELECT 
    f.nome
FROM 
    funcionarios f
WHERE 
    EXISTS (
        SELECT 1 
        FROM funcionario_projeto fp 
        WHERE fp.funcionario_id = f.id
    );


-- EXERCÍCIO 6:  
-- Com SUBSELECT com EXISTS liste os nomes dos projetos que ainda não têm nenhum funcionário alocado.
SELECT 
    p.nome
FROM 
    projetos p
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM funcionario_projeto fp 
        WHERE fp.projeto_id = p.id
    );
