-- 3. Retrieving Data From Multiple Tables
-- 1) Inner joins

SELECT order_id, orders.customer_id,  first_name, last_name
FROM orders 
JOIN customers 
	ON orders.customer_id = customers.customer_id; -- join orders and customers table only if customer_id column are equal

SELECT order_id, o.customer_id,  first_name, last_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;

-- 2) Joining Across Databases

USE sql_store;

SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	 ON oi.product_id = p.product_id;
     
USE sql_inventory;

SELECT *
FROM sql_store.order_items oi
JOIN products p   
     ON oi.product_id = p.product_id;  
     
-- 3) Self Joins

-- employee_id, their name and their manager

USE sql_hr;
SELECT 
     e.employee_id,
     e.first_name,
     m.first_name AS Manager
FROM employees e
JOIN employees m
     ON e.reports_to = m.employee_id;
 
-- 4) Joining Multiple Tables 

USE sql_store;

SELECT *
FROM orders o
JOIN customers c
     ON o.customer_id = c.customer_id
JOIN order_statuses os
     ON o.status = os.order_status_id;
  
USE sql_store;  
SELECT 
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o
JOIN customers c
     ON o.customer_id = c.customer_id
JOIN order_statuses os
     ON o.status = os.order_status_id;
     
 -- 5) Compound Join Conditions   
 -- JOIN 2 similar Types of columns (primary key) in 2 tables - composite orimary key
 SELECT *
 FROM order_items oi
 JOIN order_item_notes oin
      ON oi.order_id = oin.order_Id
      AND oi.product_id = oin.product_id;
 
-- 6) Implicit Join Syntax

SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;

-- Prefer this
SELECT *
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;
    
-- 7) OUTER JOIN

SELECT 
      c.customer_id,
      c.first_name,
      o.order_id
FROM customers c
LEFT JOIN orders o -- observation which is present in left table (customer_id)
     ON c.customer_id = o.customer_id -- customer_id is priority for customers table
ORDER BY c.customer_id;     
     
SELECT 
      c.customer_id,
      c.first_name,
      o.order_id
FROM customers c
RIGHT JOIN orders o -- observation which is present in Right table (order_id)
     ON c.customer_id = o.customer_id -- customer_id is priority for orders table
ORDER BY c.customer_id;

--  8) Outer Join Between Multiple Tables 

SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
    ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;    

-- 9) Self Outer Joins

-- Show every employee whether they have manager or not
USE sql_hr;
SELECT
    e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m
     ON e.reports_to = m.employee_id;

-- 10) The USING Clause

-- It only works when column name is same in the tables

SELECT
    o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
	 USING (customer_id)  -- ON o.customer_id = c.customer_id    
LEFT JOIN shippers sh
     USING (shipper_id) ;  

SELECT *
FROM order_items oi
JOIN order_item_notes oin
    USING (order_id, product_id);-- ON oi.order_id = oin.order_id AND
	                            -- oi.product_id = oin.product_id

-- 11) Natural Joins

-- join based on common columns automatically with same name
-- it's dangerous, so i discourage to use it.

SELECT
   o.order_id,
   c.first_name
FROM orders o 
NATURAL JOIN customers c;

-- 12) Cross Joins
-- Join every record from the first table, with every record, in a second table

-- Explicit syntax for cross join
SELECT 
    c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;

-- 13) Unions
-- In SQL we can also combine rows with multiple tables
-- Current year 'Active'

SELECT 
     order_id,
     order_date,
     'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'; 

-- Write another query similar to this that will return the order in the previous year, but with an different label, archive.

SELECT 
     order_id,
     order_date,
     'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

-- using UNION Operator we can combine these two query which is mentioned above.

SELECT 
     order_id,
     order_date,
     'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
     order_id,
     order_date,
     'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

-- Combine query with same table or multiple table

SELECT first_name
FROM customers
UNION
SELECT name
FROM shippers;

SELECT name AS full_name -- what ever gives 1st name it will take it
FROM shippers
UNION
SELECT first_name
FROM customers;




     
 
     

