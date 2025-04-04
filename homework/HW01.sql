-- Diego Barreras
-- HW 01: SQL Basics


-- Q1: List all the attributes in the table. 

	SELECT *
	FROM Publishers; 

-- Q2: List the unique names of all the publishers in the table. 

	SELECT pub_name AS 'Name'	
	FROM Publishers;


-- Q3: List all the information of publishers that are in California. 

	SELECT * 
	FROM Publishers
	WHERE state = 'CA';

-- Q4: List all the titles whose type is history. 

	SELECT *
	FROM Titles
	WHERE type = 'history';

-- Q5: List the title name, sales, and publication date of all the titles whose pub_id is 'P01'.

	SELECT title_name AS 'Name', sales AS 'Sales', pub_id AS 'Publication Date'
	FROM Titles
	WHERE pub_id = 'P01';


