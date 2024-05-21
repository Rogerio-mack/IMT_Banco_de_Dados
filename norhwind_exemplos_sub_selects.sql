select * 
from products
where UnitPrice > (select avg(UnitPrice) from products);

select OrderID, Discount
from orderdetails
where ProductID in (select ProductID
					from products
					where UnitPrice > (select avg(UnitPrice) from products)
					);

