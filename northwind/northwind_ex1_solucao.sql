/* 
Problemas Básicos
*/
USE Northwind;

/* 
1. Na tabela OrderDetails, temos os campos UnitPrice e Quantity. Crie um novo campo, TotalPrice e retorne também OrderID, ProductID, UnitPrice e Quantity. Ordene por OrderID e ProductID.
*/ 

SELECT  OrderId
       ,ProductID
	   ,UnitPrice
	   ,Quantity
	   ,(UnitPrice * Quantity) AS TotalPrice
  FROM OrderDetail
  Order BY OrderId, ProductID;

/*
2. Quantos clientes temos na tabela Clientes?
*/

SELECT COUNT(CustId) AS TotalCustomers
  FROM Customer;

/*
3. Mostre a data do primeiro pedido já feito na tabela Pedidos.
*/

SELECT OrderDate  
 FROM salesorder
 Order BY OrderDate ASC LIMIT 1;
 
SELECT OrderDate
  FROM salesorder
  WHERE OrderDate = (SELECT MIN(OrderDate)
					 FROM salesorder);

/*
4. Mostre uma lista de países onde a empresa Northwind tem clientes.
*/

SELECT Country
  FROM Customer
 GROUP BY Country;
 
SELECT DISTINCT Country
  FROM Customer; 

/*
4B. Liste a quantidade de pedidos feitos por cada funcionário.
*/

SELECT O.EmployeeID, E.FirstName, COUNT(OrderID) AS OrderCount
FROM SalesOrder AS O
JOIN Employee AS E
	ON O.EmployeeID = E.EmployeeID
GROUP BY EmployeeID;

/*
4C. Liste o total de vendas (valor total) por cada cliente e ordene por nome de Companyname.
*/

SELECT C.CustId, C.Companyname,  SUM(UnitPrice * Quantity) AS TotalSales
FROM SalesOrder AS O
JOIN Customer AS C
	ON O.CustId = C.CustId
JOIN OrderDetail AS D
	ON O.OrderID = D.OrderID 
GROUP BY CustId;
