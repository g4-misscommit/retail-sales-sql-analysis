-- ==========================================
-- RETAIL SALES SQL ANALYSIS
-- SALES PERFORMANCE ANALYSIS
-- ==========================================

-- Business Objective:
-- Analyze overall customer, order, product,
-- and sales performance.


-- Q1: How many unique customers have we served?
select
	count(distinct customer_unique_id) as unique_custoners
from customers;

-- Q2: How many orders have been placed?
select
	count(*) as total_orders
from orders;

-- Q3: How many products are in the product catalog?
select
	count (*) as total_products
from products;

-- Q4: How many individual items have been sold?
select
	count(*) as total_items_sold
from order_items;

-- Q5: What is the total revenue generated from product sales?
select
	sum(price) as total_revenue
from order_items;

select * from order_items limit 10;

-- Q6: What is the average order value?
select
	sum(price) / count(distinct order_id) as average_order_value
from order_items;

-- rounded off 
select
	round(
		sum(price) / count(distinct order_id),
		2
	) as average_order_value
from order_items;


--- ==========================================
-- PRODUCT CATEGORY ANALYSIS
-- ==========================================


-- Q7: View order items with product categories
SELECT
    oi.order_id,
    oi.product_id,
    oi.price,
    p.product_category_name
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LIMIT 10;


-- Q8: Which product categories generate the most revenue?
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;


-- Q9: Compare items sold and revenue by category
select
	p.product_category_name,
	count(*) as items_sold,
	round(SUM(oi.price), 2) as total_revenue
from order_items oi
join products p
	on oi.product_id = p.product_id
group by p.product_category_name
order by total_revenue desc;


-- Q10: Which product categories have the highest average selling price?
SELECT
    p.product_category_name,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS average_item_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY average_item_price DESC;


-- ==========================================
-- SALES TRENDS OVER TIME
-- ==========================================


-- Q11: View order dates and item prices

SELECT
    o.order_id,
    o.order_purchase_timestamp,
    oi.price
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
LIMIT 10;


-- Q12: What is the monthly revenue trend?

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY sales_month
ORDER BY sales_month;


-- Q13: How many orders and how much revenue were generated each month?

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY sales_month
ORDER BY sales_month;


-- Q14: Which months generated the most revenue?

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY sales_month
ORDER BY total_revenue DESC;


-- ==========================================
-- DELIVERY PERFORMANCE ANALYSIS
-- ==========================================


-- Q15: How long does each order take to deliver?

SELECT
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_delivered_customer_date
        - order_purchase_timestamp AS delivery_time
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
LIMIT 10;


-- Q16: What is the average delivery time?

SELECT
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    - order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- Q17: Compare actual delivery date with estimated delivery date.

SELECT
    order_id,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    order_delivered_customer_date
        - order_estimated_delivery_date AS delivery_difference
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
LIMIT 10;


-- Q18: What percentage of orders were delivered late?

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date
                     > order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


-- Q19: How many orders were early, on time, or late?

SELECT
    CASE
        WHEN order_delivered_customer_date
             < order_estimated_delivery_date
            THEN 'Early'

        WHEN order_delivered_customer_date
             = order_estimated_delivery_date
            THEN 'On Time'

        ELSE 'Late'
    END AS delivery_status,

    COUNT(*) AS total_orders

FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
ORDER BY total_orders DESC;
























