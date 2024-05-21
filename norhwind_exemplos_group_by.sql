select FirstName, (year(current_date)-year(BirthDate)) as age 
from employees;

select avg(year(current_date)-year(BirthDate)) as age 
from employees;

select City, avg(year(current_date)-year(BirthDate)) as age 
from employees
group by City;

select City           -- único caso sem função de agregação, equivale ao distinct
from employees
group by City;

select City, avg(year(current_date)-year(BirthDate)) as age 
from employees
where Country = 'USA'
group by City;

select City, avg(year(current_date)-year(BirthDate)) as age 
from employees
where Country = 'USA'
group by City
having age < 50;