--=====================================
--RETAIL SALES SQL ANALYSIS
--DATABASE SETUP
--=====================================

--create customer table
create table customers (
customer_id varchar(50) primary key,
customer_unique_id varchar(50),
customer_zip_code_prefix integer,
customer_city varchar(100),
customer_state varchar(10)
);

--create orders table
create table orders (
order_id varchar(50) primary key,
customer_id varchar(50),
order_status varchar(30),
order_purchase_timestamp timestamp,
order_approved_at timestamp,
order_delivered_carrier_date timestamp,
order_delivered_customer_date timestamp,
order_estimated_delivery_date timestamp
);

--create order items table
create table order_items(
order_id varchar(50),
order_item_id integer,
product_id varchar(50),
seller_id varchar(50),
shipping_limit_date timestamp,
price numeric(10,2),
freight_value numeric(10,2),
primary key (order_id, order_item_id)
);

--create products table
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_value NUMERIC
);

CREATE TABLE product_category_translation (
	product_category_name VARCHAR(100),
	product_category_name_english VARCHAR (100)
);

-- Add Foreign Key: Orders → Customers
alter table orders
add constraint fk_orders_customers
foreign key (customer_id)
references customers(customer_id);

-- Add Foreign Key: Order Items → Orders
lter table order_items
add constraint fk_order_items_orders
foreign key (order_id)
references orders(order_id);

-- Add Foreign Key: Order Items → Products
alter table order_items
add constraint fk_order_items_products
foreign key (product_id)
references products(product_id);

