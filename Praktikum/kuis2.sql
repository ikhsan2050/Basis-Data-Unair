USE classicmodels

-- No 1
SELECT c.customerNumber, c.customerName AS NamaCustomer_086
FROM customers c
WHERE c.customerNumber NOT IN(
	SELECT o.customerNumber
	FROM orders o
	WHERE YEAR(o.orderDate) = '2005' AND MONTH(o.orderDate) BETWEEN 1 AND 6
	)

-- No 2
SELECT p.productCode AS productCode_086, p.productName
FROM products p
WHERE productCode NOT IN(
	SELECT DISTINCT od.productCode
	FROM orderDetails od
	WHERE od.orderNumber IN(
		SELECT o.orderNumber
		FROM orders o
		WHERE YEAR(orderDate) = '2003' AND MONTH(orderDate) BETWEEN 7 AND 12
		)
	)

-- No 3
SELECT c.customerName, c.city, o.orderNumber, COUNT(od.productCode) AS sum_things_086
FROM orders o
INNER JOIN customers c ON c.customerNumber = o.customerNumber
INNER JOIN orderDetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName HAVING sum_things_086 > 15
ORDER BY city


-- No 4
SELECT p.productName, p.productLine, SUM(od.quantityOrdered) AS sum_ordered_086
FROM products p
INNER JOIN orderdetails od ON od.productCode = p.productCode
INNER JOIN orders o ON o.orderNumber = od.orderNumber
WHERE p.productline IN ('Planes', 'Trains', 'Ships') AND YEAR(o.orderDate) > '2003'
GROUP BY p.productName
ORDER BY sum_ordered_086 DESC;


-- No 5
SELECT c.customerNumber AS customer_086,
CONCAT(c.contactFirstName, ' ',c.contactLastName) AS customerName,
CONCAT(c.city,' ',c.country) AS Address,od.orderNumber AS order_086,
p.productName AS product, p.productLine, o.orderDate AS DATE, o.status, o.comments
FROM customers c 
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products p ON od.productCode = p.productCode
WHERE o.status LIKE '%On Hold%'

-- No 6
SELECT c.customerNumber AS Customer_086,
CONCAT(c.contactFirstName," ",c.contactLastName) AS customerName,
o.orderNumber AS order_086, od.quantityOrdered AS item_count,
(od.quantityOrdered*od.priceEach) AS total
FROM customers c
INNER JOIN orders o ON Customer_086 = o.CustomerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
HAVING total BETWEEN '50000' AND '51000'

SELECT * FROM customers
SELECT * FROM products
SELECT * FROM orders
WHERE orderDate BETWEEN '2003-07-01' AND '2003-12-31'
SELECT * FROM orderdetails
