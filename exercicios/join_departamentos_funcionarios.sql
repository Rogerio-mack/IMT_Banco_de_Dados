-- Lab join_departamentos_funcionarios

DROP DATABASE IF EXISTS join_departamentos_funcionarios;
CREATE DATABASE join_departamentos_funcionarios;
USE join_departamentos_funcionarios;

-- Criação das tabelas
CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    localizacao VARCHAR(50)
);

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

-- Populando as tabelas
INSERT INTO departamentos VALUES 
(1, 'TI', 'Prédio A'),
(2, 'RH', 'Prédio B'),
(3, 'Vendas', 'Prédio C'),
(4, 'Marketing', 'Prédio A'),
(5, 'Financeiro', 'Prédio B');

INSERT INTO funcionarios VALUES 
(1, 'Ana Silva', 'Desenvolvedora', 6500.00, 1),
(2, 'Carlos Santos', 'Analista de RH', 4800.00, 2),
(3, 'Mariana Oliveira', 'Vendedora', 5200.00, 3),
(4, 'João Pereira', 'Analista de Marketing', 4900.00, 4),
(5, 'Roberto Almeida', 'Contador', 6100.00, 5),
(6, 'Fernanda Lima', 'Administradora de BD', 7200.00, 1),
(7, 'Paulo Costa', 'Gerente de Vendas', 8500.00, 3),
(8, 'Luiza Mendes', 'Estagiária TI', 2000.00, 1),
(9, 'Henrique Dias', 'Vendedor', 4800.00, 3),
(10, 'Juliana Martins', 'Assistente de RH', 3200.00, 2),
(11, 'Ricardo Ferreira', 'Designer', 4500.00, NULL),
(12, 'Camila Rocha', 'Social Media', 3800.00, NULL);