--
-- AERONAVE (n) - (1) PASSAGEIRO 
--

SELECT *
FROM AERONAVE a 
JOIN PASSAGEIRO p ON a.id_passageiro = p.id_passageiro 
WHERE ...

--
-- FUNCIONARIO (n) - FUNCIONARIO-PROJETO - (m) PROJETO
--

SELECT *
FROM FUNCIONARIO as f 
JOIN FUNCIONARIO-PROJETO fp ON f.id_funcionario = fp.id_funcionario
JOIN PROJETO p ON fp.id_projeto = fp.id_projeto 
WHERE ...
