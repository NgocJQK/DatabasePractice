create database CSDL_Project;

use CSDL_Project;

CREATE SCHEMA production;
go

CREATE SCHEMA sales;
go

CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name NVARCHAR (255) NOT NULL
);

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name NVARCHAR (255) NOT NULL,
	country VARCHAR(255) NOT NULL
);

CREATE TABLE production.products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name NVARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table sales.customers (
	customer_id int identity(1,1),
	name nvarchar(255) not null,
	birthday date,
	address nvarchar(255),
	phone varchar(25) constraint UQ0 unique,
	email varchar(255) constraint UQ1 unique,
	constraint PK0 primary key (customer_id),
);
go

create view vRealCustomer as
select * from sales.customers where customer_id != 1

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	name NVARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	address NVARCHAR (255),
	state VARCHAR (10)
);

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	name NVARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25) not null unique,
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_state INT Not null,
	gender nvarchar (10) not null,
	password varchar (20) not null,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT not null,
	staff_id INT NOT NULL,
	created_date DATE NOT NULL,
	price decimal(10,2) not null default 0,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.stocks (
	product_id INT not null,
	created_at date not null,
	good_till date not null,
	store_id INT not null,
	price DECIMAL (10, 2) NOT NULL default 0,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	quantity INT not null default 0,
	PRIMARY KEY (product_id, created_at, good_till, store_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.order_items (
	order_id INT not null,
	product_id INT not null,
	created_at date not null,
	good_till date not null,
	store_id INT NOT NULL,
	quantity INT NOT NULL default 0,
	price DECIMAL (10, 2) NOT NULL default 0,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (product_id, created_at, good_till, store_id) references sales.stocks (product_id, created_at, good_till, store_id),
	foreign key (product_id) references production.products (product_id)
);

drop table sales.order_items;
drop table sales.stocks;
drop table sales.orders;
drop table sales.staffs;
drop table production.products;
drop table production.categories;
drop table production.brands;
drop table sales.customers;
drop table sales.stores;