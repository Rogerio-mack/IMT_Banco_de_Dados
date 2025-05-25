CREATE DATABASE IF NOT EXISTS empresa_exemplo;
USE empresa_exemplo;

-- Criar tabela de funcionários com relacionamento recursivo para supervisor
CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES funcionarios(id)
);

-- Criar tabela de projetos
CREATE TABLE projetos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- Criar tabela associativa funcionario_projeto
CREATE TABLE funcionario_projeto (
    funcionario_id INT,
    projeto_id INT,
    horas_alocadas INT,
    PRIMARY KEY (funcionario_id, projeto_id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id),
    FOREIGN KEY (projeto_id) REFERENCES projetos(id)
);

INSERT INTO funcionarios (nome, cargo, supervisor_id) VALUES
('Beatriz de Siqueira', 'Gerente', NULL),  -- id=1 (sem supervisor)
('Gabriel Lippi', 'Analista', 1),          -- id=2
('Sofia Bueno', 'Desenvolvedor', 1),       -- id=3
('Arthur Del Rio', 'Estagiário', 2),       -- id=4
('Giulia Passiani', 'Designer', NULL);     -- id=5 (sem supervisor)

INSERT INTO projetos (nome, descricao) VALUES
('Sistema Web Interno', 'Ferramenta para uso interno da empresa'),     -- id=1
('Aplicativo Mobile', 'App para clientes acessarem serviços'),         -- id=2
('Migração de Dados', 'Migração de dados legado para novo sistema');   -- id=3

INSERT INTO funcionario_projeto (funcionario_id, projeto_id, horas_alocadas) VALUES
(2, 1, 20),    
(3, 1, 35),   
(3, 2, 10),    
(4, 2, 5);     

-- Observações:
-- - Projeto 3 "Migração de Dados" não tem funcionários associados.
-- - Funcionário 5 (Giulia Passiani) não está associado a nenhum projeto.

select * from funcionarios;
select * from projetos; 

