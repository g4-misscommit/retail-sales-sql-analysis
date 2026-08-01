select
	coalesce(t.product_category_name_english, p.product_category_name) as category,
	round(sum(oi.price), 2) as total_revenue
from order_items oi
join products p
	on oi.product_id = p.product_id
left join product_category_translation t
	on p.product_category_name = t.product_category_name
group by category
order by total_revenue desc
limit 10;


select
	coalesce(t.product_category_name_english, p.product_category_name) as category,
	count(*) as items_sold
from order_items oi
join products p
	on oi.product_id = p.product_id
left join product_category_translation t
	on p.product_category_name = t.product_category_name
group by category
order by items_sold
limit 10;


select
	c.customer_state,
	round(sum(op.payment_value), 2) as total_revenue
from customers c
join orders o
	on c.customer_id = o.customer_id
join order_payments op
	on o.order_id = op.order_id
group by c.customer_state
order by total_revenue
limit 10;


select
	date_trunc('month', o.order_purchase_timestamp) as month, 
	round(sum(op.payment_value), 2) as revenue
from orders o
join order_payments op
	on o.order_id = op.order_id
group by month
order by month;


select
	payment_type,
	round(sum(payment_value),2) as total_revenue
from order_payments
group by payment_type
order by total_revenue desc;


select
	p.product_category_name,
	count(*) as quantity_sold,
	round(sum(oi.price), 2) as revenue
from order_items oi
join products p
	on oi.product_id = p.product_id
group by p.product_category_name
order by revenue desc
limit 10;


