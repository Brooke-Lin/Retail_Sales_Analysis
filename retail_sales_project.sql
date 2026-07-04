-- SQL Retail Sales Analysis
CREATE DATABASE retail_sales_project;

-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
				transaction_id INT PRIMARY KEY,
				sale_date DATE,	
				customer_id	VARCHAR(15),
				gender VARCHAR(15),
				age	INT,
				product_category VARCHAR(15),	
				quantity INT,	
				price_per_unit FLOAT,	
				total_amount FLOAT
);

SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT(*)
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE
	transaction_id IS NULL
	OR
	sale_date IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	product_category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	total_amount IS NULL;

-- Data Exploration

-- 1) How many sales transactions were made?
-- 2) How many unique customers purchased products?
SELECT 
	COUNT(*) 					AS total_transactions,
	COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;

-- 3) What product categories do we sell?
SELECT DISTINCT product_category AS unique_categories
FROM retail_sales;

-- Data Analysis

-- Q.1) Show all sales transactions that occurred after 1 January 2023. 
SELECT *
FROM retail_sales
WHERE sale_date > '2023-01-01'
ORDER BY sale_date;

-- Q.2) How much total revenue has the company generated?
SELECT 
	SUM(total_amount) AS total_revenue
FROM retail_sales;

-- Q.3) Which product category generated the highest total revenue?
SELECT
	product_category,
	SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 1;

-- Q.4) How many unique customers have made purchases in each product category?
SELECT 
	product_category,
	COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales
GROUP BY product_category;

-- Q.5) Find all customers who have spent more than $1,000 in total.
SELECT 
	customer_id,
	SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY customer_id
HAVING SUM(total_amount) > 1000;

-- Q.6) What is the average purchases amount for each gender?
SELECT
	gender,
	AVG(total_amount) AS avg_revenue
FROM retail_sales
GROUP BY gender;

-- Q.7) Which month generated the highest total revenue?
SELECT 
	EXTRACT(MONTH FROM sale_date) AS sale_month,
	SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY sale_month
ORDER BY total_revenue DESC
LIMIT 1;

-- Q.8) List the Top 5 customers based on their total spending.
SELECT
	customer_id,
	SUM(total_amount) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 5;

-- Q.9) Find all transactions where the purchase amount is higher than the overall average transaction amount.
SELECT
	transaction_id,
	total_amount
FROM retail_sales
WHERE total_amount > (SELECT AVG(total_amount)
						FROM retail_sales);
	
-- Q.10) Rank all customers based on their total spending from highest to lowest.
SELECT
    customer_id,
    SUM(total_amount) AS total_spending,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC;






