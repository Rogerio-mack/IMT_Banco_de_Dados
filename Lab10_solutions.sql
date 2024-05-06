/* 1. listar o nome dos proprietários de todos os veículos e suas respectivas placas, ordenados pelo nome do cliente.*/

select C.nomecliente, V.placa  from veiculo as V inner join cliente  as C
	on V.idCliente = C.idcliente
    order by C.nomecliente;
    

/* 2. listar o nome dos proprietários de todos os veículos e suas respectivas placas, ordenados pelo nome do cliente, incluindo na listagem os clientes que não possuem veículos. */

select C.nomecliente, V.placa  from veiculo as V right outer join cliente  as C
	on V.idCliente = C.idcliente
    order by C.nomecliente;

/* 3. listar o nome dos proprietários de todos os veículos e suas respectivas placas, ordenados pelo nome do cliente, incluindo na listagem os veículos que não têm clientes à eles associados. */


select C.nomecliente, V.placa  from veiculo as V left  outer join cliente  as C
	on V.idCliente = C.idcliente
    order by C.nomecliente;

/* 4. Escrever a query SQL para exibir o CPF e o nome do cliente que possui o veículo de placa ZYT4WR55.  */

select C.CPF, C.nomecliente  from veiculo as V inner join cliente as C
	on V.idCliente = C.idcliente 
    where V.placa = 'ZU78JU49';
    
/* 5. SQL para exibir o modelo,  a placa e a cor dos veículos estacionados no pátio de código 1. */
    
select V.modelo, V.placa, V.cor from veiculo as V inner join estaciona as E
	on E.idveiculo = V.idveiculo
    where E.idpatio = 1;
    

/* 6. SQL para exibir o modelo,  a placa e a cor dos veículos estacionados no pátio de código 1. */
    
select V.modelo, V.placa, V.cor from veiculo as V inner join estaciona as E
	on E.idveiculo = V.idveiculo
    where E.idpatio = 2;
    
/* 7. query SQL para exibir o modelo,  a placa e a cor dos veículos estacionados no pátio de código 2. */

select V.modelo, V.placa, V.cor from veiculo as V inner join estaciona as E
	on E.idveiculo = V.idveiculo
    where E.idpatio = 2;


/* 8. query SQL para exibir o modelo, a placa, o ano do veículos estacionados em qualquer um dos pátios da empresa; */

select V.modelo, V.placa, V.cor from veiculo as V inner join estaciona as E
	on E.idveiculo = V.idveiculo;
  
/*	9. Escrever a query SQL para exibir o modelo, a placa dos veículos estacionados em qualquer um dos pátios da empresa e que tenham a cor Prata. */

select V.modelo, V.placa from veiculo as V inner join estaciona as E
	on E.idveiculo = V.idveiculo
    where V.cor = 'Prata';

/* 13.	Escrever a query SQL para exibir o modelo, a placa dos veículos estacionados em qualquer um dos pátios da empresa e que não tenham a cor Vermelho. */

select V.modelo, V.placa from veiculo as V inner join estaciona as E
	on E.idveiculo = V.idveiculo
    where V.cor <> 'Vermelho';

/* 14.	Escrever a query SQL para exibir o modelo, a placa dos veículos e a data de entrada no estacionamento em qualquer um dos pátios da empresa. */

select V.modelo, V.placa, E.dataEntrada from veiculo as V inner join estaciona as E
	on E.idveiculo = V.idveiculo;
    
   /* 15.	Escrever a query SQL para exibir o modelo, a placa dos veículos e a data de entrada no estacionamento em qualquer um dos pátios da empresa e que foram estacionados no ano de 2021. */
   
   select V.modelo, V.placa, E.dataEntrada from veiculo as V inner join estaciona as E
	on E.idveiculo = V.idveiculo
    where year(E.dataEntrada) = '2021';
    
    
   


