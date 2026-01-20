
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    age INT NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(30)
);


CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    department VARCHAR(30) NOT NULL
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    sales DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


SELECT * FROM customers;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM orders;


--INNER JOIN query to combine orders with customer details--

SELECT
    o.order_id, o.order_date, o.quantity, o.sales,
    c.customer_id, c.customer_name, c.gender, c.city, c.country, c.age
 FROM orders o
 INNER JOIN customers c
 ON o.customer_id = c.customer_id;

--Total orders in orders table--

SELECT COUNT(*) AS total_orders
FROM orders;

--Total rows after INNER JOIN--

SELECT COUNT(*) AS joined_orders
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;


--LEFT JOIN : Customers with NO Orders--

 SELECT
    c.customer_id, c.customer_name, c.gender, c.city, c.country
 FROM customers c
 LEFT JOIN orders o
    ON c.customer_id = o.customer_id
 WHERE o.order_id IS NULL;


--join between orders and products to calculate total revenue per product--

SELECT
    p.product_id,
    p.product_name,
    SUM(o.sales) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC;

--Top 5 High-Performing Products--

SELECT
    p.product_id,
    p.product_name,
    SUM(o.sales) AS total_revenue
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

--Category-wise Revenue Distribution--

SELECT
    c.category_id,
    c.category_name,
    SUM(o.sales) AS total_revenue
FROM categories c
INNER JOIN products p
    ON c.category_id = p.category_id
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_revenue DESC;

--Sales in a Specific Region Between Two Dates--

SELECT
    c.city AS region,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.city = 'Mumbai'
  AND o.order_date BETWEEN '2024-02-01' AND '2024-03-31'
GROUP BY c.city;



--END--












		