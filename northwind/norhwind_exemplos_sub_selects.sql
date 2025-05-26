select * 
from product
where UnitPrice > (select avg(UnitPrice) from product);

select OrderID, Discount
from orderdetail
where ProductID in (select ProductID
					from product
					where UnitPrice > (select avg(UnitPrice) from product)
					);

-- o mesmo SQL acima em formato de JOIN

select o.OrderID, o.Discount, p.UnitPrice
from orderdetail o
join product p on o.ProductID =  p.ProductID
where p.UnitPrice > (select avg(UnitPrice) from product);

