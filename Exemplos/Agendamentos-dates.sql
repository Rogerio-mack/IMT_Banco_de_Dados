USE Exemplos;

-- Criação da tabela
CREATE TABLE Agendamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    data_agendamento DATE,
    hora_agendamento TIME
);

-- Inserção de dados de exemplo
INSERT INTO Agendamentos (descricao, data_agendamento, hora_agendamento)
VALUES 
('Consulta Médica', '2025-03-23', '10:00:00'),
('Reunião de Projeto', '2025-03-24', '14:30:00'),
('Aula de Yoga', '2025-03-25', '18:00:00'),
('Jantar com Amigos', '2025-03-26', '20:00:00'),
('Exame de Rotina', '2025-03-27', '09:00:00');

-- Seleção dos dados com formatação original
SELECT * FROM Agendamentos;

-- Soma de dias nas datas
SELECT id, descricao, DATE_ADD(data_agendamento, INTERVAL 7 DAY) AS nova_data 
FROM Agendamentos;

-- Diferença de dias entre duas datas
SELECT id, descricao, DATEDIFF('2025-03-28', data_agendamento) AS dias_para_evento
FROM Agendamentos;