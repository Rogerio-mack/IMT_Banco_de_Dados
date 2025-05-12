-- AERONAVE (1) - (n) PASSAGEIRO 
--
-- AERONAVE (1)       -         (n) PASSAGEIRO 
--     a.id_passageiro = p.id_passageiro 
--

SELECT *
FROM AERONAVE a 
JOIN PASSAGEIRO p ON a.id_passageiro = p.id_passageiro 
WHERE ...

--
-- FUNCIONARIO (n)    -     FUNCIONARIO-PROJETO        -    (m) PROJETO
-- id_funcionario           id_funcionario,id_projeto       id_projeto                     
--
-- (FUNCIONARIO (n)            -                FUNCIONARIO-PROJETO)              -               (m) PROJETO
--        ON f.id_funcionario = fp.id_funcionario                  On fp.id_projeto = p.id_projeto 
--
 
SELECT *
FROM (FUNCIONARIO as f 
JOIN FUNCIONARIO-PROJETO fp ON f.id_funcionario = fp.id_funcionario)
JOIN PROJETO p ON fp.id_projeto = fp.id_projeto 
WHERE ...
