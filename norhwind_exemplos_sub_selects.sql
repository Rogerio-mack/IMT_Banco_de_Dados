select * 
from products
where UnitPrice > (select avg(UnitPrice) from products);

select OrderID, Discount
from orderdetails
where ProductID in (select ProductID
					from products
					where UnitPrice > (select avg(UnitPrice) from products)
					);

-- o mesmo SQL acima em formato de JOIN

select o.OrderID, o.Discount, p.UnitPrice
from orderdetails o
join products p on o.ProductID =  p.ProductID
where p.UnitPrice > (select avg(UnitPrice) from products);

