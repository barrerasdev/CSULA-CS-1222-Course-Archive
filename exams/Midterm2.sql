-- Diego Barreras
-- Midterm 2

-- Q1. Report the names of all customers who have placed an order, the order ID, and whether the order has 
-- been shipped or not. 

	SELECT CONCAT(c.fname, ' ', c.lname) AS "Customer Name", o.oid AS "Order ID",
    CASE
        WHEN o.sdate IS NULL THEN 'No'
        ELSE 'Yes'
    END AS "Shipped"
	FROM Customers c
	JOIN Orders o 
	ON c.cid = o.cid;


-- Q2. Find the first name and the last name of all customers who have NOT placed any orders

	SELECT fname, lname
	FROM Customers
	WHERE cid NOT IN (SELECT DISTINCT cid FROM Orders);

-- Q3. For each order id, calculate the total of the Order. The total of an order is the sum of the prices of
-- all the products (price *quantity) in that order. Sort the results by the total of the order.

	SELECT o.oid AS "Order ID", SUM(p.price * od.quantity) AS "Total"
	FROM Orders o
	JOIN Order_details od ON o.oid = od.oid
	JOIN Products p ON od.pid = p.pid
	GROUP BY o.oid
	ORDER BY "Total";

-- Q4. Identify the customer name(s) who ordered out-of-stock product(s) and the corresponding product id to 
-- let them know the product status.

	SELECT CONCAT(c.fname, ' ', c.lname) AS "Customer Name", od.pid AS "Product ID"
	FROM Customers c
	JOIN Orders o ON c.cid = o.cid
	JOIN Order_details od ON o.oid = od.oid
	JOIN Products p ON od.pid = p.pid
	WHERE p.quantity = 0;

-- Q5. Report the name of the customer who bought the most expensive product, the product name (description), 
-- and the price.

	SELECT CONCAT(c.fname, ' ', c.lname) AS "Customer Name", p.description AS "Product Name", p.price AS "Price"
	FROM Customers c
	JOIN Orders o 
    ON c.cid = o.cid
	JOIN Order_details od 
    ON o.oid = od.oid
	JOIN Products p 
    ON od.pid = p.pid
	ORDER BY p.price DESC
	LIMIT 1;

-- Q6. Report the number of products that are below $50, between $50 and $100 (inclusive), between $101 and 
-- $150 (inclusive), and above $150.
	
	SELECT
		SUM(CASE WHEN price < 50 THEN 1 ELSE 0 END) AS "Below $50",
		SUM(CASE WHEN price >= 50 AND price <= 100 THEN 1 ELSE 0 END) AS "$50-$100",
		SUM(CASE WHEN price >= 101 AND price <= 150 THEN 1 ELSE 0 END) AS "$101-$150",
		SUM(CASE WHEN price > 150 THEN 1 ELSE 0 END) AS "Above $150"
	FROM Products;

-- Q7. For each product, display the product id, the order ID of which contains the product, and the quantity,
-- followed on the next line by the total quantity. 

	SELECT p.pid AS "Product ID", od.oid AS "Order ID", od.quantity AS "Quantity"
	FROM Products p
	JOIN Order_details od ON p.pid = od.pid

	UNION ALL

	SELECT p.pid AS "Product ID", 'total' AS "Order ID", SUM(od.quantity) AS "Quantity"
	FROM Products p
	JOIN Order_details od ON p.pid = od.pid
	GROUP BY p.pid
	ORDER BY "Product ID", "Order ID";
 

-- Q8. The order placed by the customer "Heydemark Wendy" was just shipped. Change the shipping date of the
-- related order to today.

	UPDATE Orders
	SET sdate = CURRENT_DATE
	WHERE cid = (SELECT cid 
				 FROM Customers 
                 WHERE fname = 'Wendy' AND lname = 'Heydemark');

-- Q9. The customer named "Furniture Paddy" wants to add two "MSE001" (products) to the order he placed. Insert
--  a new record into the Order_details table.

	INSERT INTO Order_details (oid, pid, quantity)
	VALUES (
			(SELECT oid 
            FROM Orders 
            WHERE cid =  
					(SELECT cid 
                    FROM Customers 
                    WHERE fname = 'Paddy' AND lname = 'Furniture')), 'MSE001',2 );

-- Q10. For each order, report the order ID, the product ID,  the price of the product, the average price for
--  all products in this order, and the difference value between the price and the average price.

	SELECT 
    od.oid AS 'Order ID',
    od.pid AS 'Product ID',
    p.price AS 'Price',
    avg_prices.avg_price AS 'Average Price',
    p.price - avg_prices.avg_price AS 'Price Difference'
FROM
    Order_details od
        JOIN
    Products p ON od.pid = p.pid
        JOIN
    (SELECT 
        od.oid, AVG(p.price) AS avg_price
    FROM
        Order_details od
    JOIN Products p ON od.pid = p.pid
    GROUP BY od.oid) avg_prices ON od.oid = avg_prices.oid;

-- Extra Credit 

-- Q11. What would be the result table after running the following SQL?

-- SELECT E.EID, E.ENAME, P.EID, P.PID
-- FROM Employees E
-- LEFT JOIN Products P ON E.EID = P.EID;

-- If there was an Employees table, the result table would show:

-- 			E.EID		 |    	E. ENAME 		 |  	P.EID   |  		P.PID 
-- 			 01 					Susan 				01				P122
-- 			 02						Eva					02				P211
-- 			 02						Eva 				02				P212
-- 			 03 					Adam				NULL 			NULL

-- E.EID = Employee ID
-- E.ENAME = Employee Name
-- P.EID = Employee ID that has a product assigned
-- P.PID = Product ID
