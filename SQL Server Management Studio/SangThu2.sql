/*CREATE TABLE Supplier(
	sid char(4) NOT NULL,
	sname varchar(30) NOT NULL,
	size smallint,
	city varchar(20),
	CONSTRAINT Khoachinhs primary key(sid)
);


CREATE TABLE Supplier2(
	sid nchar(4) NOT NULL,
	sname nvarchar(30) NOT NULL,
	size smallint,
	city nvarchar(20),
	CONSTRAINT KhoachinhS2 primary key(sid)
);

CREATE TABLE Product(
	pid char(4) NOT NULL,
	pname nvarchar(30) NOT NULL,
	colour nchar(8),
	weight int,
	city varchar(20),
	CONSTRAINT KhoachinhP primary key(pid)
);

CREATE TABLE SupplyProduct(
	sid char(4) NOT NULL,
	pid char(4) NOT NULL,
	quantity smallint,
	primary key(sid, pid),
	foreign key(sid) references Supplier(sid),
	foreign key(pid) references Product(pid),
	check(quantity > 0)
);

CREATE TABLE SupplyProduct2(
	sid char(4) NOT NULL foreign key(sid) references Supplier(sid),
	pid char(4) NOT NULL foreign key(pid) references Product(pid),
	quantity smallint,
	primary key(sid, pid),
	check(quantity > 0)
); */

ALTER TABLE Supplier
ALTER COLUMN sname varchar(28);

ALTER TABLE SupplyProduct
ADD price real;

ALTER TABLE SupplyProduct DROP COLUMN price;

------2021/11/1~~~~~~~~~~~~~~~

