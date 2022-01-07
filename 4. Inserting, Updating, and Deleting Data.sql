-- 1) Column Attributes

-- 2) Inserting a Row

INSERT INTO customers
VALUES (
         DEFAULT, 
        'John', 
		'Smith', 
        '1990-01-01',
         NULL,
         'address',
         'city',
         'CA',
         DEFAULT); 

-- DEFAULT AND NULL BOTH GIVE SAME RESULT        
         
-- We don't take primary key, Null values 
         
INSERT INTO customers (
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
VALUES (
        'John', 
		'Smith', 
        '1990-01-01',
		'address',
		'city',
		'CA');
         
-- 3) Inserting Multiple Rows

INSERT INTO shippers (name)
VALUES ('Shipper1'),
	   ('Shipper2'),
       ('Shipper3');

-- 4) Inserting Hierarchical Rows
-- Insert data into Multiple Tables

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

INSERT INTO order_items
VALUES
     (LAST_INSERT_ID(), 1, 1, 2.95),
	 (LAST_INSERT_ID(), 2, 1, 3.95);
     
-- 5) Creating a Copy of a Table     
-- How to copy data from one table to another.

CREATE TABLE orders_archived AS
SELECT * FROM orders;

-- order placed before 2019 is copied into orders_archived table
INSERT INTO orders_archived 
SELECT *
FROM orders
WHERE order_date < '2019-01-01';

-- 6) Updating a Single Row

UPDATE invoices
SET payment_total = 10, payment_date = '2019-03-01'
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total = DEFAULT, payment_date = NULL
WHERE invoice_id = 1;

UPDATE invoices
SET 
     payment_total = invoice_total * 0.5, 
     payment_date = due_date
WHERE invoice_id = 3;

-- 7) Updating Multiple Rows

-- sql can only update single row, if client_id = 3, multiple times, they update only 1st time not all the client_id which contains 3
-- for that go to Edit -> Preferences -> SQL Editor -> Last option uncheck -> ok
-- copy the code below and close the window
-- again open the window of local and paste it

UPDATE invoices
SET 
     payment_total = invoice_total * 0.5, 
     payment_date = due_date
WHERE client_id = 3;

UPDATE invoices
SET 
     payment_total = invoice_total * 0.5, 
     payment_date = due_date
WHERE client_id IN (3,4);

-- 8) Using Subqueries in Updates

UPDATE invoices
SET 
     payment_total = invoice_total * 0.5, 
     payment_date = due_date
WHERE client_id = 
           (SELECT client_id
	        FROM clients
		    WHERE name = 'Myworks');

UPDATE invoices
SET 
     payment_total = invoice_total * 0.5, 
     payment_date = due_date
WHERE client_id IN
           (SELECT client_id
	        FROM clients
		    WHERE state IN ('CA','NY'));

UPDATE invoices
SET
   payment_total = invoice_total * 0.5,
   payment_date = due_date
WHERE payment_date IS NULL;  

-- 9) Deleting Rows

DELETE FROM invoices
WHERE client_id = (
    SELECT *
    FROM clients
    WHERE name = 'MYworks'
)    

-- 10) Restoring the Databases












         
         
         
         
         
         
         