USE Exemplos;

-- Criação da tabela Pais
DROP TABLE IF EXISTS Pais;
CREATE TABLE IF NOT EXISTS Pais (
    id INT AUTO_INCREMENT,
    -- id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    codigo_iso CHAR(3) NOT NULL UNIQUE,
    CONSTRAINT PK_Pais PRIMARY KEY (id)
);

-- Criação da tabela Cidade
DROP TABLE IF EXISTS Cidade;
CREATE TABLE IF NOT EXISTS Cidade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    populacao INT NOT NULL,
    pais_id INT,
    CONSTRAINT FK_Cidade_Pais FOREIGN KEY (pais_id) REFERENCES Pais(id) ON DELETE CASCADE
    -- FOREIGN KEY (pais_id) REFERENCES Pais(id) ON DELETE CASCADE
);

-- Inserção de dados de exemplo na tabela Pais
INSERT INTO Pais (nome, codigo_iso) 
VALUES 
('Brasil', 'BRA'),
('Argentina', 'ARG'),
('Chile', 'CHL'),
('Colômbia', 'COL'),
('Uruguai', 'URY');

-- Inserção de dados de exemplo na tabela Cidade
INSERT INTO Cidade (nome, populacao, pais_id) 
VALUES 
('São Paulo', 12176902, 1),
('Buenos Aires', 3024286, 2),
('Santiago', 6740000, 3),
('Medellín', 2496046, 4),
('Montevidéu', 1300000, 5);

-- Seleção 
SELECT * FROM Pais;
SELECT * FROM Cidade;

-- JOIN simples entre as tabelas Pais e Cidade 
SELECT c.nome AS cidade, p.codigo_iso as sigla, p.nome AS pais
FROM Cidade c
JOIN Pais p ON c.pais_id = p.id;