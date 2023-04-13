--1

CREATE DATABASE [Company];CREATE TABLE [Company] (
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
);CREATE TABLE [Supply] (
[CompanyID] int,
[ProductID] int,
[Quantity] int,
PRIMARY KEY([CompanyID],[ProductID]),
FOREIGN KEY ([CompanyID]) REFERENCES [Company]([CompanyID]),
FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
);

--2 
Select Name, Address from Company
where Address like 'London'

--3
select * from Company
where 
