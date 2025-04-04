-- Diego Barreras
-- HW 09: Views

-- Q1: Create a view to report the name(s) of the author(s) that have not written any book.

	CREATE VIEW AuthorsWithoutBooks AS
		SELECT au_id, au_fname, au_lname
		FROM Authors
		WHERE au_id NOT IN (SELECT DISTINCT au_id FROM Title_Authors);

	SELECT *
	FROM AuthorsWithoutBooks;

	DROP VIEW AuthorsWithoutBooks;

-- Q2: Create a view to report the author name, title name and the royalty_rate of each author.

	CREATE VIEW AuthorRoyalties AS
		SELECT CONCAT(a.au_fname, ' ', a.au_lname) AS author_name, t.title_name, r.royalty_rate
		FROM Authors a
		JOIN Title_Authors ta ON a.au_id = ta.au_id
		JOIN Titles t ON ta.title_id = t.title_id
		JOIN Royalties r ON t.title_id = r.title_id;


	SELECT *
    FROM AuthorRoyalties;
    
    DROP VIEW AuthorRoyalties;
    
-- Q3: Create a view to report the name of the publisher that published the book with the smallest 
-- royalty rate.

	CREATE VIEW PublisherWithSmallestRoyalty AS
		SELECT p.pub_name, t.title_name, r.royalty_rate
		FROM Publishers p
		JOIN Titles t ON p.pub_id = t.pub_id
		JOIN Royalties r ON t.title_id = r.title_id
		WHERE r.royalty_rate = (SELECT MIN(royalty_rate) FROM Royalties);
	
    SELECT *
    FROM PublisherWithSmallestRoyalty;
    
    DROP VIEW PublisherWithSmallestRoyalty;

-- Q4: Create an updatable view that reports the information of books with price greater than $18. Make 
-- sure that new books with price smaller than $18 cannot be inserted into the Books table through this view.

	CREATE VIEW ExpensiveBooks AS
		SELECT t.title_id, t.title_name, t.type, t.pages, t.price, t.sales, t.pubdate, t.contract,
				CONCAT(a.au_fname, ' ', a.au_lname) AS author_name, ta.au_order, ta.royalty_share
		FROM Titles t
		JOIN Title_Authors ta ON t.title_id = ta.title_id
		JOIN Authors a ON ta.au_id = a.au_id
		WHERE t.price > 18
		WITH CHECK OPTION;

	SELECT *
	FROM ExpensiveBooks;

	DROP VIEW ExpensiveBooks;

-- Q5: Redefine the view created in question Q4. Change the price to $20. Everything else is the same

	CREATE OR REPLACE VIEW ExpensiveBooks AS
	SELECT title_id, title_name, type, pub_id, pages, 20.00 AS price, sales, pubdate, contract
	FROM Titles
	WHERE price > 18;
