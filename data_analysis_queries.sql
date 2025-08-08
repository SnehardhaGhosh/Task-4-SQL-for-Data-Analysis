-- Create schema (optional)
CREATE SCHEMA IF NOT EXISTS ecommerce_db;
SET search_path TO ecommerce_db;

-- Customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

-- Categories
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50)
);

-- Products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT REFERENCES categories(category_id)
);

-- Orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    status VARCHAR(20)
);

-- Order Items
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    unit_price DECIMAL(10, 2)
);

-- Payments
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    payment_date DATE,
    amount DECIMAL(10, 2),
    method VARCHAR(20)
);


-- #INSERT VALUES FOR ALL TABLES


-- Insert Customers
INSERT INTO customers (name, email, city, signup_date) VALUES
('Alice Smith', 'alice@example.com', 'New York', '2023-01-10'),
('Bob Johnson', 'bob@example.com', 'Los Angeles', '2023-01-15'),
('Charlie Lee', 'charlie@example.com', 'Chicago', '2023-02-01'),
('David Kim', 'david@example.com', 'Houston', '2023-02-10'),
('Eva Brown', 'eva@example.com', 'Phoenix', '2023-02-12'),
('Frank Wilson', 'frank@example.com', 'San Diego', '2023-03-01'),
('Grace Liu', 'grace@example.com', 'Dallas', '2023-03-10'),
('Hannah Davis', 'hannah@example.com', 'San Jose', '2023-03-15'),
('Ian Clark', 'ian@example.com', 'Austin', '2023-03-20'),
('Jane Miller', 'jane@example.com', 'Jacksonville', '2023-04-01'),
('Karl Adams', 'karl@example.com', 'Fort Worth', '2023-04-05'),
('Lily Evans', 'lily@example.com', 'Columbus', '2023-04-10'),
('Mike Brown', 'mike@example.com', 'Charlotte', '2023-04-15'),
('Nina White', 'nina@example.com', 'Seattle', '2023-04-20'),
('Oscar Reed', 'oscar@example.com', 'Denver', '2023-04-25');

-- Insert Categories
INSERT INTO categories (category_name) VALUES
('Electronics'), ('Books'), ('Clothing'), ('Home & Kitchen'), ('Toys');

-- Insert Products
INSERT INTO products (name, price, category_id) VALUES
('Laptop', 1200.00, 1),
('Smartphone', 800.00, 1),
('Tablet', 300.00, 1),
('Bluetooth Speaker', 50.00, 1),
('Fiction Book', 20.00, 2),
('Cookbook', 25.00, 2),
('T-shirt', 15.00, 3),
('Jeans', 40.00, 3),
('Blender', 60.00, 4),
('Coffee Maker', 90.00, 4),
('Toy Car', 10.00, 5),
('Doll', 15.00, 5),
('Board Game', 25.00, 5),
('Monitor', 200.00, 1),
('Headphones', 100.00, 1);

-- Insert Orders
INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2023-04-01', 'Completed'),
(2, '2023-04-02', 'Pending'),
(3, '2023-04-03', 'Completed'),
(4, '2023-04-04', 'Completed'),
(5, '2023-04-05', 'Pending'),
(6, '2023-04-06', 'Completed'),
(7, '2023-04-07', 'Completed'),
(8, '2023-04-08', 'Shipped'),
(9, '2023-04-09', 'Shipped'),
(10, '2023-04-10', 'Completed'),
(11, '2023-04-11', 'Pending'),
(12, '2023-04-12', 'Completed'),
(13, '2023-04-13', 'Completed'),
(14, '2023-04-14', 'Completed'),
(15, '2023-04-15', 'Cancelled');

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1200.00),
(2, 2, 1, 800.00),
(3, 5, 2, 20.00),
(4, 7, 3, 15.00),
(5, 10, 1, 90.00),
(6, 3, 1, 300.00),
(7, 13, 2, 25.00),
(8, 8, 1, 40.00),
(9, 4, 2, 50.00),
(10, 6, 1, 25.00),
(11, 12, 1, 15.00),
(12, 9, 1, 60.00),
(13, 14, 1, 200.00),
(14, 11, 2, 10.00),
(15, 15, 1, 100.00);

