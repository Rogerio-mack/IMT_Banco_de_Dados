USE Northwind;

select FirstName, (year(current_date)-year(BirthDate)) as age 
from employee;

select avg(year(current_date)-year(BirthDate)) as age 
from employee;

select City, avg(year(current_date)-year(BirthDate)) as age 
from employee
group by City;

select City           -- único caso sem função de agregação, equivale ao distinct
from employee
group by City;

select City, avg(year(current_date)-year(BirthDate)) as age 
from employee
where Country = 'USA'
group by City;

select City, avg(year(current_date)-year(BirthDate)) as age 
from employee
where Country = 'USA'
group by City
having age < 50;