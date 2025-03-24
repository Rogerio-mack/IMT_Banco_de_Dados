USE Exemplos;

-- Criação das tabelas
DROP TABLE IF EXISTS Cidade;  -- POR QUE SÓ FUNCIONA NESSA ORDEM OS DROPS E NÃO Pais, Cidade???
DROP TABLE IF EXISTS Pais;

CREATE TABLE IF NOT EXISTS Pais (
    id INT,
    nome VARCHAR(50) NOT NULL,
    codigo_iso CHAR(3) NOT NULL
);

CREATE TABLE IF NOT EXISTS Cidade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    populacao INT NOT NULL
);

-- Alterando as tabelas COLUMNS
ALTER TABLE Pais
ADD CONSTRAINT UQ_Pais_Nome_2 UNIQUE (nome);

ALTER TABLE Pais
ADD CONSTRAINT UQ_Pais_Codigo_ISO_2 UNIQUE (codigo_iso);

ALTER TABLE Cidade
ADD COLUMN pais_id INT;

-- Alterando as tabelas CONSTRAINTS
ALTER TABLE Pais
ADD CONSTRAINT PK_Pais PRIMARY KEY (id);  

ALTER TABLE Cidade
ADD CONSTRAINT FK_Cidade_Pais_2 FOREIGN KEY (pais_id) REFERENCES Pais(id) ON DELETE CASCADE;

-- Inserção de dados de exemplo na tabela Pais
INSERT INTO Pais (id, nome, codigo_iso)
VALUES 
(1,'Brasil', 'BRA'),
(2,'Argentina', 'ARG'),
(3,'Chile', 'CHL'),
(4,'Colômbia', 'COL'),
(5,'Uruguai', 'URY');

SELECT * FROM pais;

-- Inserção de dados de exemplo na tabela Cidade
INSERT INTO Cidade (nome, populacao, pais_id)
VALUES 
('São Paulo', 12176902, 1),
('Buenos Aires', 3024286, 2),
('Santiago', 6740000, 3),
('Medellín', 2496046, 4),
('Montevidéu', 1300000, 5);

-- Exemplo de SELECT
SELECT * FROM Cidade;

-- Exemplo de JOIN
SELECT c.nome AS cidade, p.nome AS pais
FROM Cidade c
JOIN Pais p ON c.pais_id = p.id;

 