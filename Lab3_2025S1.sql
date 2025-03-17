CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- Autores
CREATE TABLE Autores (
    id_autor INT PRIMARY KEY ...
    nome ...
    nacionalidade ...
);

-- Títulos
CREATE TABLE Titulos (
    id_titulo INT PRIMARY KEY ...
    titulo ...
    id_autor ...
    ano_publicacao ...
    FOREIGN KEY ...
);

-- Popular Autores
INSERT INTO Autores (id_autor, nome, nacionalidade) VALUES
(1,'J.R.R. Tolkien', 'Britânica'),
(2,'Jane Austen', 'Britânica'),
(3,'Gabriel García Márquez', 'Colombiana'),
(4,'George Orwell', 'Britânica'),
(5,'Virginia Woolf', 'Britânica'),
(6,'Stephen King', 'Americana');


-- Popular Títulos
INSERT INTO Titulos (id_titulo, titulo, id_autor, ano_publicacao) VALUES
(1,'O Hobbit', 1, 1937),
(2,'O Senhor dos Anéis', 1, 1954),
(3,'Orgulho e Preconceito', 2, 1813),
(4,'Cem Anos de Solidão', 3, 1967),
(5,'1984', 4, 1949),
(6,'Orlando', 5, 1928),
(7,'It', 6, 1986);

SELECT * FROM Autores;
SELECT * FROM Titulos;
