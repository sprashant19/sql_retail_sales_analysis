use SP_practice

SELECT * FROM retail_sales

--COUNT NUMBER OF ROWS
SELECT 
	COUNT(*)
FROM retail_sales

--										DATA CLEANING
--CHECKING NULL VALUES IN THE COLUMNS

SELECT * FROM retail_sales
WHERE transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR 
	total_sale IS NULL

--DELETE NULL VALUES

DELETE FROM retail_sales
WHERE transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR 
	total_sale IS NULL

--CHECK NUMBER OF ROWS AFTER DELETING NULL VALUES

SELECT 
	COUNT(*)
FROM retail_sales

--											DATA EXPLORATION

--HOW MANY TOTAL SALES WE HAVE?

SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales

--HOW MANY UNIQUE CUSTOMER WE HAVE

SELECT COUNT(DISTINCT customer_id) AS [NUMBER OF CUSTOMER] FROM retail_sales

--HOW MANY CATEGORIES WE HAVE? 
SELECT DISTINCT category FROM retail_sales

--									BUSINESS KEY PROBLEMS








	


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	AND
	YEAR(sale_date) = 2022
	AND
	MONTH(sale_date) = 11
	AND 
	quantiy>=4
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
		category,
		SUM(total_sale) AS TOTAL_SALES,
		COUNT(*) AS TOTAL_ORDERS
FROM retail_sales
GROUP BY category


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
		AVG(age) AS AVERAGE_AGE
FROM retail_sales
WHERE category = 'Beauty'	


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
FROM retail_sales
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category, gender,COUNT(transactions_id) AS [TOTAL NUMBER OF TRANSACTIONS]
FROM retail_sales
GROUP BY category,gender


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT * 
FROM
(
SELECT 
	YEAR(sale_date) AS [YEAR],
	MONTH(sale_date) AS [MONTH],
	AVG(total_sale) AS SALES,
	RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS [RANK]
FROM retail_sales
GROUP BY YEAR(sale_date),
		MONTH(sale_date)
--ORDER BY YEAR(sale_date),AVG(total_sale) DESC
) AS T1
WHERE RANK=1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT TOP 5 customer_id,
		SUM(total_sale) AS [TOTAL SALES]
FROM retail_sales
GROUP BY customer_id
ORDER BY [TOTAL SALES] DESC


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,
	COUNT(DISTINCT customer_id) AS [NUMBER OF CUSTOMERS]
FROM retail_sales
GROUP BY category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
	SELECT *,
		CASE
			WHEN DATEPART(HOUR,sale_time) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS Shift_1
	FROM retail_sales
)
SELECT
	Shift_1,
	COUNT(*) AS TOTAL_ORDERS
FROM hourly_sale
GROUP BY Shift_1

--									END OF PROJECT