-- Insert Payments
INSERT INTO payments (order_id, payment_date, amount, method) VALUES
(1, '2023-04-01', 1200.00, 'Credit Card'),
(3, '2023-04-03', 40.00, 'PayPal'),
(4, '2023-04-04', 45.00, 'Credit Card'),
(6, '2023-04-06', 300.00, 'Debit Card'),
(7, '2023-04-07', 50.00, 'Credit Card'),
(8, '2023-04-08', 40.00, 'UPI'),
(9, '2023-04-09', 100.00, 'Credit Card'),
(10, '2023-04-10', 25.00, 'UPI'),
(12, '2023-04-12', 60.00, 'Debit Card'),
(13, '2023-04-13', 200.00, 'PayPal'),
(14, '2023-04-14', 20.00, 'Credit Card');

-- #TASK_1 .Use SELECT, WHERE, ORDER BY, GROUP BY
    
select * from customers

select name,
email from customers
where city='New York'
order by signup_date Desc;


select *from orders

select order_date,
count(order_id) as PerDay
from orders
group by
order_date
order by order_date;

select * from products

select product_id,
name,
price
from products
where price >=100
order by price desc;

select *from customers
select *from orders
select *from  order_items


select c.customer_id,
c.name,
sum(oi.quantity * oi.unit_price) as total_spent
from customers as c
join orders as o on o.customer_id=c.customer_id
join order_items as oi on oi.order_id=o.order_id
group by
c.customer_id,c.name
order by
total_spent desc;


-- #TASK_2 Use JOINS (INNER, LEFT, RIGHT)


-- join inner,left,right
select c.customer_id,
c.name,
order_id,
order_date
from customers as c
inner join orders as o on c.customer_id=o.customer_id;

-- left join
select * from products
select * from categories

select p.product_id,
p.name,
p.category_id,
category_name
from products as p
left join categories as c on p.category_id=c.category_id

    
-- right join 
select *from payments;
select * from orders;

SELECT 
    p.payment_id,
    p.order_id,
    p.payment_date,
    p.amount,
    p.method,
    o.customer_id,
    o.order_date,
    o.status
FROM 
    orders AS o
RIGHT JOIN 
    payments AS p ON o.order_id = p.order_id;



-- #TASK_3 subqueries


-- subquery
SELECT 
    c.name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id, c.name
HAVING 
    SUM(oi.quantity * oi.unit_price) > (
        SELECT AVG(total)
        FROM (
            SELECT 
                SUM(oi2.quantity * oi2.unit_price) AS total
            FROM 
                orders o2
            JOIN 
                order_items oi2 ON o2.order_id = oi2.order_id
            GROUP BY 
                o2.customer_id
        ) AS avg_spend
    )
ORDER BY 
    total_spent DESC;



-- #TASK_4 Use aggregate functions (SUM, AVG)


    
-- aggregate function
SELECT 
    AVG(order_total) AS average_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM 
        orders o
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        o.order_id
) AS order_totals;



-- #TASK_5 Create views for analysis


    
-- customer_spending_view
CREATE VIEW customer_spending_view AS
SELECT 
    c.customer_id,
    c.name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id, c.name;

SELECT * FROM customer_spending_view WHERE total_spent > 1000;


-- #TASK_6 Optimize queries with indexes

-- Index Use Cases from Your Schema
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_customers_city ON customers(city);
SELECT * FROM customers WHERE email = 'alice@example.com';

CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_payments_payment_date ON payments(payment_date);
SELECT order_id FROM orders WHERE order_date BETWEEN '2023-04-01' AND '2023-04-30';






