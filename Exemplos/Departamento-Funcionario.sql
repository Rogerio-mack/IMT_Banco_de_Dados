USE Exemplos;

-- Criação da tabela Departamento
CREATE TABLE Departamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT UQ_Departamento_Nome UNIQUE (nome)  
);

-- Criação da tabela Funcionario
CREATE TABLE Funcionario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    departamento_id INT,
    CONSTRAINT FK_Funcionario_Departamento FOREIGN KEY (departamento_id) REFERENCES Departamento(id) ON DELETE CASCADE  
);

-- Inserção de dados de exemplo na tabela Departamento
INSERT INTO Departamento (nome) 
VALUES 
('Recursos Humanos'),
('Vendas'),
('Tecnologia'),
('Financeiro'),
('Marketing');

-- Inserção de dados de exemplo na tabela Funcionario
INSERT INTO Funcionario (nome, salario, departamento_id) 
VALUES 
('Alice', 5000.00, 1),
('Daniel', 6000.00, 2),
('Carolina', 7000.00, 3),
('Henrique', 8000.00, 2),
('Adriana', 9000.00, 4);

-- Seleção de todos os dados da tabela Departamento
SELECT * FROM Departamento;

-- Seleção de todos os dados da tabela Funcionario
SELECT * FROM Funcionario;

-- JOIN simples entre as tabelas Funcionario e Departamento
SELECT f.nome AS funcionario, d.nome AS departamento
FROM Funcionario f
JOIN Departamento d ON f.departamento_id = d.id;