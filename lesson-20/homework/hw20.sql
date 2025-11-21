create database hw20
use hw20
CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

--1. Find customers who purchased at least one item in March 2024 using EXISTS
select * from #Sales s1
where exists(
      select SaleDate
	  from #Sales s2
	  where s2.SaleDate=s1.SaleDate and month(s2.saledate)=03)


--2. Find the product with the highest total sales revenue using a subquery.
select * from #Sales
where Quantity*Price=(select top 1 Quantity*Price from #Sales
                       order by Quantity*Price desc)
					   
--3. Find the second highest sale amount using a subquery
select * from  (select top 3 * from #Sales
order by Quantity*Price desc) as t
order by t.Quantity*Price
offset 1 rows
fetch next 1 rows only	
select * from #Sales
--4. Find the total quantity of products sold per month using a subquery
select * from (select sum(quantity) as sumquantity from #Sales
group by month(saledate) ) as t

--5. Find customers who bought same products as another customer using EXISTS


select * from #Sales s1
where exists(
      select s2.Product  from #Sales s2
	  where s2.Product=s1.Product and s1.SaleID!=s2.SaleID
	  group by s2.Product)

--6. Return how many fruits does each person have in individual fruit level
create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')
select * from Fruits
with ctwe as (
           select name, 
		   sum(case when fruit='apple' then 1 else  0 end) as apple,
		   sum(case when fruit='orange' then 1 else  0 end) as orange,
		   sum(case when fruit='banana' then 1 else  0 end) as banana
from Fruits
group by name)
select * from ctwe
     

--7. Return older people in the family with younger ones
create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)
with familycte as(
     select ParentId, ChildID
	 from Family c
	 union all
	 select f.ParentId, c.childid
	 from familycte f
	 join family c on f.childid=c.parentid)
select parentid as pid, childid as chid
from familycte
order by parentid, childid 

CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

select * from #Orders

--8. Write an SQL statement given the following requirements.
--For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas
select *
from #Orders o
where o.DeliveryState='tx'
and o.CustomerID in(
    select CustomerID
	from #Orders
	where DeliveryState='ca');


--9. Insert the names of residents if they are missing
 create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')

UPDATE #residents
SET fullname = 
    CASE 
        WHEN CHARINDEX('name=', address) > 0 
             THEN SUBSTRING(
                    address,
                    CHARINDEX('name=', address) + 5,                  
                    CHARINDEX(' age=', address) - (CHARINDEX('name=', address) + 5)  
                  )
        ELSE fullname
    END
WHERE CHARINDEX('name=', address) > 0;



--10. Write a query to return the route to reach from Tashkent to Khorezm.
--The result should include the cheapest and the most expensive routes
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

WITH RoutePaths AS (
    SELECT 
        RouteID,
        DepartureCity,
        ArrivalCity,
        Cost,
        CAST(DepartureCity + ' -> ' + ArrivalCity AS VARCHAR(MAX)) AS RoutePath
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    SELECT 
        r.RouteID,
        p.DepartureCity,
        r.ArrivalCity,
        p.Cost + r.Cost AS Cost,
        CAST(p.RoutePath + ' -> ' + r.ArrivalCity AS VARCHAR(MAX))
    FROM #Routes r
    JOIN RoutePaths p 
        ON r.DepartureCity = p.ArrivalCity
    WHERE p.ArrivalCity <> 'Khorezm'
),
FinalRoutes AS (
    SELECT RoutePath, Cost
    FROM RoutePaths
    WHERE ArrivalCity = 'Khorezm'
)
SELECT *
FROM FinalRoutes
WHERE Cost = (SELECT MIN(Cost) FROM FinalRoutes)
   OR Cost = (SELECT MAX(Cost) FROM FinalRoutes);



--11. Rank products based on their order of insertion.
CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
) 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')

select * from (
select *, 
rank() over (order by id) as raank
from #RankingPuzzle)
as ranked
where Vals='product';

--Find employees whose sales were higher than the average sales in their department
CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);
select * from (
select *, avg(salesamount) over (partition by department) as avgsalesamount
from #EmployeeSales) as buc
where SalesAmount>avgsalesamount

--13. Find employees who had the highest sales in any given month using EXISTS
select *, max(totalsales) over (partition by salesmonth) as vtyirh from (
select *, 
sum(salesamount) over (partition by salesmonth, employeename) as totalsales
from #EmployeeSales) as employee

--14. Find employees who made sales in every month using NOT EXISTS
CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

select * from Products p1
where not exists(
      select sum(price) as jyygyf 	  from Products p2
	  where p2.ProductID=p1.ProductID )
--15. Retrieve the names of products 
--that are more expensive than the average price of all products.
select * from Products
where price>(
select AVG(price) from Products)

--16. Find the products that have a stock count lower than the highest stock count.
select * from Products
where  Stock<(
select max(stock) from Products)

--17. Get the names of products that belong to the same category as 'Laptop
select * from Products
where Category=(
      select  Category
	  from Products
	  where name='laptop')

--18. Retrieve products whose price is greater than the lowest price in the Electronics category.
select * from Products
where price>(
select min(price) from Products
where Category='electronics')
and Category!='electronics';
select * from Products
select * from Orders
--19. Find the products that have a higher price than the average price of their respective category.
CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');

select *
from (
select p.ProductID, 
p.Name, 
p.Price, 
p.Stock,
AVG(p.Price) over (partition by p.category) as avgprice
from Products p
join orders o on p.ProductID=o.ProductID ) as jgug
where Price>avgprice

--20. Find the products that have been ordered at least once.
select p.Name,
p.Price,
p.Category,
p.Stock,
o.Quantity
from Products p
join Orders o on o.ProductID=p.ProductID
where o.Quantity>1

--21. Retrieve the names of products that have been ordered more than the average quantity ordered.
select
p.Name,
p.Price,
p.Category,
p.Stock,
o.Quantity
from Products p
join Orders o on o.ProductID=p.ProductID
where o.Quantity>
(select AVG(quantity) as fnun from Orders)

--22. Find the products that have never been ordered.
select p.Name,
p.Price,
p.Category,
p.Stock,
o.Quantity 
from Products p
join Orders o on o.ProductID=p.ProductID
where o.Quantity<1


--23. Retrieve the product with the highest total quantity ordered.
select
p.Name,
p.Price,
p.Category,
p.Stock,
o.quantity
from Products p
join Orders o on o.ProductID=p.ProductID
where o.Quantity=(
select max(quantity)
from orders)




