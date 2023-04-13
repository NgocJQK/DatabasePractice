Use CSDL_Project
Go

select top (5) ss.name as Ten, sum(so.price) as Tien from sales.staffs ss
left join sales.orders so on so.staff_id = ss.staff_id
where so.created_date between '2018-01-01' and '2022-01-02' or ss.staff_id not in (select staff_id from sales.orders)
group by ss.name
order by Tien desc 

select top (5) sc.name as Ten, sum(so.price) as Tien from sales.customers sc
left join sales.orders so on so.customer_id = sc.customer_id
where sc.customer_id != 1 and so.created_date between '2018-01-01' and '2022-01-02' or sc.customer_id not in (select staff_id from sales.orders) 
group by sc.name
order by Tien desc

select * from sales.customers