
CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);

select * from Sales
select * from Employees
--Easy Tasks
--Create a numbers table using a recursive query from 1 to 1000.
with cte as(
select 1 number 
union all
select  number+1 from cte where number<1000)
select * from cte
--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select sums, EmployeeID
from (select sum(s.SalesAmount) as sums, e.EmployeeID from Employees e
       join  Sales s on e.EmployeeID=s.EmployeeID
	   group by e.EmployeeID) as etable  
	   
--Create a CTE to find the average salary of employees.(Employees)
with cte as(
    select  salary from Employees)
	select avg(salary) from cte
--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select sums, ProductID
from (select max(s.SalesAmount) as sums, s.ProductID from Employees e
       join  Sales s on e.EmployeeID=s.EmployeeID
	   group by s.ProductID) as etable 
--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
with cte as(
     select 1 number 
	 union all
	 select number*2 from cte where number<1000000)
	 select * from cte
--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
with cte_sales as(
select e.EmployeeID, count(*) as counts
from Employees e
join Sales s on s.EmployeeID=e.EmployeeID
group by e.EmployeeID
having count(*)>5)
select counts, employeeid from cte_sales


--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
with cte_sales as(
     select sum(s.salesamount) as suma, p.ProductName
	 from sales s
	 join products p on p.ProductID=s.ProductID
	 group by p.ProductName
	 having sum(s.SalesAmount)>500)
	 select suma, productname  from cte_sales
--Create a CTE to find employees with salaries above the average salary.(Employees)
with cte_salary as(
select  salary, FirstName, LastName  from Employees
where salary>(select avg(salary) from Employees))
select * from cte_salary
--Medium Tasks
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select first, salescount
from (select top 5 e.FirstName as first,  e.FirstName, count(*) as  salescount
from Employees e
join Sales s on s.EmployeeID=e.EmployeeID 
group by e.FirstName
order by count(*) desc) as salary
--Write a query using a derived table to find the sales per product category.(Sales, Products)
select sums, CategoryID
from (
select sum(s.SalesAmount) as sums, p.CategoryID
from sales s
join Products p on s.ProductID=p.ProductID
group by p.CategoryID) as salru
--Write a script to return the factorial of each value next to it.(Numbers1)
with cte_factorial as(
select number, 1 as n, 1 as fact
from Numbers1
union all
select number, n+1, fact*(n+1)
from cte_factorial
where n+1<=number)
select number, max(fact) as factorial
from cte_factorial
group by number 
order by number

--This script uses recursion to split a string into rows of substrings for 
--each character in the string.(Example)
with cte as (
select String,
1 as pos,
substring(string,1,1) as ch
from Example
union all
select c.string,
pos+1, 
substring(c.string, pos+1,1)
from cte c
where pos+1<=len(c.string))
select string, ch from cte
--Use a CTE to calculate the sales difference between the current month 
--and the previous month.(Sales)
with cte_difference(
select 
from sales s
self join 
--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
select sums, FirstName
from (
select sum(s.salesamount)  as sums, e.FirstName, DATEPART(quarter, s.SaleDate) as quarter 
from sales s
join employees e on e.EmployeeID=s.EmployeeID
group by e.FirstName, DATEPART(quarter, s.SaleDate)
having sum(s.salesamount)>45000) as klgnit
--Difficult Tasks
--This script uses recursion to calculate Fibonacci numbers

with cte (n,f1,f2) as (
select  1, 1, 2
union all
select  n+1,f2, f1+f2 
from cte)
select * from cte

--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
select Vals
from FindSameCharacters
where len(vals)>1
  and Vals=REPLICATE(left(Vals, 1), len(Vals));
--Create a numbers table that shows all numbers 1 through n and their order gradually
--increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
with cte as(
     select 1 as n
	 union all
	 select n+1 from cte where n<9)
	 select substring ('123456789', 1, n) as vap
	 from cte
--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
select susm, FirstName
from(
select sum(s.SalesAmount) as susm, e.FirstName
from Employees e
join Sales s on e.EmployeeID=s.EmployeeID
where month(s.saledate)<6
group by e.FirstName
) as nhfut
order by susm desc
--Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
select
     REPLACE(
	     replace(
		 replace(
		  replace(
		   replace(
		    replace(
			 replace(
			  replace(
			   replace(
			   replace(pawan_slug_name,'0',''), '1', ''), '2', '') , '3', '') , '4', ''), '5', ''), '6', ''), '7', '') , '8', '') , '9', '')   
				as cleaned
			from RemoveDuplicateIntsFromNames


