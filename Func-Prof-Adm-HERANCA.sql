USE exemplos;

CREATE TABLE Funcionario (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100),
    salario DECIMAL(10,2)
);

CREATE TABLE Professor (
    id_funcionario INT PRIMARY KEY,
    disciplina VARCHAR(100),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario) ON DELETE CASCADE
);

CREATE TABLE Administrador (
    id_funcionario INT PRIMARY KEY,
    departamento VARCHAR(100),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario) ON DELETE CASCADE
);

-- Inserindo Funcionários
INSERT INTO Funcionario (id_funcionario, nome, salario) VALUES (1, 'Carlos', 5000.00);
INSERT INTO Funcionario (id_funcionario, nome, salario) VALUES (2, 'Mariana', 6000.00);

-- Especializando Carlos como Professor
INSERT INTO Professor (id_funcionario, disciplina) VALUES (1, 'Matemática');

-- Especializando Mariana como Administradora
INSERT INTO Administrador (id_funcionario, departamento) VALUES (2, 'Recursos Humanos');

-- Listar todos os funcionários e suas especializações
SELECT F.id_funcionario, F.nome, F.salario, P.disciplina, A.departamento
FROM Funcionario F
LEFT JOIN Professor P ON F.id_funcionario = P.id_funcionario
LEFT JOIN Administrador A ON F.id_funcionario = A.id_funcionario;