--[8:51 AM] Nguyen Hong Phuong
use SangThu2
CREATE TABLE [Company] (
[CompanyID] int IDENTITY(1,1),
[Name] varchar(40),
[NumberofEmployee] int,
[Address] varchar(50),
[Telephone] char(15),
[EstablishmentDay] date,
PRIMARY KEY ([CompanyID])
);
CREATE TABLE [Product] (
[ProductID] int IDENTITY(1,1),
[Name] varchar(40),
[Color] char(14),
[Price] decimal(10,2),
PRIMARY KEY ([ProductID])
);
CREATE TABLE [Supply] (
[CompanyID] int,
[ProductID] int,
[Quantity] int,
PRIMARY KEY([CompanyID],[ProductID]),
FOREIGN KEY ([CompanyID]) REFERENCES [Company]([CompanyID]),
FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
);
--===============================================================
--Company
INSERT INTO [Company]([Name],[NumberofEmployee],[Address],[Telephone],[EstablishmentDay])
VALUES('Kia','33255','Seoul, Korea','123067483','1941-12-01'),
('Vinfast','3000','LongBien, Hanoi','0912354321','2017-06-20'),
('Chevrolet','20000','Michigan, US','0985647321','1911-11-03'),
('Audi','53347','Ingolstadt, Germany','8456732102','1909-04-25'),
('Ford','213000','Michigan, US','0543291852','1903-03-16'),
('Ferrari','17000','Maranello, Italy','0974635218','1929-05-18'),
('Mazda','36626','Hiroshima, Japan','0234967541','1920-01-01'),
('Lexus','12000','Aichi, Japan','02345678432','1989-01-20'),
('Honda','131600','Tokyo, Japan','02345678321','1948-09-24'),
('BMW','102007','Munchen, Germany','8456987342','1916-03-07'),
('Land Rover','9000','Coventry, UK','064532181','1948-04-09'),
('Jaguar','3000','London, UK','098453621','2008-02-06'),
('Rolls Royce','4000','London, UK','0985647321','1906-05-14'),
('Porsche','8000','Baden-Wurttemberg, Germany','09875643245','1931-08-26'),
('Mercedes Benz','12000','Baden-Wurttemberg, Germany','09877453621','1926-06-28'),
('Peugeot','11230','Paris, France','067598432','1882-08-03'),
('Toyota','299210','Tokyo, Japan','098453621','1937-08-02')
--Product
INSERT INTO [Product]([Name],[Color],[Price])
VALUES('Standard MT 2019','brown','299'),
('Standard AT 2019','green','339'),
('Luxury 2019','yellow','393'),
('Deluxe 2019','yellow','355'),
('Fadil Standard','brown','395'),
('Fadil Plus','violet','429'),
('Lux A2.0 Standard','pink','990'),
('Lux A2.0 Premium','black','1228'),
('Lux SA2.0 Premium','black','1688'),
('Peugeot 3008 All ','red','1199'),
('Peugeot 5008 2019','white','1349'),
('Peugeot 208','red','850'),
('C200 Exclusive 2019','black','1709'),
('Mercedes C300 AMG','black','1897'),
('Mercedes E200 Sport 2019','white','2317'),
('Mercedes S450 L 2019','blue','4249'),
('Audi A3 1.4L Sportback','white','1520'),
('A4 2.0L','white','1670'),
('A6 1.8 TFSI','blue','2270'),
('Wigo 1.2G 2019','orange','405'),
('Vios 1.5E CVT','red','540'),
('Avanza 1.5G AT','grey','612'),
('Porsche 718 Boxster S','red','4540'),
('Porsche 718 Cayman S','green','4420'),
('Porsche 911 Carrera S Cabriolet','grey','7770'),
('Porsche 911 GT3 RS ','blue','11060'),
('hatchback Premium SE','red','604'),
('sedan Premium','red','564')
--Supply
INSERT INTO [Supply]([CompanyID],[ProductID],[Quantity])
VALUES('1','1','2029'),
('1','2','6116'),
('1','4','3661'),
('1','6','4940'),
('1','7','6000'),
('2','1','2815'),
('2','2','5218'),
('2','7','2482'),
('3','9','755'),
('3','11','5352'),
('3','18','537'),
('3','28','1727'),
('3','22','5504'),
('4','1','1716'),
('4','2','689'),
('5','3','4973'),
('5','4','4897'),
('6','5','6512'),
('7','6','1912'),
('7','7','5461'),
('7','8','2318'),
('7','9','3872'),
('7','10','3763'),
('7','11','1622'),
('8','12','4367'),
('8','13','2894'),
('8','14','4017'),
('8','15','2957'),
('9','16','5926'),
('9','17','2170'),
('9','18','5815'),
('9','19','4722'),
('9','20','5832'),
('10','21','1642'),
('11','22','5019'),
('12','23','6031'),
('13','24','2758'),
('13','25','5927'),
('13','26','771'),
('14','27','1494'),
('14','28','4499'),
('15','1','773'),
('15','3','4402'),
('15','5','3802'),
('15','8','4027'),
('15','12','2136'),
('15','13','2345'),
('15','17','5278')

---Các câu truy vấn:

--1/ Hãy cho biết tên, số nv của các cty ở Nhật Bản

select Company.Name, Company.NumberofEmployee from Company
where Address like '%Japan%'

--2/ Hãy cho biết ttin cty có số nv >100,000

select * from Company
where NumberofEmployee > 100000

--3/ TTin cty có số nv >100,000 và ở Đức

select * from Company
where NumberofEmployee > 100000 and Address like N'%Germany%'

--4/ Hãy cho biết ttin cty thành lập năm 1916

select * from Company
where year(EstablishmentDay) = 1916

 -- cách 2:
select * from Company
where DATEPART(year, EstablishmentDay) = 2008

-- thử
select DATEPART(day, EstablishmentDay) from Company


--5/ Cty >70 tuổi

select * from Company
where year(GETDATE()) - year(EstablishmentDay) >70

 -- cách 2
select * from Company
where datediff(year, EstablishmentDay,getdate()) > 70

-- thử

select datediff(year, getDate(), EstablishmentDay) from Company

--6/ Cho biết tên cty, sắp xếp theo abc

select Name from Company order by Name asc

