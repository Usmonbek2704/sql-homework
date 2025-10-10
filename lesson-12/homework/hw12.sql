Create table Person (personId int, firstName varchar(255), lastName varchar(255))
Create table Address (addressId int, personId int, city varchar(255), state varchar(255))
Truncate table Person
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')
Truncate table Address
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')
select * from Address
select * from person

select p.firstName, p.lastName, a.city, a.state
from Person p
left  join  Address a on  p.personId=a.personId

Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

select e1.name, e2.name
from Employee  e1
inner join Employee e2 on e2.id=e1.managerId and e2.salary<e1.salary

truncate table Person

create table Person1 (id int, email varchar(255))
insert into Person1(id, email) values ('1', 'a@b.com'), ('2', 'c@d.com'), ('3', 'a@b.com')

select email from Person1
group by email
having count(email)>1

delete from Person1
where id



create table Person2 (id int, email varchar(255))
insert into Person2 (id, email) values ('1', 'john@example.com'),
('2', 'bob@example.com'),
('3', 'john@example.com')

delete p2
from Person2 p1
join Person2 p2
on p1.email=p2.email  and p1.id>p2.id
select * from Person2


CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

select distinct g.ParentName
from girls g
where g.ParentName not in (select distinct ParentName from boys)

select 
from 










DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO
select * from Cart1
select * from Cart2

select c1.Item, c2.Item
from Cart1 c1
full outer join Cart2 c2 on c1.Item=c2.Item

drop table Customers
drop table Orders
Create table Customers1 (id int, name varchar(255))
Create table Orders1 (id int, customerId int)
Truncate table Customers 
insert into Customers1(id, name) values ('1', 'Joe')
insert into Customers1 (id, name) values ('2', 'Henry')
insert into Customers1 (id, name) values ('3', 'Sam')
insert into Customers1 (id, name) values ('4', 'Max')
Truncate table Orders1
insert into Orders1 (id, customerId) values ('1', '3')
insert into Orders1 (id, customerId) values ('2', '1')
select * from Orders1

select c.name
from Customers1 c
inner join Orders1 o on o.customerId<>c.id


drop table Students
Create table Students1 (student_id int, student_name varchar(20))
Create table Subjects (subject_name varchar(20))
Create table Examinations (student_id int, subject_name varchar(20))
Truncate table Students
insert into Students1 (student_id, student_name) values ('1', 'Alice')
insert into Students1 (student_id, student_name) values ('2', 'Bob')
insert into Students1 (student_id, student_name) values ('13', 'John')
insert into Students1 (student_id, student_name) values ('6', 'Alex')
Truncate table Subjects
insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')
Truncate table Examinations
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
select * from Students1
select * from Subjects
select * from Examinations
select s.student_id, s.student_name,s1.subject_name, count(s1.subject_name)
from Students1 s
cross join Subjects s1
left join examinations e 
on s.student_id=e.student_id
and s1.subject_name= e.subject_name
group by s.student_id, s.student_name, s1.subject_name
order by s.student_id, s1.subject_name
