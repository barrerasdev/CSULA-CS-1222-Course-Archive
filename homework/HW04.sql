-- Diego Barreras
-- HW 04

-- Q1: Report the names of all authors and the title_name of the books (if any) they have written.

SELECT A.au_fname AS AuthorFirstName, A.au_lname AS AuthorLastName, 
       T.title_name AS BookTitle
FROM Authors A
LEFT JOIN Title_Authors TA
ON A.au_id = TA.au_id
LEFT JOIN Titles T 
ON TA.title_id = T.title_id
WHERE T.title_name IS NOT NULL
ORDER BY A.au_fname;

-- Q2: For each author, report the author name and the number of books that he/she wrote, if any.

SELECT A.au_fname AS Author_FirstName, A.au_lname AS Author_LastName, 
       COUNT(TA.title_id) AS 'Number Of Books Written'
FROM Authors A
LEFT JOIN Title_Authors TA 
ON A.au_id = TA.au_id
GROUP BY A.au_id, A.au_fname, A.au_lname;

-- Q3: For each author who has written a book,  list the author name, title name, and the royalty_rate.

SELECT A.au_fname AS Author_FirstName, A.au_lname AS Author_LastName,
       T.title_name AS Book_Title, R.royalty_rate AS Royalty_Rate
FROM Authors A
INNER JOIN Title_Authors TA 
ON A.au_id = TA.au_id
INNER JOIN Titles T 
ON TA.title_id = T.title_id
LEFT JOIN Royalties R 
ON T.title_id = R.title_id;

-- Q4: Find the name of the publisher that published the book with the greatest royalty rate.

SELECT P.pub_name AS Publisher_Name
FROM Publishers P
JOIN Titles T 
ON P.pub_id = T.pub_id
JOIN Royalties R 
ON T.title_id = R.title_id
WHERE R.royalty_rate = (SELECT MAX(royalty_rate) 
						FROM Royalties);

-- Q5: Find the title name of the latest published book, the name of its author, and the publisher's name.

SELECT T.title_name AS Latest_Book_Title, 
       A.au_fname AS Author_FirstName, A.au_lname AS Author_LastName, 
       P.pub_name AS Publisher_Name
FROM Titles T
JOIN Title_Authors TA ON T.title_id = TA.title_id
JOIN Authors A ON TA.au_id = A.au_id
JOIN Publishers P ON T.pub_id = P.pub_id
WHERE T.pubdate = (SELECT MAX(pubdate) 
					FROM Titles);

-- Q6: List the name of all publishers, the number of books, and the maximum price of the book they have published (if any).

SELECT P.pub_name AS Publisher_Name, 
       COUNT(T.title_id) AS Number_of_Books_Published, 
       MAX(T.price) AS Maximum_Price
FROM Publishers P
LEFT JOIN Titles T 
ON P.pub_id = T.pub_id
WHERE T.price IS NOT NULL
GROUP BY P.pub_name;

-- Q7: For each book, list the book name, the author name, and the publisher's name.

SELECT T.title_name AS Book_Name, 
       A.au_fname AS Author_FirstName, A.au_lname AS Author_LastName, 
       P.pub_name AS Publisher_Name
FROM Titles T
INNER JOIN Title_Authors TA 
ON T.title_id = TA.title_id
INNER JOIN Authors A 
ON TA.au_id = A.au_id
INNER JOIN Publishers P 
ON T.pub_id = P.pub_id;

-- Q8: Find the name of the author who wrote the longest book in terms of pages.

SELECT A.au_fname AS Author_FirstName, A.au_lname AS Author_LastName
FROM Authors A
JOIN Title_Authors TA 
ON A.au_id = TA.au_id
JOIN Titles T 
ON TA.title_id = T.title_id
WHERE T.pages =		(SELECT MAX(pages) 
					 FROM Titles);