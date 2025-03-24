USE Exemplos;

-- Criação da tabela
DROP TABLE IF EXISTS Produtos;

CREATE TABLE IF NOT EXISTS Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    em_estoque BOOLEAN DEFAULT TRUE,
    desconto DECIMAL(5, 2) NULL
);

-- Inserção de dados de exemplo
INSERT INTO Produtos (nome, preco, em_estoque, desconto)
VALUES 
('Camiseta', 29.99, TRUE, 5.00),
('Calça', 59.90, FALSE, NULL),
('Tênis', 120.00, TRUE, 10.00),
('Boné', 19.99, TRUE, NULL),
('Meias', 9.99, FALSE, 2.00);

-- Inserção de dados com exemplo de DEFAULT
INSERT INTO Produtos (nome, preco, desconto)
VALUES 
('Mochila', 119.99, NULL),
('Caneta', 1.99, 2.00);

-- Seleção de todos os dados
SELECT * FROM Produtos;

-- Seleção de produtos com desconto NULL
SELECT nome, preco FROM Produtos WHERE desconto IS NULL;

-- Seleção de produtos em estoque
SELECT nome, preco FROM Produtos WHERE em_estoque = TRUE;

-- Exemplo de operação aritmética: cálculo do preço com desconto (considerando casos não nulos)
SELECT nome, preco, desconto, (preco - IFNULL(desconto, 0)) AS preco_final, em_estoque
FROM Produtos;