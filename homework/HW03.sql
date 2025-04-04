-- Diego Barreras
-- Homework 03 

-- Q1: List the title_name and book type of books that are more expensive than all 'history' books.

SELECT title_name, type
FROM Titles
WHERE price > ALL (SELECT price FROM Titles WHERE type = 'history');

-- Q2: List the title_id and au_id of books written by the authors whose last name is 'Hull'.

SELECT TA.title_id, TA.au_id
FROM Title_Authors TA
JOIN Authors A
ON TA.au_id = A.au_id
WHERE A.au_lname = 'Hull' ;

-- Q3: Find the name(s) of the author(s) that have NOT written any book. 

SELECT au_fname, au_lname
FROM Authors
WHERE au_id NOT IN (SELECT DISTINCT au_id
					FROM Title_Authors);

-- Q4: Find the id(s) of the author(s) who have written 'children' books.

SELECT DISTINCT A.au_id
FROM Authors A
JOIN Title_Authors TA
ON A.au_id = TA.au_id
JOIN Titles T ON TA.title_id = T.title_id
WHERE T.type = 'children';

-- Q5: Find the name(s) of the publisher(s) that have published more than one books.

SELECT pub_name
FROM Publishers
WHERE pub_id IN(SELECT pub_name
				FROM Publishers
				GROUP BY pub_id
                HAVING COUNT(*) > 1);
                
-- Q6: List the title_name and book type of books that have the lowest royalty rate.

SELECT T.title_name, T.type
FROM Titles T
WHERE T.title_id IN (SELECT title_id
					FROM Royalties
					WHERE royalty_rate = (SELECT MIN(royalty_rate) 
											FROM Royalties));
                    
-- Q7: Find the pub_id  of the publisher(s) that have published the LEAST expensive book.

SELECT pub_id
FROM Titles
WHERE price = ( SELECT MIN(price)
				FROM Titles);
                
-- Q8: Find the name(s) of the publisher(s) that published the book with the greatest number of pages.

SELECT pub_name
FROM Publishers
WHERE pub_id = (SELECT pub_id
				FROM Titles
                WHERE pages = ( SELECT MAX(pages)
								FROM Titles));
