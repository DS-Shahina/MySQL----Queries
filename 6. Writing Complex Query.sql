-- 2) Subqueries

-- Find products that are more
-- expensive than Lettuce (id =3)

SELECT *
FROM products
WHERE unit_price > (
    SELECT unit_price
    FROM products
    WHERE product_id = 3
);

-- Exercise
-- In sql_hr database:
-- Find employees whose earn more than average
USE sql_hr;

SELECT *
FROM employees
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
);  

-- 3) The IN Operator

-- Find the products that have never been ordered
USE sql_store;

SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM order_items
);

-- Exercise
-- Find clients without invoices

USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id NOT IN (
     SELECT DISTINCT client_id
	 FROM invoices
);

-- 4) Subqueries vs Joins

SELECT *
FROM clients
LEFT JOIN invoices USING (client_id)
WHERE invoice_id IS NULL;

-- Exercise
-- Find customers who have ordered lettuce (id=3)
-- Select customer_id, first_name, last_name

-- Subqueries

USE sql_store;

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM order_items oi
    JOIN orders o USING (order_id)
    WHERE product_id = 3
);

-- solve using join

SELECT DISTINCT customer_id, first_name, last_name
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3;

-- 5) The ALL Keyword

-- Select invoices larger than all invoices of client 3

USE sql_invoicing;

SELECT *
FROM invoices
WHERE invoice_total > (
      SELECT MAX(invoice_total)
      FROM invoices
      WHERE client_id = 3
);

-- using ALL

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	 SELECT invoice_total
     FROM invoices
     WHERE client_id = 3
);   

-- 6) The ANY Keyword -- IN = ANY
-- Select clients with at least two invoices

-- 7) Correlated Subqueries
-- Select employees whose salary is
-- above the average in their office

-- for each employee
-- calculate the avg salary for employee.office
-- return the employee if salary > avg

USE sql_hr;

SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
); 

-- Exercise
-- Get invoices that are larger than the
-- client's average invoice amount

USE sql_invoicing;

SELECT *
FROM invoices i
WHERE invoice_total > (
    SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
);

-- 8) The EXISTS Operator
-- Select clients that have an invoice

SELECT *
FROM clients
WHERE client_id IN(
    SELECT DISTINCT client_id
    FROM invoices
);  

-- other way to write

SELECT *
FROM clients c
WHERE EXISTS (
     SELECT client_id
     FROM invoices
     WHERE client_id = c.client_id
);   

-- Exercise
-- Find the products that have never been ordered

USE sql_store;

SELECT *
FROM products p
WHERE NOT EXISTS (
   SELECT product_id
   FROM order_items
   WHERE product_id = p.product_id
);  

-- 9) Subqueries in the SELECT Clause

SELECT
    invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total)
        FROM invoices) AS invoice_average,
    invoice_total - (SELECT invoice_average) AS difference
FROM invoices;

-- Exercise
SELECT 
    client_id,
    name,
    (SELECT SUM(invoice_total)
       FROM invoices
       WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales - average) AS difference
FROM clients c ;  

-- 10) Subqueries in the FROM Clause

SELECT *
FROM (
   SELECT 
     client_id,
     name,
     (SELECT SUM(invoice_total)
        FROM invoices
        WHERE client_id = c.client_id) AS total_sales,
     (SELECT AVG(invoice_total) FROM invoices) AS average,
     (SELECT total_sales - average) AS difference
  FROM clients c
) AS sales_summary
WHERE total_sales IS NOT NULL










   