--7/ Cho biết ttin cty, sắp xếp theo nv giảm dần

select * from Company order by NumberofEmployee desc

--8/ Có bao nhiêu cty trong csdl?

select count(CompanyID) from Company

--9/ Tổng số nv tất cả các cty

select SUM(NumberofEmployee) from Company

--10/ Số lượng nv trung bình của mỗi cty

select avg(NumberofEmployee) from Company

--11/ Số lượng nv nhiều nhất

select max(NumberofEmployee) as "Số lượng nhân viên nhiều nhất" from Company

--12/ Số lượng nv ít nhất

select min(NumberofEmployee) from Company

--13/ Cho biết ttin cty có số nv max

select * from Company
where NumberofEmployee = (select max(NumberofEmployee) from Company)

-- cách 2:
select * from Company
where NumberofEmployee >= ALL(Select NumberofEmployee from Company)

--14/ Phép đổi tên AS

SELECT CompanyID AS [Mã công ty], Name AS [Tên cty]
FROM Company AS c
WHERE c.Address LIKE '%US%';

--15/ Cho biết tên, điện thoại của cty ở Japan, có số nv lớn hơn 8000

select Name, Telephone from Company 
where Address like '%Japan%' and NumberofEmployee > 8000

--16/ Cho biết ttin cty ở Japan hoặc Germany

select * from Company
where Address like '%Japan%' or Address like '%Germany%'

--17/ Cho biết address có >=2 cty

select Address from Company
group by Address having count(CompanyID) >= 2

-- cách 2:

SELECT DISTINCT c1.Address
FROM Company c1, Company c2
where c1.Address = c2.Address AND c1.CompanyID != c2.CompanyID;

--ký hiệu khác, không bằng: <> , !=
-- cach 3

select distinct Address from Company c1
where Address in (
					select Address from Company c2
					where c1.CompanyID <> c2.CompanyID
					)

-- 18. Cho biết tt cty cung ứng 2 loại sản phẩm màu red trở lên

select * from Company
where CompanyID in
(
	select Supply.CompanyID from Supply  
	inner join Product on Product.ProductID = Supply.ProductID
	where Color = 'red' 
	group by Supply.CompanyID
	having count(Supply.CompanyID) >= 2 
)

select CompanyID from Supply
where ProductID in
(
	select ProductID from Product
	where color = 'brown'
)
group by CompanyID
having count(ProductID) = 
(
	select count(ProductID) from Product
	where color = 'brown'
)

-- full mặt hàng 
select CompanyID from Supply
group by CompanyID, ProductID
having ProductID in 
(
	select count(ProductID) from Product
	where color = 'brown'
)


----
select * from Product
inner join Supply on Product.ProductID = Supply.ProductID
where Color = 'black'    --=> CompanyID: 17

select * from Supply
where CompanyID = 17

select * from Product
where Color = 'black'   --=> productID: 8 9 13 14



---Cac mat hang cung cap thi deu la mau den => Ket qua: CompanyID = 17

select distinct CompanyID from Supply
where CompanyID not in
(select CompanyID from Supply
inner join Product on Product.ProductID = Supply.ProductID
where Color != 'black'
group by CompanyID)

-- 11/29 
CREATE VIEW vCompany1 AS
SElect Name, Address, Telephone from Company

CREATE VIEW vCompany2 AS
SELECT Name, Address, Telephone from Company
where Address like '%Japan%'

CREATE VIEW vComSupPro1(ComName, ProdName, Qty) AS
SELECT Company.Name, Product.Name, Quantity 
from Company inner join Supply on Company.CompanyID = Supply.CompanyID
inner join Product on Supply.ProductID = Product.ProductID

select * from vCompany2
select * from vComSupPro1
where ComName = 'Kia'

select * from vCompany1
where Address like '%Germany%'

select * from
(select Name, Address, Telephone from Company ) table1
where Address like '%Germany%'


ALTER VIEW vCompany2 as
select Name, Address, Telephone
from Company
where Address like '%Germany%'

