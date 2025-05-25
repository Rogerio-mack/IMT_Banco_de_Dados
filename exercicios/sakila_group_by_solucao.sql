-- Exercício 1: Estatísticas de Duração por Classificação Indicativa (rating)
-- Para cada classificação indicativa (rating) de filme, mostre a menor duração, a maior duração, 
-- a duração média e o número total de filmes. Ordene pelo número total de filmes em ordem decrescente.
-- 
use sakila;

SELECT 
    rating,
    MIN(length) AS menor_duracao,
    MAX(length) AS maior_duracao,
    ROUND(AVG(length), 2) AS duracao_media,
    COUNT(*) AS quantidade_filmes
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    quantidade_filmes DESC;

-- Exercício 2: Contagem de Atores por Sobrenome
-- Encontre quantos atores têm o mesmo sobrenome (last_name) na base de dados. 
-- Mostre apenas sobrenomes que aparecem mais de uma vez, e ordene-os pela quantidade de ocorrências em ordem decrescente.

SELECT 
    last_name,
    COUNT(*) AS quantidade_atores
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) > 1
ORDER BY 
    quantidade_atores DESC, last_name;

-- Exercício 3: Contagem de Sobrenomes Repetidos
-- Forneça uma query que dê a quantidade de nomes (last_name) que se repetem (isto é, aparecem mais de uma vez) na tabela de atores.
-- 

SELECT count(*) AS quantidade_sobrenomes_repetidos
FROM
(SELECT 
    last_name
FROM 
    actor a
GROUP BY 
    last_name
HAVING 
    COUNT(*) > 1) AS sobrenomes_repetidos;

-- Exercício 4: Análise de Custo de Reposição
-- Analise o custo de reposição (replacement_cost) dos filmes por categoria de preço de aluguel (rental_rate). 
-- Para cada preço de aluguel, mostre o custo mínimo de reposição, o máximo, a média e o total de filmes. 
-- Crie também uma coluna que classifique o preço de aluguel como "Econômico", "Regular" ou "Premium".
--
-- Neste exercício, crie as categorias com CASE...
-- 
-- CASE
--     WHEN condition1 THEN result1
--     WHEN condition2 THEN result2
--     ELSE result
-- END
--
-- Ver: https://www.w3schools.com/sql/sql_case.asp
--

SELECT 
    rental_rate,
    CASE 
        WHEN rental_rate < 1.0 THEN 'Econômico'
        WHEN rental_rate < 3.0 THEN 'Regular'
        ELSE 'Premium'
    END AS categoria_preco,
    MIN(replacement_cost) AS custo_reposicao_minimo,
    MAX(replacement_cost) AS custo_reposicao_maximo,
    ROUND(AVG(replacement_cost), 2) AS custo_reposicao_medio,
    COUNT(*) AS quantidade_filmes,
    ROUND(SUM(replacement_cost), 2) AS custo_reposicao_total
FROM 
    film
GROUP BY 
    rental_rate,
    CASE 
        WHEN rental_rate < 1.0 THEN 'Econômico'
        WHEN rental_rate < 3.0 THEN 'Regular'
        ELSE 'Premium'
    END
ORDER BY 
    rental_rate;

-- Ou

SELECT 
    rental_rate,
    CASE 
        WHEN rental_rate < 1.0 THEN 'Econômico'
        WHEN rental_rate < 3.0 THEN 'Regular'
        ELSE 'Premium'
    END AS categoria_preco,
    MIN(replacement_cost) AS custo_reposicao_minimo,
    MAX(replacement_cost) AS custo_reposicao_maximo,
    ROUND(AVG(replacement_cost), 2) AS custo_reposicao_medio,
    COUNT(*) AS quantidade_filmes,
    ROUND(SUM(replacement_cost), 2) AS custo_reposicao_total
FROM 
    film
GROUP BY 
    rental_rate,
    categoria_preco
ORDER BY 
    rental_rate;
    
-- Exercício 5: Distribuição de Pagamentos por Mês e Ano
-- Analise a distribuição dos pagamentos por mês e ano. Para cada combinação de mês e ano, mostre o número de pagamentos,
-- o valor total, o valor médio, o menor e o maior pagamento. Ordene cronologicamente e nomeie os meses por extenso.
-- 
-- Neste exercício empregue as funções:
-- YEAR(), MONTH() e MONTHNAME()
-- 

SELECT 
    YEAR(payment_date) AS ano,
    MONTH(payment_date) AS mes_num,
    MONTHNAME(payment_date) AS mes,
    COUNT(*) AS quantidade_pagamentos,
    SUM(amount) AS valor_total,
    ROUND(AVG(amount), 2) AS valor_medio,
    MIN(amount) AS menor_pagamento,
    MAX(amount) AS maior_pagamento
