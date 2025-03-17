-- Criar o banco de dados (se necessário)
CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- Criar a tabela de Autores
CREATE TABLE IF NOT EXISTS Autores (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    nacionalidade VARCHAR(255)
);

-- Criar a tabela de Títulos
CREATE TABLE IF NOT EXISTS Titulos (
    id_titulo INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    id_autor INT,
    ano_publicacao YEAR,
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);


-- Popular a tabela de Autores
INSERT INTO Autores (nome, nacionalidade) VALUES
('J.R.R. Tolkien', 'Britânica'),
('Jane Austen', 'Britânica'),
('Gabriel García Márquez', 'Colombiana'),
('George Orwell', 'Britânica'),
('Virginia Woolf', 'Britânica'),
('Stephen King', 'Americana');


-- Popular a tabela de Títulos
INSERT INTO Titulos (titulo, id_autor, ano_publicacao) VALUES
('O Hobbit', 1, 1937),
('O Senhor dos Anéis', 1, 1954),
('Orgulho e Preconceito', 2, 1813),
('Cem Anos de Solidão', 3, 1967),
('1984', 4, 1949),
('Orlando', 5, 1928),
('It', 6, 1986);

-- Consulta simples para verificar os dados
SELECT * FROM Autores;
SELECT * FROM Titulos;
