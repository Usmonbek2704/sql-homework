CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);
select * from employees
select * from Employees e
where salary=(select min(salary) from employees)



--Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

select * from products
where price>(select avg(price) from products)


--3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);


CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);

select e.id, e.name, e.department_id
from employees e
where exists(
           select 1
		   from Departments d
		   where d.id=e.department_id 
		   and d.department_name='sales')


--Task: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');
INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);
select *
from customers c
where exists(
           select 1
		   from orders o
		   where c.customer_id!=o.customer_id)

--Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);	

select * from products
select * from products p
where p.price in (select  max(price) from products
             group by category_id)

--Task: Retrieve employees working in the department with the highest average salary.
--Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
drop table departments
drop table employees
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);

select e.department_id, e.name, e.salary, d.department_name
from employees e
join departments d on d.id=e.department_id
where e.department_id=(select top 1 department_id from employees
                           group by department_id
						   order by avg(salary) desc)


--Task: Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);
select e.name, e.salary, d.department_name
from employees e
join departments d on d.id = e.department_id
where e.salary > (
    select avg(e2.salary)
    from employees e2
    where e2.department_id = e.department_id
);


--Task: Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

select s.name, s.student_id, g.course_id 
from students s
join grades g on g.student_id=s.student_id
where  not exists (
                    select 1
					from grades x
					where   x.course_id=g.course_id
					and g.grade<x.grade)


	--9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

SELECT
    category_id,
    product_name,
    price
FROM (
    SELECT
        category_id,
        product_name,
        price,
        DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rank_number
    FROM products
) AS ranked_products
WHERE rank_number = 3;

--Task: Retrieve employees with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);


select e.name, e.salary, e.department_id
from employees e
where e.salary>(select avg(salary) from employees)
and
e.salary<(select max(e2.salary)
from employees e2
where e2.department_id=e.department_id);
