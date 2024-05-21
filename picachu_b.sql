/* 
Problemas Básicos
*/

/* 
1. Na tabela OrderDetails, temos os campos UnitPrice e Quantity. Crie um novo campo, TotalPrice e retorne também OrderID, ProductID, UnitPrice e Quantity. Ordene por OrderID e ProductID.
*/ 

SELECT  OrderId
       ,ProductID
	   ,UnitPrice
	   ,Quantity
	   ,(UnitPrice * Quantity) AS TotalPrice
  FROM OrderDetails;

/*
2. Quantos clientes temos na tabela Clientes?
*/

SELECT COUNT(CustomerID) AS TotalCustomers
  FROM Customers;

/*
3. Mostre a data do primeiro pedido já feito na tabela Pedidos.
*/

SELECT OrderDate
  FROM Orders
 ORDER BY OrderDate ASC limit 1;

/*
4. Mostre uma lista de países onde a empresa Northwind tem clientes.
*/

SELECT Country
  FROM Customers
 GROUP BY Country;

/*
4B. Liste a quantidade de pedidos feitos por cada funcionário.
*/

SELECT O.EmployeeID, E.FirstName, COUNT(OrderID) AS OrderCount
FROM Orders AS O
JOIN Employees AS E
	ON O.EmployeeID = E.EmployeeID
GROUP BY EmployeeID;

/*
4C. Liste o total de vendas (valor total) por cada cliente e ordene por nome de Companyname.
*/

SELECT C.CustomerID, C.Companyname,  SUM(UnitPrice * Quantity) AS TotalSales
FROM Orders AS O
JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
JOIN OrderDetails AS D
	ON O.OrderID = D.OrderID 
GROUP BY CustomerID
