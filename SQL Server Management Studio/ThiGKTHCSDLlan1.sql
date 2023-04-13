--1.	Dùng lệnh tạo bảng để tạo 3 bảng trên với đầy đủ ràng buộc khóa chính, khóa ngoài.

CREATE DATABASE [CompanySupplyProduct];

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

--Viết các câu truy vấn dữ liệu SQL để:
--2.	Cho biết thông tin của công ty có địa chỉ ở 'London'

select * from Company
where Address like '%London%'

--3.	Cho biết thông tin công ty thành lập trong tháng 11 cách đây 110 năm

select * from Company
where year(getDate()) - year(EstablishmentDay) = 110 and month(EstablishmentDay) = 11

--4.	Cho biết thông tin các sản phẩm và số lượng cung ứng sản phẩm của công ty 'Audi'

select distinct P.*, Quantity
from Company C, Product P, Supply S
where C.Name = 'Audi' and C.CompanyID = S.CompanyID and S.ProductID = P.ProductID

--5.	Cho biết mã công ty cung ứng ít nhất 2 loại sản phẩm mà số lượng cung ứng mỗi loại >1000

Select CompanyID from Supply
where Quantity > 1000
group by CompanyID
having count(ProductID) >= 2


--6.	Cho biết thông tin công ty cung ứng tất cả các sản phẩm màu 'black' có trong bảng Product

select * from Company
where CompanyID in
(
	select CompanyID from Supply
	where ProductID in
	(
		select ProductID from Product
		where color = 'black'
	)
	group by CompanyID
	having count(ProductID) = 
	(
		select count(ProductID) from Product
		where color = 'black'
	)
)
 

--7.	Cho biết tổng số sản phẩm các loại được cung ứng bởi công ty 'Porsche'

select sum(Quantity) "Tong so san pham" from Supply
inner join Company on Company.CompanyID = Supply.CompanyID
where name = 'Porsche'

--8.	Cho biết thông tin công ty chưa cung ứng bất kỳ sản phẩm nào

select * from Company
where CompanyID not in (select CompanyID from Supply)

--9.	Viết câu SQL tạo khung nhìn vật chất hóa chứa thông tin công ty có cung ứng sản phẩm màu 'red' gồm các trường: mã công ty, tên công ty, điện thoại, mã sản phẩm, tên sản phẩm, số lượng cung ứng.

create view cau9 (MaCongTy, TenCongTy, DienThoai, MaSanPham, TenSanPham, Quantity) AS
SELECT Company.CompanyID, Company.Name, Telephone, Product.ProductID, Product.Name, Quantity 
from Company inner join Supply on Company.CompanyID = Supply.CompanyID
inner join Product on Supply.ProductID = Product.ProductID
where Color = 'red'

select * from cau9

--10.	 Xóa thông tin công ty có mã '2' 

delete from Supply 
where CompanyID = 2

delete from Company
where CompanyID = 2
