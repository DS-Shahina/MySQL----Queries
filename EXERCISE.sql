-- 1st Exercise
-- Return all the products
-- name
-- unit price
-- new price (unit price * 1.1)
SELECT
    name,
    unit_price,
    (unit_price * 1.1) AS 'new price'
FROM products;

-- 2nd Exercise
-- Get the orders placed this year
SELECT *
FROM orders
WHERE order_date >= '2019-01-01'; -- Get orders placed this year

-- 3rd Exercise
-- FROM the order_items table, get the items
-- for order #6
-- where the total price is greater than 30

SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;

-- 4th Exercise

-- Return products with
-- quantity in stock equal to 49, 38, 72

SELECT *
FROM products
WHERE quantity_in_stock IN (49,38,72);

-- 5th Exercise
-- Return customers born
-- between 1/1/1990 and 1/1/2000

SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- 6th Exercise

-- Get the customers whose 
-- 1) addresses contain TRAIL or AVENUE
-- 2) phone numbers end with 9
-- 3) phone numbers not end with 9

SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
      address LIKE '%avenue%'; 
      
SELECT *
FROM customers
WHERE phone LIKE '%9';      
      
SELECT *
FROM customers
WHERE phone NOT LIKE '%9';

-- 7th Exercise

-- Get the customers whose
-- first names are ELKA or AMBUR
-- last names end with EY or ON
-- last names start with MY or contains SE 
-- last names contain B followed by R or  U

SELECT *
FROM customers
WHERE first_name REGEXP 'Elka|Ambur';

SELECT *
FROM customers
WHERE last_name REGEXP 'EY$|ON$';

SELECT *
FROM customers
WHERE last_name REGEXP '^MY|SE';

SELECT*
FROM customers
WHERE last_name REGEXP 'b[ru]';

SELECT*
FROM customers
WHERE last_name REGEXP 'br|bu';
 
-- 8TH Exercise
-- Get the orders that are not shipped

SELECT *
FROM orders
WHERE shipper_id IS NULL;
-- OR
SELECT *
FROM orders
WHERE shippe_date IS NULL;

-- 9th Exercise

SELECT * , quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price  DESC;

-- 10th Exercise
-- Get the top three loyal customers

SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;

-- 11th Exercise

SELECT order_id, oi.product_id, quantity, oi.unit_price
FROM order_items oi
JOIN products p  ON oi.product_id = p.product_id;

-- 12th Exercise

USE sql_invoicing;  
SELECT 
    p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name
FROM clients c
JOIN payments p
     ON c.client_id = p.client_id
JOIN payment_methods pm
     ON p.payment_method = pm.payment_method_id;

-- 13th Exercise

SELECT 
      p.product_id,
      p.name,
      oi.quantity
FROM products p
LEFT JOIN order_items oi -- observation which is present in left table (products)
     ON p.product_id = oi.product_id -- customer_id is priority for customers table
ORDER BY p.product_id;     

-- 14th Exercise

SELECT
   o.order_id,
   o.order_date,
   c.first_name AS customer,
   sh.name AS shipper,
   os.name AS status
FROM orders o
JOIN customers c
     ON o.customer_id =  c.customer_id
LEFT JOIN shippers sh
     ON o.shipper_id =  sh.shipper_id
JOIN order_statuses os
     ON o.status =  os.order_status_id; 

-- 15th Exercise
USE sql_invoicing;

SELECT 
     p.date,
     p.amount,
     c.name AS client,
     pm.name AS payment_method
FROM clients c
JOIN payments p
     USING (client_id)
JOIN payment_methods pm
     ON p.payment_method = pm.payment_method_id;   

-- 16th Exercise
-- Do a cross join between shippers and products 
-- using the implicit syntax
-- and then using the explicit syntax

-- Implicit syntax
SELECT 
     sh.name AS shipper,
     p.name AS product
FROM shippers sh, products p
ORDER BY sh.name;

-- Explicit Syntax
SELECT
    sh.name AS shipper,
    p.nname AS product
FROM shippers sh
CROSS JOIN products p
ORDER BY sh.name;

-- 17th Exercise
-- points < 2000 (Bronze), points between 2000 - 3000 (Silver), points > 3000 (Gold)

SELECT customer_id, 
       first_name, 
       points, 
       'Bronze' AS Bronze
FROM customers
WHERE points < 2000
UNION
SELECT customer_id, 
       first_name, 
       points, 
       'Silver' AS Silver
FROM customers
WHERE points BETWEEN 200 AND 3000
UNION
SELECT customer_id, 
       first_name, 
       points, 
       'Gold' AS Gold
FROM customers
WHERE points > 3000
ORDER BY first_name;

-- 18th Exercise
-- Insert three rows in the products table

INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ('Product1', 10, 1.95),
	   ('Product2', 11, 1.95),
       ('Product3', 12, 1.95);

-- 19th Exercise
USE sql_invoicing;

CREATE TABLE invoices_archived AS
SELECT 
    i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
    USING (client_id)
WHERE payment_date IS NOT NULL;   

-- 20th Exercise
-- Anyone borns before 1990 have extra 50 points
-- Write a SQL statement to give any customers born before 1990
-- 50 extra points

USE sql_store;
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

-- 21st Exercise

UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN
            (SELECT customer_id
            FROM customers
            WHERE points > 3000)





















