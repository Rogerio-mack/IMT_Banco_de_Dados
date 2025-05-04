DROP DATABASE IF EXISTS vendas;
CREATE DATABASE vendas;
USE vendas;

-- Criação da tabela de clientes
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE,
    cidade VARCHAR(50),
    estado CHAR(2),
    faixa_etaria VARCHAR(20),
    status VARCHAR(20)
);

-- Criação da tabela de produtos
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco_unitario DECIMAL(10, 2),
    custo DECIMAL(10, 2),
    estoque INT,
    fornecedor VARCHAR(100)
);

-- Criação da tabela de vendas
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT,
    data_venda DATE,
    valor_total DECIMAL(10, 2),
    forma_pagamento VARCHAR(30),
    status_entrega VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Criação da tabela de itens de venda (detalhe da venda)
CREATE TABLE itens_venda (
    id_venda INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    desconto DECIMAL(10, 2),
    PRIMARY KEY (id_venda, id_produto),
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- Populando as tabelas com dados
INSERT INTO clientes VALUES
(1, 'Maria Oliveira', 'maria@email.com', '2022-01-15', 'São Paulo', 'SP', '30-40', 'Ativo'),
(2, 'João Silva', 'joao@email.com', '2022-02-20', 'Rio de Janeiro', 'RJ', '20-30', 'Ativo'),
(3, 'Ana Santos', 'ana@email.com', '2022-03-10', 'Belo Horizonte', 'MG', '40-50', 'Ativo'),
(4, 'Carlos Ferreira', 'carlos@email.com', '2022-04-05', 'São Paulo', 'SP', '30-40', 'Inativo'),
(5, 'Beatriz Lima', 'beatriz@email.com', '2022-05-12', 'Curitiba', 'PR', '20-30', 'Ativo'),
(6, 'Roberto Alves', 'roberto@email.com', '2022-06-18', 'Salvador', 'BA', '50-60', 'Ativo'),
(7, 'Fernanda Costa', 'fernanda@email.com', '2022-07-22', 'Recife', 'PE', '30-40', 'Ativo'),
(8, 'André Martins', 'andre@email.com', '2022-08-30', 'Porto Alegre', 'RS', '40-50', 'Inativo'),
(9, 'Camila Rocha', 'camila@email.com', '2022-09-05', 'São Paulo', 'SP', '20-30', 'Ativo'),
(10, 'Lucas Dias', 'lucas@email.com', '2022-10-10', 'Brasília', 'DF', '30-40', 'Ativo');

INSERT INTO produtos VALUES
(1, 'Smartphone XYZ', 'Eletrônicos', 1500.00, 900.00, 50, 'TechMaster'),
(2, 'Notebook Ultra', 'Eletrônicos', 3200.00, 2200.00, 30, 'TechMaster'),
(3, 'Tênis Esportivo', 'Calçados', 250.00, 120.00, 100, 'SportGear'),
(4, 'Camiseta Casual', 'Vestuário', 89.90, 35.00, 200, 'FashionStyle'),
(5, 'Fone de Ouvido Bluetooth', 'Eletrônicos', 180.00, 75.00, 80, 'SoundMax'),
(6, 'Livro "Programação SQL"', 'Livros', 85.00, 40.00, 60, 'EduBooks'),
(7, 'Cafeteira Elétrica', 'Eletrodomésticos', 230.00, 130.00, 40, 'HomeTech'),
(8, 'Mochila Escolar', 'Acessórios', 120.00, 50.00, 90, 'SchoolSupplies'),
(9, 'Mouse sem Fio', 'Eletrônicos', 95.00, 40.00, 70, 'TechMaster'),
(10, 'Cadeira de Escritório', 'Móveis', 450.00, 280.00, 25, 'OfficePro'),
(11, 'Perfume Floral', 'Cosméticos', 180.00, 80.00, 55, 'BeautyShop'),
(12, 'Relógio de Pulso', 'Acessórios', 350.00, 180.00, 35, 'TimeStyle'),
(13, 'Database Book', 'Livro', 100.00, 80.00, 100, 'BookStore');

INSERT INTO vendas VALUES
(1, 1, '2023-01-10', 1500.00, 'Cartão de Crédito', 'Entregue'),
(2, 2, '2023-01-15', 3200.00, 'Cartão de Crédito', 'Entregue'),
(3, 3, '2023-01-20', 339.90, 'Boleto Bancário', 'Entregue'),
(4, 1, '2023-02-05', 180.00, 'Cartão de Débito', 'Entregue'),
(5, 5, '2023-02-10', 450.00, 'PIX', 'Em trânsito'),
(6, 6, '2023-02-15', 265.00, 'Cartão de Crédito', 'Entregue'),
(7, 7, '2023-03-01', 3430.00, 'Cartão de Crédito', 'Entregue'),
(8, 8, '2023-03-10', 450.00, 'Boleto Bancário', 'Cancelado'),
(9, 9, '2023-03-15', 230.00, 'PIX', 'Entregue'),
(10, 10, '2023-03-20', 95.00, 'Cartão de Débito', 'Entregue'),
(11, 1, '2023-04-05', 470.00, 'Cartão de Crédito', 'Entregue'),
(12, 3, '2023-04-10', 1680.00, 'PIX', 'Em trânsito'),
(13, 5, '2023-04-15', 350.00, 'Cartão de Crédito', 'Entregue'),
(14, 7, '2023-04-25', 3285.00, 'Cartão de Crédito', 'Entregue'),
(15, 9, '2023-05-01', 85.00, 'PIX', 'Em processamento');

INSERT INTO itens_venda VALUES
(1, 1, 1, 1500.00, 0.00),
(2, 2, 1, 3200.00, 0.00),
(3, 3, 1, 250.00, 0.00),
(3, 4, 1, 89.90, 0.00),
(4, 5, 1, 180.00, 0.00),
(5, 10, 1, 450.00, 0.00),
(6, 6, 1, 85.00, 0.00),
(6, 9, 1, 95.00, 0.00),
(6, 3, 1, 250.00, 85.00),  
(7, 2, 1, 3200.00, 0.00),
(7, 9, 1, 95.00, 0.00),
(7, 5, 1, 180.00, 45.00),  
(8, 10, 1, 450.00, 0.00),
(9, 7, 1, 230.00, 0.00),
(10, 9, 1, 95.00, 0.00),
(11, 8, 1, 120.00, 0.00),
(11, 11, 1, 180.00, 0.00),
(11, 9, 2, 95.00, 20.00),  
(12, 1, 1, 1500.00, 0.00),
(12, 5, 1, 180.00, 0.00),
(13, 12, 1, 350.00, 0.00),
(14, 2, 1, 3200.00, 0.00),
(14, 3, 1, 250.00, 150.00), 
(14, 4, 1, 89.90, 54.90),  
(15, 6, 1, 85.00, 0.00);
