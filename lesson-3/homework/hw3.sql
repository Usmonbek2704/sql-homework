--bulk insertning vazifasi ma`lumotlarni import qilish uchun ishlatiladi.

--fayl formatlari: xls, xlsx, xlsm,xlsb

create table products (productid int primary key, productname varchar(50), price decimal(10,2))
insert into products(productid,productname, price) values (1,'kiyim', 20000), (2, 'kursi', 50000), (3, 'futbolka', 40000)
select * from products
--Agar table yaratayotgan paytda null deb berib ketsak jadval null qiymatni qabul qiladi. Agar not null deb berib ketsak null qiymat qabul qilmaydi.


alter table products 
add constraint uq_productname unique(productname) 

--identity column berilsa biz qiymat bermasak ham  ozi avtomotik ravishda qiymat berib ketadi. shuning uchun identity column buyrug`i beriladi.

bulk insert  products
from 'C:\Temp\products.csv'
with (
     firstrow =2,
	 fieldterminator =',',
	 rowterminator ='\n'
	 );
select * from products


CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);

ALTER TABLE products
ADD CONSTRAINT FK_products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

ALTER TABLE products
ADD CategoryID INT;

--PRIMARY KEY va UNIQUE KEY ikkalasi ham ustundagi qiymatlarning takrorlanmasligini ta’minlaydi.
--primary key null qabul qilmaydi, ozi clustered index yaratadi va jadvalda faqat bitta bolasdi.
--unique key null qabul qiladi, jadvalda bir nechta bolishi mumkin va clustered index yaratmaydi.

ALTER TABLE products
ADD CONSTRAINT CK_products_price CHECK (price > 0);

ALTER TABLE products
ADD stock int NOT NULL;

UPDATE Products
SET Price = ISNULL(Price, 0);

--foreign key-bu referential integrity (ma’lumotlarning bog‘lanish yaxlitligi) ni ta’minlash uchun ishlatiladigan constraint.
--asosiy vazifalari-jadvallarni bog'lash, notogri qiymat kiritilishini oldini olish, o'chirish va yangilashdagi bog'liqlikni boshqarish.

create table customers (id int identity(100, 10), name varchar(50), surname varchar(50), age int check(age>=18))

select * from customers
insert into customers ( name, surname, age)
values ('odilbek', 'kenjayev', 19)

create table orderdetails(orderid int not null, ordername varchar(50), price int not null,   CONSTRAINT PK_Orders PRIMARY KEY (orderid, ordername));

--isnull funksiyasi agar expression null bolsa, replacement_valueni qaytaradi, expression null bolmasa ozini qaytaradi. agar price null bolsa 0 qaytaradi.
--coalesce funksiyasi  birinchi null bolmagamimi qaytaradi keyin null bolsa nullni qaytaradi. isnulldan farqi coalesce kop ustunda ishlay oladi.


create table employees (empid int primary key, name varchar (50), phonenumber int, email nvarchar(50) unique)


CREATE TABLE Departments
(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL
);


CREATE TABLE Employeees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    DeptID INT
);

ALTER TABLE Employeees
ADD CONSTRAINT FK_Employeees_Departments
    FOREIGN KEY (DeptID)
    REFERENCES Departments(DeptID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

