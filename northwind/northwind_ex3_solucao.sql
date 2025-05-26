/*
7E.  Liste os IDs dos funcionários que fizeram mais de 50 pedidos. (Como ficaria com o nome deles?)
*/

SELECT EmployeeID, COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY EmployeeID
HAVING COUNT(OrderID) > 50;

/* 
7F. Liste os produtos que tiveram um total de vendas (quantidade) superior a 500.
*/

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM orderdetails
GROUP BY ProductID
HAVING SUM(Quantity) > 500;

/*
Problemas Intermediários
*/

/*
8. Para este problema, gostaríamos de ver o número total de produtos em cada categoria. Classifique os resultados pelo número total de produtos, em ordem decrescente.
*/

SELECT  C.CategoryName
       ,COUNT(P.CategoryID) AS TotalProducts
  FROM Categories AS C
  JOIN Products AS P
    ON P.CategoryID = C.CategoryID
 GROUP BY C.CategoryName
 ORDER BY TotalProducts DESC;

/*
9. Na tabela Clientes, mostre o número total de clientes por País e Cidade.
*/

SELECT  Country
       ,City
	   ,COUNT(CustomerID) AS TotalCustomers
  FROM Customers
 GROUP BY Country, City
 ORDER BY TotalCustomers DESC;

/*
10. Alguns dos países da base de dados têm taxas de frete muito altas. Gostaríamos de investigar mais algumas opções de envio para nossos clientes, para poder oferecer-lhes taxas de frete mais baixas. Retorne os três países de navio com o maior frete médio geral, em ordem decrescente por frete médio.
*/

SELECT  TOP(3) ShipCountry
       ,AVG(Freight) AS AverageFreight
  FROM Orders
 GROUP BY ShipCountry
 ORDER BY AverageFreight DESC;

/*
11. Continuamos na questão acima sobre as altas taxas de frete. Agora, em vez de usar todos os pedidos que temos, queremos apenas ver pedidos do ano de 2015.
*/

SELECT  TOP(3) ShipCountry
       ,AVG(Freight) AS AverageFreight
  FROM Orders
  WHERE YEAR(OrderDate) = '2015'
 GROUP BY ShipCountry
 ORDER BY AverageFreight DESC;

/*
12. Continuamos trabalhando com altas taxas de frete. Queremos agora obter os três países de navios com as taxas de frete médias mais elevadas. Mas, em vez de filtrar para um determinado ano, queremos usar os últimos 12 meses de dados do pedido, usando como data de término o último OrderDate em Pedidos.
*/

SELECT  TOP(3) ShipCountry
       ,AVG(Freight) AS AverageFreight
  FROM Orders
  WHERE OrderDate BETWEEN (SELECT DATEADD(YEAR, -1, MAX(OrderDate))
                             FROM Orders) 
						  
						  AND

						  (SELECT MAX(OrderDate)
						     FROM Orders)
 GROUP BY ShipCountry
 ORDER BY AverageFreight DESC;

/*
13. Há alguns clientes que nunca fizeram um pedido. Mostre a esses clientes.
*/

SELECT  C.CustomerID AS Customer_CustomerID
	   ,O.CustomerID AS Orders_CustomerID
  FROM Customers AS C
  LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
 WHERE O.CustomerID IS NULL;

/*
14. Você quer enviar a todos os clientes de alto valor um presente VIP especial. Vamos definir clientes de alto valor como aqueles que fizeram pelo menos 1 pedido com um valor total (sem incluir o desconto) igual a US$ 10.000 ou mais. Queremos considerar apenas os pedidos feitos no ano de 2016.
*/

select c.CustomerID, c.CompanyName, o.OrderID, cast(sum(d.UnitPrice * d.Quantity) as decimal(10,2)) as TotalOrderAmount 
from Orders o 
left join OrderDetails d using (OrderID) 
left join Customers c using (CustomerID)
where o.OrderDate >= '2016-01-01' and o.OrderDate < '2017-01-01'
group by c.CustomerID, c.CompanyName, o.OrderID
having sum(d.UnitPrice * d.Quantity) >= 10000
order by TotalOrderAmount desc;

-- alternative solution
select p.CustomerID, p.CompanyName, p.OrderID, p.TotalOrderAmount from
(select c.CustomerID, c.CompanyName, o.OrderID, cast(sum(d.UnitPrice * d.Quantity) as decimal(10,2)) as TotalOrderAmount 
from Orders o 
left join OrderDetails d using (OrderID) 
left join Customers c using (CustomerID)
where o.OrderDate >= '2016-01-01' and o.OrderDate < '2017-01-01'
group by c.CustomerID, c.CompanyName, o.OrderID) p
where p.TotalOrderAmount >= 10000
order by p.TotalOrderAmount desc;

/*
15. Uma das vendedoras, veio até você com um pedido. Ela acha que acidentalmente inseriu duas vezes um item de linha em um pedido, com um ProductID diferente, mas a mesma quantidade. Ela lembra que a quantidade era de 60 ou mais. Mostre todos os OrderIDs com itens de linha que correspondam a isso, na ordem de OrderID.
*/

select o.OrderID 
from OrderDetails o 
where o.Quantity >= 60
group by o.OrderID, o.Quantity
having count(o.OrderID) > 1
order by o.OrderID;

/*
16. Com base na pergunta anterior, queremos agora mostrar detalhes do pedido, para pedidos que correspondem aos critérios acima.
*/

select o.* 
from OrderDetails o 
where o.OrderID in
(select o.OrderID from OrderDetails o where o.Quantity >= 60
group by o.OrderID, o.Quantity
having count(o.OrderID) > 1
order by o.OrderID);
