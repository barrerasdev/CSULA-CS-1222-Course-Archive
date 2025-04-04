-- Diego Barreras
-- HW02: Aggregate 

-- Q1: For each title id, list the number of authors.

SELECT title_id AS titleID, COUNT(au_id) AS '# of Authors'
FROM Title_Authors
GROUP BY title_id;

-- Q2: For each state, list the number of authors who live in that state.

SELECT state AS 'State', COUNT(*) AS '# of Authors'
FROM Authors 
WHERE state IS NOT NULL
GROUP BY state;

-- Q3: For each book type,  list the number of books and the average number of pages.

SELECT type AS 'Book Type', COUNT(*) AS '# of Books', AVG(pages) AS 'Average Pages'
FROM Titles 
GROUP BY type;

-- Q4: List the number of books, the minimum price, the maximum price, and the average price of all books published by each publisher.
-- Sort the results by the average price.

SELECT pub_id AS 'Publisher ID', 
	COUNT(*) AS Number, 
	MIN(price) AS 'Min Price', 
	MAX(price) AS 'Max Price', 
	AVG(price) AS 'Average Price'
FROM Titles 
GROUP BY pub_id
ORDER BY AVG(price);

-- Q5:  For each book type, list the book type and the average price of those books with price greater than 10 in each category. 
-- Only keep the types with the average price greater than 15.  Sort the results by the average price. 

SELECT type AS 'Book Type' , AVG(price) AS 'Average Price'
FROM Titles 
WHERE price > 10
GROUP BY type
HAVING AVG(price) > 15
ORDER BY AVG(price);

-- Q6: List the unique full name (first name and last name) of all authors who have an address with 'St' anywhere in it.

SELECT DISTINCT CONCAT(au_fname,' ', au_lname) AS 'Full Name'
FROM Authors
WHERE address LIKE '%St%';