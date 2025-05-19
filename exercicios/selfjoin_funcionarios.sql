drop database if exists seljoindb;
create database seljoindb;
use seljoindb;

CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    id_gerente INT,
    FOREIGN KEY (id_gerente) REFERENCES funcionarios(id)
);

INSERT INTO funcionarios (id, nome, cargo, id_gerente) VALUES
(1, 'Ana', 'CEO', NULL),
(2, 'Bruno', 'Gerente de Vendas', 1),
(3, 'Carlos', 'Gerente de TI', 1),
(4, 'Daniela', 'Vendedor', 2),
(5, 'Eduarda', 'Vendedor', 2),
(6, 'Felipe', 'Desenvolvedor', 3),
(7, 'Gabriela', 'Desenvolvedor', 3);

-- Listar todos os gerentes com os nomes de seus subordinados

SELECT g.nome AS gerente, f.nome AS subordinado
FROM funcionarios g
JOIN funcionarios f ON f.id_gerente = g.id
ORDER BY g.nome;

-- Listar cada funcionário com o nome do seu gerente dos vendedores

SELECT f.nome AS funcionario, f.cargo, g.nome AS gerente
FROM funcionarios f
LEFT JOIN funcionarios g ON f.id_gerente = g.id
WHERE f.cargo = 'Vendedor';

-- Contar quantos subordinados cada gerente tem

SELECT g.nome AS gerente, COUNT(f.id) AS qtd_subordinados
FROM funcionarios g
JOIN funcionarios f ON f.id_gerente = g.id
GROUP BY g.nome;
