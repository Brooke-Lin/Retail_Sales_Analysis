# Retail Sales Analysis SQL Project

## Project Overview
This project demonstrates SQL skills commonly used in data analysis, including data exploration, cleaning, and business-driven insights.
The dataset represents retail sales transactions and is used to answer real-world business questions such as revenue trends, customer behavior, and product performance.

## Objectives
* Create and manage a retail sales database
* Clean and validate dataset quality
* Perform exploratory data analysis (EDA)
* Extract business insights using SQL queries
* Practice advanced SQL concepts (GROUP BY, HAVING, CTEs, Window Functions)

### Database Setup
1. Create Database
```sql
CREATE DATABASE retail_sales_project;
```

2. Table Structure
```sql
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    customer_id VARCHAR(15),
    gender VARCHAR(15),
    age INT,
    product_category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    total_amount FLOAT
);
```

### Data Cleaning
Before analysis, the dataset is checked for missing values.
```sql
SELECT *
FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR product_category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR total_amount IS NULL;
```

### Exploratory Data Analysis (EDA)
1. Total Transactions & Customers
```sql
SELECT 
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;
```

2. Product Categories
```sql
SELECT DISTINCT product_category
FROM retail_sales;
```

### Business Analysis & Insight
1. Show all sales transactions that occurred after 1 January 2023.
```sql
SELECT *
FROM retail_sales
WHERE sale_date > '2023-01-01'
ORDER BY sale_date;
```

2. How much total revenue has the company generated?
```sql
SELECT 
	SUM(total_amount) AS total_revenue
FROM retail_sales;
```

3. Which product category generated the highest total revenue?
```sql
SELECT
	product_category,
	SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 1;
```

4. How many unique customers have made purchases in each product category?
```sql
SELECT 
	product_category,
	COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales
GROUP BY product_category;
```

5. Find all customers who have spent more than $1,000 in total.
```sql
SELECT 
	customer_id,
	SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY customer_id
HAVING SUM(total_amount) > 1000;
```

6. What is the average purchases amount for each gender?
```sql
SELECT
	gender,
	AVG(total_amount) AS avg_revenue
FROM retail_sales
GROUP BY gender;
```

7. Which month generated the highest total revenue?
```sql
SELECT 
	EXTRACT(MONTH FROM sale_date) AS sale_month,
	SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY sale_month
ORDER BY total_revenue DESC
LIMIT 1;
```

8. List the Top 5 customers based on their total spending.
```sql
SELECT
	customer_id,
	SUM(total_amount) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 5;
```

9. Find all transactions where the purchase amount is higher than the overall average transaction amount.
```sql
SELECT
	transaction_id,
	total_amount
FROM retail_sales
WHERE total_amount > (SELECT AVG(total_amount)
						FROM retail_sales);
```

10. Rank all customers based on their total spending from highest to lowest.
```sql
SELECT
    customer_id,
    SUM(total_amount) AS total_spending,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC;
```

## Key Findings
* Revenue is concentrated in a small group of high-value customers
* Certain product categories contribute significantly more to total sales
* Seasonal/monthly trends show variation in purchasing behavior
* Customer segmentation helps identify high-spending individuals



