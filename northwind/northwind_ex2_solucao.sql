/*
5. Mostre uma lista de todos os diferentes valores de ContactTitle em Customers e suas respectivas quantidades. Exiba esses valores em ordem decrescente das quantidades.
*/

SELECT  ContactTitle
       ,COUNT(ContactTitle) AS TotalCountTitle
  FROM Customer
--  WHERE country != "UK"
  GROUP BY ContactTitle
--  HAVING TotalCountTitle <=5 
 ORDER BY TotalCountTitle DESC;

/*
6. Mostre para cada produto, o Fornecedor (Supplier) associado. Mostre o ProductID, ProductName e o CompanyName do fornecedor. Ordene por ProductID. 
*/

SELECT  P.ProductID
       ,P.ProductName
       ,S.CompanyName
  FROM Product AS P
  JOIN Supplier AS S
    ON S.SupplierID = P.SupplierID
 ORDER BY P.ProductID;

/*
7. Gostaríamos de mostrar uma lista dos Pedidos que foram feitos, incluindo o Expedidor (Shipper) que foi usado. Mostre o OrderID, OrderDate (somente data) e CompanyName do Expedidor e classifique por OrderID. Para não mostrar todos os pedidos (há mais de 800), mostre apenas as linhas com um OrderID menor que 10300.
*/

SELECT  O.OrderID
       ,o.OrderDate
	   ,S.CompanyName
  FROM salesorder AS O
  Join Shipper AS S
    ON S.ShipperID = O.ShipperID
 WHERE O.OrderID < 10300
 ORDER BY O.OrderID;

/*
7B. Liste os nomes dos produtos que possuem um preço maior do que a média dos preços dos produtos.
*/

SELECT ProductName
FROM Product
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Product);

/*
7C. Liste os clientes que nunca fizeram um pedido EMPREGANDO SUB SELECT no lugar de JOIN!
*/

SELECT CustID, CompanyName
FROM Customer
WHERE CustID NOT IN (SELECT DISTINCT CustID FROM salesorder);

/*
7D. Liste os produtos que foram vendidos mais de 100 unidades em qualquer pedido.
*/

SELECT ProductID, ProductName
FROM Product
WHERE ProductID IN (
    SELECT ProductID
    FROM OrderDetail
    WHERE Quantity > 100
);
