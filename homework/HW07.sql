-- Diego Barreras
-- HW 07: DML and DDL

-- Q1: Use the CREATE TABLE statement to create a table Authors2 which has exactly the same fields as the `Authors` table.

CREATE TABLE Authors2 AS
SELECT * 
FROM Authors;

-- Q2: Use INSERT INTO ... SELECT to populate Authors2 with the content of the `Authors` table.

INSERT INTO Authors2
SELECT * 
FROM Authors;

-- Q3: We finally found out that the missing first name of Kellsey is "Buford". Write a query to update the information in
--  Authors2. Note that there might be more than one author with the last name Kellsey.

UPDATE Authors2
SET au_fname = 'Buford'
WHERE au_lname = 'Kellsey';

-- Q4: Add a new column email to Athors2.

ALTER TABLE Authors2
ADD COLUMN email VARCHAR(100);

-- Q5: The email of an author is in the form: first letter of the first name in lower case, last name in lower case, @hotmail.com.
--  e.g. Sarah Buckman's email address would be sbuckman@hotmail.com. Write a query to fill in the email information in Authors2.

UPDATE Authors2
SET email = CONCAT(LOWER(SUBSTRING(au_fname, 1, 1)), LOWER(au_lname), '@hotmail.com');

-- Q6: The area code 415 in San Francisco has changed to 475. Write a query to update the information in authors2. You may assume that
-- the phone numbers are in the form ###-###-####, where the first 3 digits are the area code.

UPDATE Authors2 
SET phone = REPLACE(phone, '415', '475')
WHERE phone LIKE '415%';
    
-- Q7: Delete from Authors2 all authors who have authored books published by 'Tenterhooks Press'
    
DELETE FROM Authors2
WHERE au_id IN (
  SELECT TA.au_id
  FROM Title_Authors AS TA
  JOIN Titles AS T 
  ON TA.title_id = T.title_id
  JOIN Publishers AS P 
  ON T.pub_id = P.pub_id
  WHERE P.pub_name = 'Tenterhooks Press');

-- Q8: Delete the inserted column email from Authors2.

ALTER TABLE Authors2
DROP COLUMN email;

-- Reset queries 

DROP TABLE Authors2;







