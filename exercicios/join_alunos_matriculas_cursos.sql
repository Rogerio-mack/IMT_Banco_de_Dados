-- Lab join_alunos_matriculas_cursos

DROP DATABASE IF EXISTS join_alunos_matriculas_cursos;
CREATE DATABASE join_alunos_matriculas_cursos;
USE join_alunos_matriculas_cursos;

-- Criação das tabelas
CREATE TABLE alunos (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    data_nascimento DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE cursos (
    id_curso INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT,
    professor VARCHAR(50)
);

CREATE TABLE matriculas (
    id_aluno INT,
    id_curso INT,
    data_matricula DATE NOT NULL,
    nota DECIMAL(4, 2),
    PRIMARY KEY (id_aluno, id_curso),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- Populando as tabelas
INSERT INTO alunos VALUES 
(1, 'Maria Souza', '1998-05-10', 'maria@email.com'),
(2, 'Pedro Almeida', '1995-12-15', 'pedro@email.com'),
(3, 'Luciana Castro', '1997-08-22', 'luciana@email.com'),
(4, 'Gabriel Ribeiro', '1999-03-30', 'gabriel@email.com'),
(5, 'Beatriz Lima', '1996-11-05', 'beatriz@email.com'),
(6, 'André Santos', '1994-07-18', 'andre@email.com'),
(7, 'Sofia Lima', '1994-07-18', 'sophia@email.com');

INSERT INTO cursos VALUES 
(1, 'Banco de Dados', 60, 'Dr. Oliveira'),
(2, 'Programação Python', 80, 'Dra. Pereira'),
(3, 'Desenvolvimento Web', 100, 'Dr. Fernandes'),
(4, 'Inteligência Artificial', 90, 'Dra. Cardoso'),
(5, 'Segurança da Informação', 70, 'Dr. Mendes'),
(6, 'Banco de Dados Não Relacionais', 60, 'Dr. Oliveira');

INSERT INTO matriculas VALUES 
(1, 1, '2025-01-15', 8.5),
(1, 2, '2025-02-10', 7.8),
(1, 3, '2025-03-05', 9.0),
(2, 2, '2025-01-20', 6.5),
(2, 4, '2025-02-15', 8.0),
(3, 1, '2025-02-05', 9.5),
(3, 3, '2025-03-10', 7.0),
(3, 5, '2025-04-01', 8.7),
(4, 3, '2025-01-25', 6.8),
(4, 4, '2025-02-20', 7.5),
(5, 1, '2025-03-15', 9.2),
(5, 5, '2025-04-10', 8.0),
(6, 2, '2025-02-01', 7.3);
