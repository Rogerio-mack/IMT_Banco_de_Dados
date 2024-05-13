-- Questão 1
SELECT p.idPedido, p.dataPedido, p.valorPedido
FROM pedidos p
JOIN clientes c ON p.idCliente = c.idCliente
WHERE c.nomeCliente = 'Pedro de Souza Alves';

-- Questão 2
SELECT pr.descProduto
FROM produtos pr
JOIN itensPedidos ip ON pr.idProduto = ip.idProduto
WHERE ip.idPedido = 10;

-- Questão 3
SELECT DISTINCT v.nomeVendedor
FROM vendedores v
JOIN pedidos p ON v.idVendedor = p.idVendedor;

-- Questão 4
SELECT c.nomeCliente
FROM clientes c
LEFT JOIN pedidos p ON c.idCliente = p.idCliente
WHERE p.idPedido IS NULL;

-- Questão 5
SELECT p.idPedido, p.dataPedido, p.valorPedido 
FROM pedidos p
JOIN clientes c ON p.idCliente = c.idCliente
JOIN vendedores v ON p.idVendedor = v.idVendedor
WHERE c.nomeCliente = 'Pedro de Souza Alves' AND v.nomeVendedor LIKE 'S%'; -- Cuidado só existe um

-- Questão 6
SELECT p.idPedido, p.dataPedido, p.valorPedido, f.descricaoFabricante
FROM pedidos p
JOIN clientes c ON p.idCliente = c.idCliente
JOIN itensPedidos ip ON p.idPedido = ip.idPedido
JOIN produtos pr ON ip.idProduto = pr.idProduto
JOIN fabricantes f ON pr.idFabricante = f.idFabricante
WHERE c.nomeCliente = 'Beatriz Souza' AND f.descricaoFabricante in ('HP','Acer','Corsair'); -- HP or Acer or Corsair

-- Questão 7
SELECT v.nomeVendedor, c.nomeCliente
FROM vendedores v
JOIN pedidos p ON v.idVendedor = p.idVendedor
JOIN clientes c ON p.idCliente = c.idCliente;

-- Questão 8
SELECT idPedido, dataPedido, valorPedido
FROM pedidos
WHERE valorPedido > (SELECT AVG(valorPedido) FROM pedidos);

-- Questão 9
SELECT pr.descProduto, c.nomeCliente, v.nomeVendedor
FROM produtos pr
JOIN itensPedidos ip ON pr.idProduto = ip.idProduto
JOIN pedidos p ON ip.idPedido = p.idPedido
JOIN clientes c ON p.idCliente = c.idCliente
JOIN vendedores v ON p.idVendedor = v.idVendedor 
WHERE (c.nomeCliente LIKE '%Silva%' OR c.nomeCliente LIKE '%Souza%') 
AND (v.nomeVendedor LIKE '%Santos%' OR v.nomeVendedor LIKE '%Silva%' OR v.nomeVendedor LIKE '%Souza%'); -- Many names...

-- Questão 10
SELECT p.idPedido, p.dataPedido, p.valorPedido
FROM pedidos p
JOIN clientes c ON p.idCliente = c.idCliente
JOIN vendedores v ON p.idVendedor = v.idVendedor
WHERE c.cpfCliente = (SELECT cpfCliente FROM clientes WHERE nomeCliente = 'Pedro de Souza Alves')
AND v.quotaVendas > 1000; -- 1000

-- Questão 11
SELECT c.nomeCliente, f.descricaoFabricante
FROM clientes c
JOIN pedidos p ON c.idCliente = p.idCliente
JOIN itensPedidos ip ON p.idPedido = ip.idPedido
JOIN produtos pr ON ip.idProduto = pr.idProduto
JOIN fabricantes f ON pr.idFabricante = f.idFabricante
WHERE f.descricaoFabricante IN ('Acer', 'Xiomi')
GROUP BY c.nomeCliente
HAVING COUNT(DISTINCT f.descricaoFabricante) = 2; -- anular

-- Questão 12
SELECT DISTINCT v.nomeVendedor -- ,  pr.descProduto , f.descricaoFabricante
FROM vendedores v
JOIN pedidos p ON v.idVendedor = p.idVendedor
JOIN itensPedidos ip ON p.idPedido = ip.idPedido
JOIN produtos pr ON ip.idProduto = pr.idProduto
JOIN fabricantes f ON pr.idFabricante = f.idFabricante
WHERE pr.descProduto LIKE '%Computador%' AND (f.descricaoFabricante = 'Acer' OR f.descricaoFabricante = 'Dell'); -- Acer e Dell

-- Questão 13
SELECT pr.descProduto
FROM produtos pr
JOIN itensPedidos ip ON pr.idProduto = ip.idProduto
JOIN pedidos p ON ip.idPedido = p.idPedido
JOIN clientes c ON p.idCliente = c.idCliente
WHERE c.nomeCliente = 'Pedro de Souza Alves' AND ip.qtdePedida > 2; -- 2

-- Questão 14
SELECT p.idPedido, p.dataPedido, p.valorPedido,  c.nomeCliente, v.quotaVendas 
FROM pedidos p
JOIN clientes c ON p.idCliente = c.idCliente
JOIN vendedores v ON p.idVendedor = v.idVendedor
WHERE c.nomeCliente LIKE '%Andrade%' AND v.quotaVendas < 10000; -- Valor e Andrade

-- Questão 8A
SELECT c.nomeCliente
FROM clientes c
LEFT JOIN pedidos p ON c.idCliente = p.idCliente
LEFT JOIN itensPedidos ip ON p.idPedido = ip.idPedido
LEFT JOIN produtos pr ON ip.idProduto = pr.idProduto
LEFT JOIN fabricantes f ON pr.idFabricante = f.idFabricante
GROUP BY c.nomeCliente
HAVING COUNT(DISTINCT f.descricaoFabricante) = 2;

-- Questão 8B
SELECT v.nomeVendedor, c.nomeCliente
FROM vendedores v
LEFT JOIN pedidos p ON v.idVendedor = p.idVendedor
LEFT JOIN clientes c ON p.idCliente = c.idCliente;
-- WHERE c.nomeCliente IS NULL; -- adicione isso
