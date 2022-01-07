-- The SELECT Statement

USE sql_store;

SELECT * 
FROM customers; -- * (asterisk) is for all columns, FROM is a clause
-- WHERE customer_id = 1 -> only 1 customer_id, WHERE is a clause
-- ORDER BY first_name -- ascending order, ORDER BY is a clause
-- The order should be FROM, WHERE, ORDER BY

-- The SELECT Clause

SELECT last_name, first_name, points, points + 10  -- addition
FROM customers;

SELECT 
	 last_name, 
     first_name, 
	 points, 
	 (points + 10) * 100  AS 'discount factor' -- or we can use discount_factor, AS means Alias - name the column
FROM customers;
-- Order of Arithematic Operator
-- * / is higher order than + -

-- DISTINCT Clause

SELECT DISTINCT state -- DISTINCT -> Avoid Duplicate
FROM customers;

-- WHERE Clause

SELECT *
FROM customers
WHERE points > 3000; -- customers only belongs to points which is greater than 3000 

SELECT *
FROM customers
WHERE state = 'VA'; -- customers only belongs to state 'VA'

SELECT *
FROM customers
WHERE state <> 'VA'; -- customers only not belongs to state 'VA' we can use != operator also

SELECT *
FROM customers
WHERE birth_date > '1990-01-01'; -- customers only belongs to birthdate > '1990-01-01', 
-- The format should be like this - 1990, january, 1st day

-- AND and OR Operator

SELECT *
FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000; -- customers birthdate is greater than 1990 and points is greater than 1000

SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000; -- customers birthdate is greater than 1990 or points is greater than 1000

SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR 
      (points > 1000 AND state = 'VA'); -- customers birthdate is greater than 1990 or points is greater than 1000 AND state shoud be 'VA'
      
SELECT *
FROM customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000); -- customers birthdate which is less than '1990-01-01' and points is less than 1000

SELECT *
FROM customers
WHERE (birth_date <= '1990-01-01' AND points <= 1000); -- customers birthdate which is less than '1990-01-01' and points is less than 1000

-- AND Operator is always evaluated 1st, then OR operator

-- IN Operator

SELECT *
FROM customers
WHERE state = 'VA' OR state = 'GA' OR state = 'FL';

SELECT *
FROM customers
WHERE state IN ('VA','FL','GA'); -- customers have all the state 'VA','FL','GA'

SELECT *
FROM customers
WHERE state NOT IN ('VA','FL','GA'); -- customers Exclude these states 'VA','FL','GA'

-- BETWEEN Operator

SELECT *
FROM customers
WHERE points >= 1000 AND points <= 3000;

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

-- LIKE Operator

SELECT * 
FROM customers
WHERE last_name LIKE 'b%'; -- starts with b

SELECT * 
FROM customers
WHERE last_name LIKE 'brush%'; -- starts with brush

SELECT * 
FROM customers
WHERE last_name LIKE '%b%'; -- Any number of characters before or after b, just it contains b

SELECT * 
FROM customers
WHERE last_name LIKE '%y'; -- ends with y

SELECT * 
FROM customers
WHERE last_name LIKE '_y'; -- matches single character, second charater should be y

SELECT * 
FROM customers
WHERE last_name LIKE '_____y'; -- matches single character, after 5 charaters should be y

SELECT * 
FROM customers
WHERE last_name LIKE 'b____y'; -- starts with b and after 4th character it should be y

-- Note -> % any number of characters, _ single character

-- REGEXP Operator

SELECT *
FROM customers
WHERE last_name REGEXP 'field'; -- Any number of characters before or after field, just it contains field

SELECT *
FROM customers
WHERE last_name REGEXP '^field'; -- Starts with field

SELECT *
FROM customers
WHERE last_name REGEXP 'field$'; -- ends with field

SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac'; -- we want to find the customes who have the word field or mac in their last name

SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac|rose'; -- we use pipe or vertical bar

SELECT *
FROM customers
WHERE last_name REGEXP '^field|mac|rose'; -- 1st name should be field

SELECT *
FROM customers
WHERE last_name REGEXP 'field$|mac|rose'; -- last should be field

SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e'; -- character with 'ge','ie','me', with 'e', ends with 'e'

SELECT *
FROM customers
WHERE last_name REGEXP 'e[fmq]'; -- character with 'ef','em','eq', with 'e', starts with 'e'

SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e'; -- character between a & h with 'e' at end

-- ^ begining
-- $ end
-- | logical or
-- [abcd]
-- [a-f]

-- IS NOT NULL OPERATOR

SELECT *
FROM customers
WHERE phone IS NOT NULL; -- every customer does have their phone number

-- The ORDER BY Clause

SELECT * 
FROM customers
ORDER BY first_name; -- ascending order

SELECT * 
FROM customers
ORDER BY first_name DESC; -- descending order

SELECT * 
FROM customers
ORDER BY state, first_name; -- first sort state followed by first_name

SELECT *
FROM customers
ORDER BY state DESC, first_name DESC; -- descending order

SELECT first_name, last_name
FROM customers
ORDER BY birth_date;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY points, first_name;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY 1,2;

-- Note: always sort data by column name not 1,2

-- The LIMIT Clause

SELECT*
FROM customers
LIMIT 3; -- first 3 customers

SELECT *
FROM customers
LIMIT 6, 3 # we have to access page 3 which is 7,8,9, so 6 is basically to skip first 6 records

-- page 1: 1 - 3
-- page 2: 4 - 6
-- page 3: 7 - 9






