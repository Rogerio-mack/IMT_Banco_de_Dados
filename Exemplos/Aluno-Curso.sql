USE Exemplos;

-- Criação da tabela Aluno
CREATE TABLE Aluno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- Criação da tabela Curso
CREATE TABLE Curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- Criação da tabela associativa Aluno_Curso
CREATE TABLE Aluno_Curso (
    aluno_id INT,
    curso_id INT,
    PRIMARY KEY (aluno_id, curso_id),
    FOREIGN KEY (aluno_id) REFERENCES Aluno(id) ON DELETE CASCADE,  
    FOREIGN KEY (curso_id) REFERENCES Curso(id) ON DELETE CASCADE  
);

-- Inserção de dados de exemplo na tabela Aluno
INSERT INTO Aluno (nome) 
VALUES 
('Alice'),
('Daniel'),
('Carolina'),
('Henrique'),
('Adriana');

-- Inserção de dados de exemplo na tabela Curso
INSERT INTO Curso (nome) 
VALUES 
('Matemática I'),
('Física II'),
('Banco de Dados Relacional'),
('Linguagem de Programação I'),
('Redes Neurais');

-- Inserção de dados na tabela associativa Aluno_Curso
INSERT INTO Aluno_Curso (aluno_id, curso_id) 
VALUES 
(1, 1),   
(1, 3),   
(2, 2),  
(3, 1),  
(4, 4);   

-- Seleção  
SELECT * FROM Aluno;
SELECT * FROM Curso;
SELECT * FROM Aluno_Curso;

-- JOIN simples 
SELECT a.nome AS aluno, c.nome AS curso
FROM Aluno a
JOIN Aluno_Curso ac ON a.id = ac.aluno_id
JOIN Curso c ON c.id = ac.curso_id;

-- JOIN simples 
SELECT a.nome AS aluno, c.nome AS curso
FROM Aluno a
JOIN Aluno_Curso ac ON a.id = ac.aluno_id
JOIN Curso c ON c.id = ac.curso_id;

-- JOIN simples 
SELECT a.nome AS aluno, aluno_id, curso_id, c.nome AS curso
FROM Aluno a
JOIN Aluno_Curso ac ON a.id = ac.aluno_id
JOIN Curso c ON c.id = ac.curso_id;