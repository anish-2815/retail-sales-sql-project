-- Retail Sales SQL Project
-- Complete SQL Case Study

-- =========================================
-- 1. CREATE TABLES
-- =========================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================================
-- 2. INSERT SAMPLE DATA
-- =========================================

INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Pune', 'Maharashtra'),
(2, 'Sneha Patil', 'Mumbai', 'Maharashtra'),
(3, 'Amit Verma', 'Delhi', 'Delhi');

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 55000),
(2, 'Mouse', 'Electronics', 500),
(3, 'Shoes', 'Fashion', 2500),
(4, 'T-Shirt', 'Fashion', 700);

INSERT INTO orders VALUES
(101, 1, '2024-01-05'),
(102, 2, '2024-01-10'),
(103, 1, '2024-02-01');

INSERT INTO order_items VALUES
(1, 101, 1, 1),
(2, 101, 2, 2),
(3, 102, 3, 1),
(4, 103, 4, 3);

-- =========================================
-- 3. SQL ANALYSIS QUERIES
-- =========================================

-- 3.1 Total Sales
SELECT 
    SUM(p.price * oi.quantity) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 3.2 Monthly Revenue
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- 3.3 Top Customers by Revenue
SELECT 
    c.name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- 3.4 Best-Selling Products (Window Function)
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_sold,
    RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS rank_no
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- 3.5 Returning Customers (More than 1 order)
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 1;