FROM 
    payment
GROUP BY 
    YEAR(payment_date),
    MONTH(payment_date),
    MONTHNAME(payment_date)
ORDER BY 
    ano, mes_num;

-- Exercício 6: Clientes com mais pagamentos  
-- Identifique os clientes que fizeram mais de 40 pagamentos. Liste o ID do cliente, a quantidade de pagamentos e o 
-- valor total gasto. Ordene pelo valor total em ordem decrescente.
--

SELECT 
    customer_id,
    COUNT(*) AS quantidade_pagamentos,
    SUM(amount) AS valor_total_gasto
FROM 
    payment
GROUP BY 
    customer_id
HAVING 
    COUNT(*) > 40
ORDER BY 
    valor_total_gasto DESC;

-- Exercício 6b: Clientes com mais pagamentos  
-- Identifique os clientes que fizeram mais de 40 pagamentos. Liste o ID do cliente, o nome do cliente e a quantidade de pagamentos e o 
-- valor total gasto. Ordene pelo nome dos clientes.
--
-- Empregue a função CONCAT( ) para gerar o nome dos clientes
--

SELECT 
    CONCAT(c.first_name, " ", c.last_name) AS nome,
    p.customer_id,
    c.last_update,
    COUNT(*) AS quantidade_pagamentos,
    SUM(p.amount) AS valor_total_gasto
FROM 
    payment p
JOIN customer c USING (customer_id) 
GROUP BY 
    customer_id
HAVING 
    COUNT(*) > 40
ORDER BY 
    nome;

-- Exercício 6c: Clientes com mais pagamentos  
-- Identifique os clientes que fizeram mais de 20 pagamentos que não estão mais ativos e tiveram gastos superiores a USD 100.00. 
-- Liste o ID do cliente, o nome do cliente, o status e a quantidade de pagamentos e o valor total gasto. 
-- Ordene pelo nome dos clientes.
--

SELECT 
    CONCAT(c.first_name, " ", c.last_name) AS nome,
    p.customer_id,
    c.active,
    COUNT(*) AS quantidade_pagamentos,
    SUM(p.amount) AS valor_total_gasto
FROM 
    payment p
JOIN customer c USING (customer_id) 
WHERE c.active = FALSE 
GROUP BY 
    customer_id
HAVING 
    COUNT(*) > 20 AND
    SUM(p.amount) > 100
ORDER BY 
    nome;
    
-- Exercício 6d: Clientes com mais pagamentos  
-- Adicione à consulta anterior o código postal do cliente
--

SELECT 
    CONCAT(c.first_name, " ", c.last_name) AS nome,
    p.customer_id,
    c.active,
    a.postal_code,
    COUNT(*) AS quantidade_pagamentos,
    SUM(p.amount) AS valor_total_gasto
FROM 
    payment p
JOIN customer c USING (customer_id)
JOIN address a USING (address_id) 
WHERE c.active = FALSE 
GROUP BY 
    customer_id
HAVING 
    COUNT(*) > 20 AND
    SUM(p.amount) > 100
ORDER BY 
    nome;
    
-- Exercício 6e: Clientes com mais pagamentos  
-- Adicione agora, à consulta anterior o nome da cidade, mas selecione somente cidades na China.
--

SELECT 
    CONCAT(c.first_name, " ", c.last_name) AS nome,
    p.customer_id,
    c.active,
    a.postal_code,
    cc.city,
    ccc.country,
    COUNT(*) AS quantidade_pagamentos,
    SUM(p.amount) AS valor_total_gasto
FROM 
    payment p
JOIN customer c USING (customer_id)
JOIN address a USING (address_id) 
JOIN city cc USING (city_id) 
JOIN country ccc USING (country_id) 
WHERE c.active = FALSE AND
ccc.country = 'China'
GROUP BY 
    customer_id
HAVING 
    COUNT(*) > 20 AND
    SUM(p.amount) > 100
ORDER BY 
    nome;
        
-- Exercício 7: Análise da Receita por Funcionário
-- Liste a receita total gerada por cada funcionário (staff) no banco de dados Sakila. 
-- Mostre o ID do funcionário, seu nome, e o total arrecadado. Ordene do funcionário que mais arrecadou para o que menos arrecadou.
--

SELECT 
    p.staff_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_arrecadado
FROM payment p
JOIN staff s USING (staff_id)
GROUP BY 
    p.staff_id -- , s.first_name, s.last_name
ORDER BY 
    total_arrecadado DESC;
