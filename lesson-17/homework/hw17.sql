DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

--1. You must provide a report of all distributors and their sales by region.
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. 
--Assume there is at least one sale for each region
with d as(
select distinct Distributor from #RegionSales),
r as(
select  distinct Region from #RegionSales)
select
    d.Distributor,
	r.region, 
	coalesce(s.sales, 0) as Amount
from d
cross join r
left join #RegionSales s
on s.Distributor=d.Distributor
and s.region=r.Region
order by d.Distributor


CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
drop  TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

--2. Find managers with at least five direct reports
select * from Employee
select em.id, em.name
from employee e
join employee em on e.managerId=em.id 
group by em.id, em.name
having count(*)=5

CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);
select * from Orders
select * from Products
--3. Write a solution to get the names of
--products that have at least 100 units ordered in February 2020 and their amount.
select sum(o.unit) as unit, p.product_name
from Orders o
join Products p on p.product_id=o.product_id 
where month(o.order_date)=02 
group by p.product_name
having sum(o.unit)>=100
order by sum(o.unit) desc

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');
select * from Orders
--4. Write an SQL statement that returns the vendor from which 
--each customer has placed the most orders
select  CustomerID, Vendor, max(total)
from (
select CustomerID, vendor, sum([count]) as total from Orders
group by CustomerID, Vendor) as mn

--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

DECLARE @Check_Prime INT = 18;  -- bu yerga xohlagan sonni yozing
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

IF @Check_Prime <= 1
    SET @IsPrime = 0;
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';



--6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

select * from Device
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

select Device_id,  count(locations) over (partition by device_id) as countdh, countsl
from (select locations, device_id,  count(locations) over (partition by locations) as countsl from Device
) as mvgi



--7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
drop table Employee
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);
select * from Employee
select EmpID, EmpName, Salary, deptid, avarage_salary
from (select EmpID, EmpName, Salary, deptid,  avg(salary) over (partition by deptid) as avarage_salary
from Employee) AS  derived 
where Salary>avarage_salary




--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers.
--If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
CREATE TABLE Numbers (
    Number INT
);

INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);
CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);

WITH MatchCount AS (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT t.Number) AS TotalNumbers,
        COUNT(DISTINCT CASE WHEN t.Number IN (SELECT Number FROM Numbers) THEN t.Number END) AS MatchedNumbers
    FROM Tickets t
    GROUP BY t.TicketID
)
SELECT 
    SUM(
        CASE 
            WHEN MatchedNumbers = @WinningCount THEN 100
            WHEN MatchedNumbers > 0 THEN 10
            ELSE 0
        END
    ) AS TotalWinnings
FROM MatchCount;



