-- Diego Barreras
-- HW 06: Advanced Queries

-- Q1: Produce a single list of names, cities, and states for all authors and publishers.
-- Use 'A' and 'P' to identify the source.

SELECT au_fname AS name, city, state, 'A' AS source
FROM Authors
UNION
SELECT pub_name AS name, city, state, 'P' AS source
FROM Publishers;

-- Q2: For each book type, report all the book names of the type,  followed on the next 
-- line by a count of the number of books. The output format is:

SELECT type, GROUP_CONCAT(title_name ORDER BY title_name ASC) AS BookNames,
       COUNT(*) AS BookCount
FROM Titles
GROUP BY type
ORDER BY type;

-- Q3: For each publisher, report the publisher's name and the name of authors who have 
-- books published by this publisher. Use EXISTS and correlated sub-queries.

SELECT pub_name AS Publisher, (SELECT GROUP_CONCAT(CONCAT(au_fname, ' ', au_lname) ORDER BY au_lname, au_fname ASC)
							   FROM Authors
							   WHERE au_id IN (SELECT DISTINCT TA.au_id
											   FROM Title_Authors AS TA
											   INNER JOIN Titles AS T ON TA.title_id = T.title_id
											   WHERE T.pub_id = P.pub_id)
											   ) AS Authors
FROM Publishers AS P;

-- Q4: For each book type, report the title name, the number of pages of the title, the
-- average number of pages for all books for this book type, and the difference between the two. 
-- Use correlated sub-queries in the SELECT clause.

SELECT title_name AS TitleName, pages AS NumberOfPages, (SELECT AVG(pages) 
														FROM Titles t2 
                                                        WHERE t2.type = t1.type) AS AveragePagesForType,
														pages - (SELECT AVG(pages) 
																 FROM Titles t3 
                                                                 WHERE t3.type = t1.type) AS PageDifference
FROM Titles t1
ORDER BY t1.type, TitleName;

-- Q5: Re-design the query in Q4 using sub-queries in the FROM clause.

SELECT t1.title_name AS TitleName, t1.pages AS NumberOfPages, t2.AveragePagesForType, t1.pages - t2.AveragePagesForType AS PageDifference
FROM Titles t1
JOIN 	(SELECT type, AVG(pages) AS AveragePagesForType
		FROM Titles
		GROUP BY type) t2 ON t1.type = t2.type
ORDER BY t1.type, TitleName;


