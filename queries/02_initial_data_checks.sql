--==========================================================
-- RETAIL SALES SQL ANALYSIS
-- INITIAL DATA CHECKS
--==========================================================

-- Check Customers
select * from customers
limit 10;

--count customer records
select count(*) as total_customers
from customers;

--count unique customers
select count(distinct customer_unique_id) as unique_customers
from customers;

--check orders
select * from orders
limit 10;

--count orders
select count(*) as total_orders
from orders;

--check order items
select *
from order_items
limit 10;

--count order items
select count(*) as total_order_items
from order_items;

--count average items per order
select
count(*) * 1.0 / count(distinct order_id)
as average_items_per_order
from order_items;

--find orders with the most items
select 
	order_id,
	count(*) as item_count
from order_items
group by order_id
order by item_count desc
limit 10;

--check products
select * from products
limit 10;

--count products
SELECT COUNT(*) AS total_products
FROM products;

select * from order_reviews
limit 10;

SELECT
    COUNT(*) AS total_reviews
FROM order_reviews;


SELECT *
FROM order_payments
LIMIT 10;






