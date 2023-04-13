-- 01/10 : Function
use BikeStores
CREATE FUNCTION fNhanvien
(@nhanvien_id INT)
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @nhanvien_name VARCHAR(50);
IF @nhanvien_id < 10
SET @nhanvien_name = 'Smith';
ELSE
SET @nhanvien_name = 'Lawrence';
RETURN @nhanvien_name;
END;



SELECT dbo.fNhanvien(8);

CREATE FUNCTION sales.fNetSale
(
@quantity INT,
@list_price DEC(10,2),
@discount DEC(4,2)
)
RETURNS DEC(10,2)
AS
BEGIN
RETURN @quantity * @list_price * (1 - @discount);
END;



SELECT sales.fNetSale(10,100,0.1) net_sale;

SELECT order_id,
SUM(sales.fNetSale(quantity, list_price, discount)) net_amount
FROM sales.order_items
GROUP BY order_id
ORDER BY net_amount DESC;

SELECT order_id,
SUM(quantity * list_price *(1- discount)) net_amount
FROM sales.order_items
GROUP BY order_id
ORDER BY net_amount DESC;


DROP FUNCTION sales.fNetSale;DROP FUNCTION dbo.fNhanVien;

-- chạy 3 cụm này đồng thời
DECLARE @product_table TABLE (
product_name VARCHAR(MAX) NOT NULL,
brand_id INT NOT NULL,
list_price DEC(11,2) NOT NULL
);

INSERT INTO @product_table
SELECT product_name, brand_id, list_price
FROM production.products
WHERE category_id = 1;

SELECT * FROM @product_table;
--
DECLARE @product_table TABLE (
product_name VARCHAR(MAX) NOT NULL,
brand_id INT NOT NULL,
list_price DEC(11,2) NOT NULL
);

INSERT INTO @product_table
SELECT product_name, brand_id, list_price
FROM production.products
WHERE category_id = 1;

SELECT
brand_name,
product_name,
list_price
FROM
production.brands b
INNER JOIN @product_table pt
ON b.brand_id = pt.brand_id;

---

CREATE FUNCTION udfSplit
(
	@string VARCHAR(MAX),
	@delimiter VARCHAR(50) = ' ')
	RETURNS @parts TABLE
(
	idx INT IDENTITY PRIMARY KEY,
	val VARCHAR(MAX)
)
AS
BEGIN
DECLARE @index INT = -1;
WHILE (LEN(@string) > 0)
BEGIN
SET @index = CHARINDEX(@delimiter , @string);
IF (@index = 0) AND (LEN(@string) > 0)
BEGIN
INSERT INTO @parts
VALUES (@string);
BREAK
END
IF (@index > 1)
BEGIN
INSERT INTO @parts
VALUES (LEFT(@string, @index - 1));
SET @string = RIGHT(@string, (LEN(@string) - @index));
END
ELSE
SET @string = RIGHT(@string, (LEN(@string) - @index));
END
RETURN
END

select * from udfSplit('kaze bar kawasemi hana', ' ');

--
CREATE FUNCTION udfProductInYear
(
	@model_year INT
)
RETURNS TABLE
AS
RETURN
SELECT
product_name,
model_year,
list_price
FROM
production.products
WHERE
model_year = @model_year;


SELECT *
FROM udfProductInYear(2017);

SELECT product_name, list_price
FROM udfProductInYear(2018);

--

ALTER FUNCTION udfProductInYear (
@start_year INT,
@end_year INT
)
RETURNS TABLE
AS
RETURN
SELECT
product_name, model_year, list_price FROM production.products
WHERE
model_year BETWEEN @start_year AND @end_year

SELECT product_name, model_year, list_price FROM udfProductInYear(2017,2018)
ORDER BY product_name;

-- chưa chạy đc
use BikeStores

CREATE FUNCTION udfContacts()
RETURNS @contacts TABLE (
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(255),
phone VARCHAR(25),
contact_type VARCHAR(20)
)
AS
BEGIN
INSERT INTO @contacts
SELECT first_name, last_name,
email, phone, 'Staff'
FROM sales.staffs


INSERT INTO @contacts
SELECT
first_name,
last_name,
email,
phone,
'Customer'
FROM sales.customers;
RETURN;
END;

SELECT * FROM udfContacts();

-- chưa chạy đc

CREATE FUNCTION sales.udf_get_discount_amount
(
@quantity INT,
@list_price DEC(10,2),
@discount DEC(4,2)
)
RETURNS DEC(10,2)
AS
BEGIN
RETURN @quantity * @list_price * @discount
END

DROP FUNCTION sales.udf_get_discount_amount;
--
CREATE FUNCTION sales.udf_get_discount_amount
(
@quantity INT,
@list_price DEC(10,2),
@discount DEC(4,2)
)
RETURNS DEC(10,2)
WITH SCHEMABINDING
AS
BEGIN
RETURN @quantity * @list_price * @discount
END

CREATE VIEW sales.discounts
WITH SCHEMABINDING
AS
SELECT
order_id,
SUM(sales.udf_get_discount_amount(
quantity,
list_price,
discount
)) AS discount_amount
FROM
sales.order_items i
GROUP BY
order_id;

DROP VIEW sales.discounts;
DROP FUNCTION sales.udf_get_discount_amount;

