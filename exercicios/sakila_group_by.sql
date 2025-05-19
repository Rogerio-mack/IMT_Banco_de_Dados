-- Exercício 1: Estatísticas de Duração por Classificação Indicativa (rating)
-- Para cada classificação indicativa (rating) de filme, mostre a menor duração, a maior duração, 
-- a duração média e o número total de filmes. Ordene pelo número total de filmes em ordem decrescente.
-- 

-- Exercício 2: Contagem de Atores por Sobrenome
-- Encontre quantos atores têm o mesmo sobrenome (last_name) na base de dados. 
-- Mostre apenas sobrenomes que aparecem mais de uma vez, e ordene-os pela quantidade de ocorrências em ordem decrescente.
--

-- Exercício 3: Contagem de Sobrenomes Repetidos
-- Forneça uma query que dê a quantidade de nomes (last_name) que se repetem (isto é, aparecem mais de uma vez) na tabela de atores.
-- 

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
   
-- Exercício 5: Distribuição de Pagamentos por Mês e Ano
-- Analise a distribuição dos pagamentos por mês e ano. Para cada combinação de mês e ano, mostre o número de pagamentos,
-- o valor total, o valor médio, o menor e o maior pagamento. Ordene cronologicamente e nomeie os meses por extenso.
-- 
-- Neste exercício empregue as funções:
-- YEAR(), MONTH() e MONTHNAME()
-- 

-- Exercício 6: Clientes com mais pagamentos  
-- Identifique os clientes que fizeram mais de 40 pagamentos. Liste o ID do cliente, a quantidade de pagamentos e o 
-- valor total gasto. Ordene pelo valor total em ordem decrescente.
--

-- Exercício 6b: Clientes com mais pagamentos  
-- Identifique os clientes que fizeram mais de 40 pagamentos. Liste o ID do cliente, o nome do cliente e a quantidade de pagamentos e o 
-- valor total gasto. Ordene pelo nome dos clientes.
--
-- Empregue a função CONCAT( ) para gerar o nome dos clientes
--

-- Exercício 6c: Clientes com mais pagamentos  
-- Identifique os clientes que fizeram mais de 20 pagamentos que não estão mais ativos e tiveram gastos superiores a USD 100.00. 
-- Liste o ID do cliente, o nome do cliente, o status e a quantidade de pagamentos e o valor total gasto. 
-- Ordene pelo nome dos clientes.
--

-- Exercício 6d: Clientes com mais pagamentos  
-- Adicione à consulta anterior o código postal do cliente
--

-- Exercício 6e: Clientes com mais pagamentos  
-- Adicione agora, à consulta anterior o nome da cidade, mas selecione somente cidades na China.
--
       
-- Exercício 7: Análise da Receita por Funcionário
-- Liste a receita total gerada por cada funcionário (staff) no banco de dados Sakila. 
-- Mostre o ID do funcionário, seu nome, e o total arrecadado. Ordene do funcionário que mais arrecadou para o que menos arrecadou.
--