select * from vCompany2

DROP VIEW vCompany1
DROP VIEW vCompany2
DROP VIEW vComSupPro1

-- 12/20 

USE SangThu2
Go
IF EXISTS(SELECT name FROM sysobjects
WHERE name='pCompany' AND type='P')
DROP PROCEDURE pCompany
GO
CREATE PROCEDURE pCompany
AS SELECT Name, NumberofEmployee
FROM Company
ORDER BY Name DESC
GO

exec pCompany
exec sp_helptext pCompany

CREATE PROC group_sp; 1
AS SELECT * FROM Company
GO
CREATE PROC group_sp;2
AS SELECT Name FROM Company
GO
CREATE PROC group_sp;3
AS SELECT DISTINCT Name, Address FROM Company
GO

EXEC group_sp;1

CREATE PROCEDURE scores
@score1 smallint,
@score2 smallint,
@score3 smallint,
@score4 smallint,
@score5 smallint,
@myAvg smallint OUTPUT
AS SELECT @myAvg = (@score1 + @score2 +
@score3 + @score4 + @score5) / 5

DECLARE @AvgScore smallint
EXEC scores 10, 9, 8, 2, 10, @AvgScore OUTPUT
SELECT 'The Average Score is: ',@AvgScore
Go

DECLARE @AvgScore smallint
EXEC scores
@score1=10, @score3=9, @score2=8, @score4=8,
@score5=10, @myAvg = @AvgScore OUTPUT
SELECT 'The Average Score is: ',@AvgScore
Go

CREATE PROC MyReturn
@t1 smallint, @t2 smallint, @retval smallint
AS SELECT @retval = @t1 + @t2
RETURN @retval

DECLARE @myReturnValue smallint
EXEC @myReturnValue = MyReturn 9, 9, 0
SELECT 'The return value is: ',@myReturnValue

IF EXISTS(SELECT name FROM sysobjects
WHERE name='pCompany' AND type='P')
DROP PROCEDURE pCompany
GO
CREATE PROCEDURE pCompany WITH ENCRYPTION
AS SELECT Name, NumberofEmployee
FROM Company
ORDER BY Name DESC
GO

EXEC sp_helptext pCompany;

Use SangThu2;
IF EXISTS(SELECT name FROM sysobjects
WHERE name='AddCompany' AND Type='TR')
DROP TRIGGER AddCompany
GO
CREATE TRIGGER AddCompany
ON Company
FOR INSERT
AS
PRINT 'The Company table has just been inserted data'
GO

INSERT INTO Company VALUES
('Toyota','299210','Tokyo, Japan','098453621','1937-08-02')

CREATE TABLE [DeletedCompany] (
[CompanyID] int,
[Name] varchar(40),
[NumberofEmployee] int,
[Address] varchar(50),
[Telephone] char(15),
[EstablishmentDay] date,
PRIMARY KEY ([CompanyID])
);

CREATE TRIGGER tg_DeleteCompany
ON Company
FOR DELETE
AS
INSERT INTO DeletedCompany SELECT * FROM deleted

select * from DeletedCompany

delete from Supply where CompanyID = 10
delete from Company where CompanyID = 10

CREATE TRIGGER tg_CheckPrice
ON Product
FOR UPDATE
AS
DECLARE @oldprice decimal(10,2), @newprice decimal(10,2)
SELECT @oldprice = Price FROM deleted
PRINT 'Old price ='
PRINT CONVERT(varchar(6), @oldprice)
SELECT @newprice = Price FROM inserted
PRINT 'New price ='
PRINT CONVERT(varchar(6), @newprice)
IF(@newprice > (@oldprice*1.10))
BEGIN
PRINT 'New price increased over 10%, not update'
ROLLBACK
END
ELSE
PRINT 'New price is accepted'

-- sửa lại
Update Product
set Price = 1230
where ProductID = 3

select * from Product
where color = 'black'
-- sửa lại