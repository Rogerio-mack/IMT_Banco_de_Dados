-- Exercício 1: 
-- Liste os nomes dos clientes e os modelos dos veículos que eles possuem, incluindo apenas os clientes que possuem 
-- veículos da cor "Preto". Ordene o resultado pelo nome do cliente.

SELECT c.nomeCliente, v.modelo, v.placa, v.cor
FROM cliente c
INNER JOIN veiculo v ON c.idCliente = v.idCliente
WHERE v.cor = 'Preto'
ORDER BY c.nomeCliente;

-- Exercício 2:
-- Liste todos os veículos (placa, modelo, cor) e seus respectivos proprietários (nome e CPF), 
-- incluindo os veículos que não têm proprietário registrado. Mostre apenas os veículos cujo modelo contém a 
-- letra 'O' e que são das cores 'Preto', 'Branco' ou 'Vermelho'. Ordene o resultado por modelo do veículo.

SELECT v.placa, v.modelo, v.cor, c.nomeCliente, c.CPF
FROM veiculo v
LEFT JOIN cliente c ON v.idCliente = c.idCliente
WHERE v.modelo LIKE '%O%'
AND v.cor IN ('Preto', 'Branco', 'Vermelho')
ORDER BY v.modelo;

-- Exercício 3: 
-- Liste todos os veículos (placa, modelo, cor), seus proprietários (nome) e os pátios (endereço) onde já estacionaram, 
-- incluindo veículos que nunca estacionaram em nenhum pátio. 
-- Mostre apenas os veículos cujos proprietários são mais jovens que a média de idade de todos os clientes. 
-- Ordene o resultado pela data de nascimento do proprietário.

SELECT v.placa, v.modelo, v.cor, c.nomeCliente, c.dataNascimento, p.enderecoPatio
FROM veiculo v
LEFT JOIN cliente c ON v.idCliente = c.idCliente
LEFT JOIN estaciona e ON v.idVeiculo = e.idVeiculo
LEFT JOIN patio p ON e.idPatio = p.idPatio
WHERE c.dataNascimento > (
    SELECT AVG(dataNascimento) 
    FROM cliente
)
ORDER BY c.dataNascimento DESC;

-- Exercício 4: 
-- Calcule o número de veículos por cor e modelo, mostrando apenas as combinações que aparecem mais de uma vez. 
-- Mostre a cor, o modelo e a contagem, ordenando pelo número de veículos em ordem decrescente.

SELECT cor, modelo, COUNT(*) as quantidade
FROM veiculo
GROUP BY cor, modelo
HAVING COUNT(*) > 1
ORDER BY quantidade DESC;

-- Exercício 5:  
-- Enunciado: Para cada cliente, mostre o nome, a quantidade de veículos que possui, e a média de tempo (em dias) que seus 
-- veículos ficaram estacionados (considere a diferença entre data de saída e data de entrada). 
-- Inclua apenas clientes que possuem mais de um veículo, e ordene pelo nome do cliente.

SELECT 
    c.nomeCliente,
    COUNT(v.idVeiculo) as quantidade_veiculos,
    AVG(DATEDIFF(e.dataSaida, e.dataEntrada)) as media_dias_estacionados
FROM 
    cliente c
INNER JOIN 
    veiculo v ON c.idCliente = v.idCliente
LEFT JOIN 
    estaciona e ON v.idVeiculo = e.idVeiculo
GROUP BY 
    c.idCliente, c.nomeCliente
HAVING 
    COUNT(v.idVeiculo) > 1
ORDER BY 
    c.nomeCliente;

-- Exercício 6:  
-- Analise a utilização dos pátios: para cada pátio, mostre o endereço, a capacidade, o número de veículos distintos 
-- que já estacionaram nele, e o número de proprietários distintos desses veículos. Inclua todos os pátios, mesmo 
-- aqueles que nunca tiveram veículos estacionados. Ordene pelo número de veículos em ordem decrescente.

SELECT 
    p.idPatio,
    p.enderecoPatio,
    p.capacidadePatio,
    COUNT(DISTINCT e.idVeiculo) as quantidade_veiculos,
    COUNT(DISTINCT c.idCliente) as quantidade_proprietarios
FROM 
    patio p
LEFT JOIN 
    estaciona e ON p.idPatio = e.idPatio
LEFT JOIN 
    veiculo v ON e.idVeiculo = v.idVeiculo
LEFT JOIN 
    cliente c ON v.idCliente = c.idCliente
GROUP BY 
    p.idPatio, p.enderecoPatio, p.capacidadePatio
ORDER BY 
    quantidade_veiculos DESC;
