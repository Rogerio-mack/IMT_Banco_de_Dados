USE Exemplos;

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(15)
);

CREATE TABLE Dependente (
    id_cliente INT,
    id_dependente INT,
    nome VARCHAR(100),
    idade INT,
    PRIMARY KEY (id_cliente, id_dependente),  -- Chave composta
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE
);

-- Inserindo clientes
INSERT INTO Cliente (id_cliente, nome, telefone) VALUES (1, 'João', '9999-8888');
INSERT INTO Cliente (id_cliente, nome, telefone) VALUES (2, 'Maria', '8888-7777');

-- Inserindo dependentes
INSERT INTO Dependente (id_cliente, id_dependente, nome, idade) VALUES (1, 1, 'Pedro', 12);
INSERT INTO Dependente (id_cliente, id_dependente, nome, idade) VALUES (1, 2, 'Ana', 8);
INSERT INTO Dependente (id_cliente, id_dependente, nome, idade) VALUES (2, 1, 'Carla', 15);

SELECT c.nome AS Cliente, d.nome AS Dependente, d.idade
FROM Cliente c
JOIN Dependente d ON c.id_cliente = d.id_cliente;

