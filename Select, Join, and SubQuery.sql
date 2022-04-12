--select all column from orders
select * from orders;
select * from customers;

--Join table order and customers
select * 
from orders o 
left join customers c
on o.customer_id = c.customer_id
order by 4;

-- Looking at kind of order_status
select order_status
from orders o 
join customers c
on o.customer_id = c.customer_id
group by order_status
order by 4 asc;

-- looking at total order vs total customers
select 
	count(distinct order_id),
	count (distinct customer_id)
from orders;

--looking at total order by order_status
select 
	order_status,
	count(order_status) as total
from orders
group by order_status;

--how many  order_status is canceled by customer_city ?
select 
	customer_city,
	count(customer_city) as total
from orders o 
join customers c
on o.customer_id = c.customer_id
where order_status = 'canceled'
group by customer_city
order by 2 desc;

--what average is time to ship in days by customer_city
select 
	customer_city,
	avg(time_to_ship2) 
from (
			select 
				customer_city,
				date_part('days', time_to_ship) as time_to_ship2	
			from (
					select 
						customer_city,
						order_delivered_customer_date -  order_delivered_carrier_date as time_to_ship
					from orders o 
					join customers c
					on o.customer_id = c.customer_id
					where order_delivered_customer_date is not null
					order by time_to_ship desc
				) subq
		)subq2
where time_to_ship2 > 0
group by 1
order by 2 desc;


