# Retail Sales SQL Project  

A complete end-to-end SQL case study using a retail sales dataset.  
This project demonstrates essential SQL skills used in real data analyst roles, including:

- Database design  
- Data cleaning  
- Joins  
- Aggregations  
- Window functions  
- CTEs  
- Business insights  

---

## 📊 Project Overview  
Analyze sales performance across customers, products, and months to generate insights such as:

- Best-selling products  
- Top customers by revenue  
- Monthly revenue trends  
- Category-level performance  
- Repeat customers  
- Sales patterns  

This project simulates real-world data analysis used in retail and e-commerce companies.

---

## 🏗️ Database Schema (ER Diagram)

CUSTOMERS(customer_id, name, city, state)
PRODUCTS(product_id, product_name, category, price)
ORDERS(order_id, customer_id, order_date)
ORDER_ITEMS(order_item_id, order_id, product_id, quantity)

---

## 🗂️ SQL Setup Script

### 1️⃣ Create Tables

```sql
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

2️⃣ Insert Sample Data

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

🧠 SQL Analysis Queries

1️⃣ Total Sales

SELECT 
    SUM(price * quantity) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

2️⃣ Monthly Revenue

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(price * quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

3️⃣ Top Customers by Revenue

SELECT 
    c.name,
    SUM(price * quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

4️⃣ Best-Selling Products (Window Function)

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_sold,
    RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS rank_no
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;

5️⃣ Returning Customers

SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 1;

📈 Key Insights

From this analysis, we can identify:

Product categories with highest revenue

Customers who drive repeat purchases

Seasonal sales trends

High-value customer segments

Best-performing products

These insights help businesses optimize pricing, marketing, inventory, and customer strategy.

🛠 Tools Used

SQL (MySQL / PostgreSQL)

GitHub for version control

🙋 About Me

I am Anish Tupe, a data analyst skilled in:

SQL

Python

Power BI

Data Analysis

Machine Learning

This project is part of my growing data analytics portfolio.
