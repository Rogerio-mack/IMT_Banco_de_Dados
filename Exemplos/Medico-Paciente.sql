-- Criação da tabela Medico
CREATE TABLE Medico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    especialidade VARCHAR(50) NOT NULL
);

-- Criação da tabela Paciente
CREATE TABLE Paciente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL
);

-- Criação da tabela associativa Medico_Paciente
CREATE TABLE Medico_Paciente (
    medico_id INT,
    paciente_id INT,
    data_ultima_consulta DATE,  -- Atributo para a data da última consulta
    PRIMARY KEY (medico_id, paciente_id),
    FOREIGN KEY (medico_id) REFERENCES Medico(id) ON DELETE CASCADE,  -- Chave estrangeira com ON DELETE CASCADE
    FOREIGN KEY (paciente_id) REFERENCES Paciente(id) ON DELETE CASCADE   -- Chave estrangeira com ON DELETE CASCADE
);

-- Inserção de dados de exemplo na tabela Medico
INSERT INTO Medico (nome, especialidade) 
VALUES 
('Dr. João', 'Cardiologia'),
('Dra. Ana', 'Pediatria'),
('Dr. Carlos', 'Ortopedia'),
('Dra. Maria', 'Dermatologia'),
('Dr. Paulo', 'Neurologia');

-- Inserção de dados de exemplo na tabela Paciente
INSERT INTO Paciente (nome, data_nascimento) 
VALUES 
('Lucas', '1990-01-15'),
('Mariana', '1985-03-22'),
('Gabriel', '2000-05-30'),
('Fernanda', '1995-07-10'),
('Paulo', '1988-11-05');

-- Inserção de dados na tabela associativa Medico_Paciente
INSERT INTO Medico_Paciente (medico_id, paciente_id, data_ultima_consulta) 
VALUES 
(1, 1, '2025-01-10'),  -- Dr. João com Lucas
(1, 2, '2025-02-15'),  -- Dr. João com Mariana
(2, 3, '2025-03-01'),  -- Dra. Ana com Gabriel
(3, 4, '2025-04-05'),  -- Dr. Carlos com Fernanda
(4, 5, '2025-02-20');  -- Dra. Maria com Paulo

-- Seleção 
SELECT * FROM Medico;
SELECT * FROM Paciente;
SELECT * FROM Medico_Paciente;

-- JOIN simples 
SELECT m.nome AS medico, p.nome AS paciente, mp.data_ultima_consulta
FROM Medico m
JOIN Medico_Paciente mp ON m.id = mp.medico_id
JOIN Paciente p ON p.id = mp.paciente_id;