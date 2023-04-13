--11/15 index

CREATE TABLE production.parts
(
	part_id INT not null,
	part_name Varchar(100)
);

ALTER TABLE production.parts
ADD PRIMARY KEY(part_id);

insert into
	production.parts(part_id, part_name)
values
	(1, 'Frame'),
	(2, 'Head Tube'),
	(3, 'Handlebar Grip'),
	(4, 'Shock Absorber'),
	(5, 'Fork');

select part_id, part_name from production.parts
where part_id = 5

CREATE CLUSTERED INDEX ix_parts_id
ON production.parts(part_id)

DROP TABLE production.parts

CREATE TABLE production.part_prices(
	part_id int,
	valid_from date,
	price decimal(18, 4) not null,
	PRIMARY KEY (part_id, valid_from)
);

SELECT customer_id, city
FROM sales.customers
WHERE city = 'Atwater';

CREATE INDEX ix_customers_city    -- tao non-clustered index
ON sales.customers(city);

SELECT customer_id, first_name, last_name
FROM sales.customers
WHERE last_name = 'Berg' AND first_name = 'Monika';

CREATE INDEX ix_customers_name
ON sales.customers(last_name, first_name);

EXEC sp_rename
@objname = N'sales.customers.ix_customers_city',
@newname = N'ix_cust_city' ,
@objtype = N'INDEX';

SELECT email, COUNT(email)
FROM sales.customers
GROUP BY email
HAVING COUNT(email) > 1;

CREATE UNIQUE INDEX ix_cust_email
ON sales.customers(email);

ALTER INDEX ix_cust_city
On sales.customers
disable;

select first_name, last_name from sales.customers
where city = 'San Jose'

ALTER INDEX ALL
on sales.customers
disable;

select * from sales.customers;

--kich hoat index
ALTER INDEX ALL ON sales.customers
rebuild;

-- indexed view
create view product_master
with schemabinding
as
select product_id, product_name, model_year, list_price, brand_name, category_name 
from production.products p 
inner join production.brands b on b.brand_id = p.brand_id 
inner join production.categories c on c.category_id = p.category_id

set statistics io on
go
select * from product_master
order by product_name;
go

create unique clustered index ucidx_product_id
on product_master(product_id);

create nonclustered index ucidx_product_name
on product_master(product_name)

select * from product_master

Update production.products
set product_name = 'JK'
where product_id = 9



update product_master
set product_name = 'Lolita'
where product_id = 10

-- chưa chạy đc
--delete from product_master
--where product_id = 4 

CREATE VIEW product_master1 WITH SCHEMABINDING AS SELECT product_id, list_price, brand_name
FROM production.products p  
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id;

select * from product_master1

update product_master1
set brand_name = 'Dokira'
where product_id = 9


-- đổi tên cột 
sp_rename 'production.products.ex_model_year', 'model_year', 'COLUMN';
sp_rename 'production.products.category_id', 'ex_category_id','COLUMN';  -- ko đổi đc do có câu lệnh inner join trong tạo view product_master1


select * from production.products
drop view product_master1;
-- => Cột trong view thì ko đổi tên đc.
-- => Đôi dữ liệu table => dữ liệu view thay đổi. Ngược lại, đổi dữ liệu view => dữ liệu table thay đổi.

