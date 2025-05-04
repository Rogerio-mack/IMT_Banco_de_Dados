USE vendas;

-- agregações simples
SELECT COUNT(*) AS quantidade_vendas
FROM vendas;

SELECT SUM(valor_total) AS valor_total_vendas
FROM vendas;

SELECT COUNT(*) AS quantidade_vendas, AVG(valor_total) AS quantidade_vendas
FROM vendas;

-- GROUP BY forma_pagamento
SELECT forma_pagamento, 
    COUNT(*) AS quantidade_vendas,
    SUM(valor_total) AS valor_total_vendas,
    ROUND(AVG(valor_total), 2) AS valor_medio_venda
FROM vendas
GROUP BY forma_pagamento
ORDER BY valor_total_vendas DESC;

-- GROUP BY YEAR(data_venda), MONTH(data_venda)
SELECT YEAR(data_venda) AS ano,
    MONTH(data_venda) AS mes,
    COUNT(*) AS quantidade_vendas,
    SUM(valor_total) AS valor_total_vendas,
    ROUND(MIN(valor_total), 2) AS menor_venda,
    ROUND(MAX(valor_total), 2) AS maior_venda
FROM vendas
GROUP BY YEAR(data_venda), MONTH(data_venda)
ORDER BY ano, mes;

-- GROUP BY categoria, fornecedor
SELECT categoria,
    fornecedor,
    MIN(preco_unitario) AS preco_minimo,
    MAX(preco_unitario) AS preco_maximo
FROM produtos
GROUP BY categoria, fornecedor
ORDER BY categoria, fornecedor;

-- GROUP BY categoria HAVING  
SELECT categoria,
	COUNT(fornecedor) AS qde_fornecedores,
    MIN(preco_unitario) AS preco_minimo,
    MAX(preco_unitario) AS preco_maximo
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 1 
ORDER BY categoria;

-- GROUP BY categoria HAVING  
SELECT categoria,
	COUNT(fornecedor) AS qde_fornecedores,
    MIN(preco_unitario) AS preco_minimo,
    MAX(preco_unitario) AS preco_maximo
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 1 AND preco_maximo < 400
ORDER BY categoria;

-- EXISTS
SELECT categoria, nome 
FROM produtos p
WHERE EXISTS (SELECT 1 FROM itens_venda 
		      WHERE id_produto = p.id_produto);
              
SELECT categoria, nome 
FROM produtos p
WHERE NOT EXISTS (SELECT 1 FROM itens_venda 
		      WHERE id_produto = p.id_produto);