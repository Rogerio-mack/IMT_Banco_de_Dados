USE Exemplos;

-- Criação da tabela
DROP TABLE IF EXISTS Produtos;

CREATE TABLE IF NOT EXISTS Produtos (
    id INT,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    preco_antigo DECIMAL(10, 2) NOT NULL,
    desconto DECIMAL(10, 2) NOT NULL
);

-- Alterando a tabela Produtos  
ALTER TABLE Produtos
ADD COLUMN em_estoque BOOLEAN DEFAULT TRUE;

ALTER TABLE Produtos
ADD CONSTRAINT PK_Produtos PRIMARY KEY (id);   

ALTER TABLE Produtos
ADD CONSTRAINT UQ_Produtos_Nome UNIQUE (nome);   

ALTER TABLE Produtos
MODIFY COLUMN desconto DECIMAL(5, 2) NULL;

ALTER TABLE Produtos
DROP COLUMN preco_antigo;

-- Inserção de dados de exemplo na tabela Produtos
INSERT INTO Produtos (id, nome, preco, em_estoque, desconto)
VALUES 
(1,'Camiseta', 29.99, TRUE, 5.00),
(2,'Calça', 59.90, FALSE, NULL),
(3,'Tênis', 120.00, TRUE, 10.00),
(4,'Boné', 19.99, TRUE, NULL),
(5,'Meias', 9.99, FALSE, 2.00);

-- Exemplo de SELECT
SELECT * FROM Produtos;