-- Diego Barreras

-- HW 05: Functions

-- Q1: List the books published in May in the last 10 years. Note that your query should remain correct in the future, which means the numbers 2020 and 2010
-- should not appear anywhere in the query.

SELECT title_name
FROM Titles
WHERE YEAR(pubdate) >= YEAR(CURRENT_DATE) - 10 AND MONTH(pubdate) = 5;


-- Q2: List the author names in the form <first initial>, period, space,< last name>, e.g. 'K. Hull'. Order the results first by the last name, then by the first name. 
-- Only list those authors who have both first name and last name in the database.

SELECT CONCAT(LEFT(au_fname, 1), '.', ' ', au_lname) AS 'Author Name'
FROM Authors
WHERE au_fname IS NOT NULL AND au_fname != '' AND au_lname IS NOT NULL AND au_lname != ''
ORDER BY au_lname, au_fname;


-- Q3: Display the name of those publishers whose name ends with 'press'.  Note: ONLY display the name without 'press' in it 
-- (i.e. OMIT 'press' in your displayed publisher names).

SELECT SUBSTRING(pub_name, 1, LENGTH(pub_name) - 5) AS 'Publisher Name'
FROM Publishers
WHERE pub_name LIKE '%press';

-- Q4: List the name(s) of the author(s) that wrote the book with the longest title name.

SELECT DISTINCT au_fname, au_lname
FROM Authors
INNER JOIN Title_Authors 
ON Authors.au_id = Title_Authors.au_id
INNER JOIN Titles 
ON Title_Authors.title_id = Titles.title_id
WHERE LENGTH(title_name) = (SELECT MAX(LENGTH(title_name)) 
							FROM Titles);

-- Q5: For each author, list the author id, area code, and the phone number without the area code.

SELECT au_id AS 'Author ID', SUBSTRING(phone, 1, 3) AS 'Area Code', SUBSTRING(phone, 5) AS 'Phone Number'
FROM Authors;




