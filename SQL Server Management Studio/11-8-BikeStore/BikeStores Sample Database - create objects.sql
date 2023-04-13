/*
--------------------------------------------------------------------
© 2017 sqlservertutorial.net All Rights Reserved
--------------------------------------------------------------------
Name   : BikeStores
Link   : http://www.sqlservertutorial.net/load-sample-database/
Version: 1.0
--------------------------------------------------------------------
*/

create database BikeStores

-- create schemas
CREATE SCHEMA production;
go

CREATE SCHEMA sales;
go

use BikeStores 
-- create tables
CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);
 

-- truy xuất dữ liệu
--1. Cho biết khách hàng có mã '1' đã mua bao nhiêu đơn hàng?

select count(order_status)  from sales.orders
where customer_id = 1

select * from sales.orders
where customer_id = 1


--2. Cho biết khách hàng có mã '1' đã mua bao nhiêu đơn hàng ở cửa hàng '2'?

select count(order_status)  from sales.orders
where customer_id = 1 and store_id = 2


--3. Liệt kê thông tin nhân viên của cửa hàng '2'

select * from sales.staffs
where store_id = 2 and manager_id != 1

--4. Cho biết thông tin của quản lý cửa hàng '2'

select * from sales.staffs
where store_id = 2 and staff_id in
(
	select manager_id
	from sales.staffs
	--where store_id=2 
)

--5. Số lượng mặt hàng tên là 'Ritchey Timberwolf Frameset - 2016' bán được?

select sum(quantity) from sales.order_items
inner join production.products on sales.order_items.product_id = production.products.product_id
inner join sales.orders on sales.orders.order_id = sales.order_items.order_id
where product_name = 'Ritchey Timberwolf Frameset - 2016' and order_status = 4


--6. Brand tên là 'Trek' (hoặc 'Surly') có bao nhiêu sản phẩm?

select count(product_id) from production.products
where brand_id in
(
	select brand_id from production.brands
	where brand_name = 'Trek'
)

select count(product_id) from production.products
inner join production.brands on production.products.brand_id = production.brands.brand_id
where brand_name = 'Trek'

--7. Sản phẩm tên là 'Surly Straggler - 2016' còn lại số lượng bao nhiêu, trong kho nào?

select quantity, store_id  from production.products, production.stocks
where production.products.product_id = production.stocks.product_id
and product_name = 'Surly Straggler - 2016'

--8. Tìm cho khách mặt hàng 'Electra' có giá nhỏ hơn 270 mà còn hàng?

select distinct  production.products.*  from production.products, production.stocks
where production.products.product_id = production.stocks.product_id
and product_name like '%Electra%' and list_price < 270 and quantity > 0



select production.products.*
from production.products
where product_name like '%Electra%' and list_price < 270
and product_id in
(
	select product_id from production.stocks
	where quantity > 0
)

--9. Cho biết đơn hàng nào mà ngày ship trễ hơn ngày yêu cầu?

select * from sales.orders
where shipped_date > required_date

--10. Doanh số của nhân viên có mã là '2'

select sum(quantity*list_price*(1 - discount)) from sales.order_items
inner join sales.orders on sales.orders.order_id = sales.order_items.order_id
where staff_id = 2 and shipped_date is not null



