 CREATE DATABASE BAI_TAP_SO_2


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

--1) Tên các công ty có trụ sở tại London 
SELECT * FROM Company
WHERE Address LIKE '%London%'
--2) Tìm tên, màu sắc và giá của sản phẩm biết rằng nó màu đen và giá trị trên 5000
SELECT Name, Color, Price
FROM Product
WHERE Color LIKE 'Black' AND Price > 5000

--3) Tìm tên và số điện thoại các công ty cung cấp sản phẩm màu đỏ 
SELECT Company.Name, Telephone
FROM Company, Supply, Product
WHERE Company.CompanyID = Supply.CompanyID
AND Supply.ProductID = Product.ProductID
AND Color = 'red'

SELECT Company.Name, Telephone
FROM Company 
JOIN Supply ON Company.CompanyID = Supply.CompanyID
JOIN Product ON Supply.ProductID = Product.ProductID
WHERE Color = 'red'


--5) In tên của mặt hàng đắt nhất 

SELECT Name
FROM Product
WHERE Price = (SELECT MAX(Price) FROM Product ) 

SELECT Name FROM Product 
WHERE Price >= ALL(SELECT Price FROM Product)

--6) tìm tên công ty cung cấp 2 sản phẩm 
SELECT c.Name 
FROM Company c JOIN (SELECT CompanyID, COUNT(CompanyID) AS Num 
FROM Supply GROUP BY CompanyID) a
ON c.CompanyID = a.CompanyID
WHERE a.Num >=2

--7) Tìm tên công ty cung cấp tất cả các sản phẩm màu xanh 
SELECT Name FROM Company 
WHERE CompanyID IN(
					SELECT CompanyID
					FROM Supply JOIN Product
					ON Supply.ProductID = Product.ProductID
					WHERE Color = 'yellow'
					GROUP BY CompanyID
					HAVING COUNT(Supply.ProductID) = (
													SELECT COUNT(ProductID)
													FROM Product
													WHERE Color = 'yellow'))

SELECT * FROM Company
WHERE CompanyID IN
(
	SELECT CompanyID FROM Supply
	WHERE ProductID IN
	(
		SELECT ProductID FROM Product
		WHERE color = 'yellow'
	)
	GROUP BY CompanyID
	HAVING COUNT(ProductID) = 
	(
		SELECT COUNT(ProductID) FROM Product
		WHERE color = 'yellow'
	)
)
 
--8) Tìm tên của Cty cung cấp nhiều sản phẩm nhất
SELECT Name 
FROM Company 
WHERE Company.CompanyID IN(
							SELECT CompanyID 
							FROM Supply
							GROUP BY CompanyID 
							HAVING COUNT(CompanyID) >= ALL(
															SELECT COUNT(CompanyID)
															FROM Supply
															GROUP BY CompanyID
															)
					 	   )
-- 10) tạo bảng mới 
SELECT * INTO NEW
FROM Product
--11) sửa địa chỉ 
Update Company
SET Address = 'Hanoi, Viet Nam'
Where CompanyID = 1 

--12) Xoá công ty có mã là 12 
DELETE FROM Supply
WHERE CompanyID = 14
DELETE FROM Company
WHERE CompanyID = 14

-- cho biết thông tin mã, tên của công cy, cho biết mã trung bình giảm dần



