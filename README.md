# OIBSIP_Data-Analytics_1

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `retail_sales`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales`.
- **Table Creation**: A table named `sales` is created to store the sales data. The table structure includes columns for Transaction_ID, Date, Customer_ID, Gender, Age, Product_Category, Quantity, Price_per_unit and Total_Amount.

```sql
CREATE DATABASE retail_sales;

CREATE TABLE sales(
Transaction_ID INT PRIMARY KEY,
Date DATE,
Customer_ID VARCHAR(50),
Gender VARCHAR(20),
Age INT,
Product_Category VARCHAR(50),
Quantity INT,
Price_per_unit FLOAT,
Total_Amount FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM sales;
SELECT COUNT(DISTINCT Customer_ID) FROM sales;
SELECT DISTINCT Product_Category FROM sales;

SELECT * FROM sales
WHERE 
    Date IS NULL OR Transaction_ID IS NULL OR Customer_ID IS NULL OR 
    Gender IS NULL OR Age IS NULL OR Product_Category IS NULL OR 
    Quantity IS NULL OR Price_per_unit IS NULL;

DELETE FROM retail_sales
WHERE 
    Date IS NULL OR Transaction_ID IS NULL OR Customer_ID IS NULL OR 
    Gender IS NULL OR Age IS NULL OR Product_Category IS NULL OR 
    Quantity IS NULL OR Price_per_unit IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **TRANSACTION DATES MIN & MAX**:
```sql
SELECT 
MIN(DATE) AS EARLIEST_TRANSACTION,
MAX(DATE) AS LATEST_TRANSACTION FROM sales;
```

2. **AVG, MIN, MAX, STANDARD DEVIATION OF TOTAL AMOUNT SPENT**:
```sql
SELECT 
AVG(Total_amount) AS Avg_amount_spent, 
MIN(Total_amount) AS Min_amount_spent, 
MAX(Total_amount) AS Max_amount_spent,
STDDEV(Total_amount) AS Standarddev_amount_spent FROM sales;
```

3. **MEAN AMOUNT**:
```sql
SELECT AVG(Total_amount) AS Mean_amount
FROM sales;
```

4. **Median transaction amount**:
```sql
SELECT AVG(Total_Amount) AS MedianTransactionAmount
FROM (
    SELECT Total_Amount FROM Sales
    ORDER BY Total_Amount
    LIMIT 2 OFFSET 499
) AS MedianValues;
```

5. **Most frequently occurring transaction amount (Mode)**:
```sql
SELECT Total_Amount FROM sales
GROUP BY Total_Amount
ORDER BY COUNT(*) DESC
LIMIT 1;
```

6. **Monthly sales totals across the dataset**:
```sql
SELECT 
    MONTH(Date) AS Month, 
    SUM(Total_Amount) AS MonthlySales
FROM sales
GROUP BY MONTH(Date)
ORDER BY Month;
```

7. **Quarterly sales totals**:
```sql
SELECT 
    QUARTER(Date) AS Quarter,
    SUM(Total_Amount) AS QuarterlySales
FROM sales
GROUP BY QUARTER(Date)
ORDER BY Quarter;
```

8. **Male vs Female customers spend in total and on average **:
```sql
SELECT 
    Gender,
    SUM(Total_Amount) AS TotalSpent,
    AVG(Total_Amount) AS AvgSpent
FROM sales
GROUP BY Gender;
```

9. **Different age groups spend in total and on average**:
```sql
SELECT 
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN Age BETWEEN 56 AND 65 THEN '56-65'
        ELSE '65+'
    END AS AgeGroup,
    SUM(Total_Amount) AS TotalSpent,
    AVG(Total_Amount) AS AvgSpent
FROM sales
GROUP BY AgeGroup
ORDER BY AgeGroup;
```

10. **PRODUCT CATEGORY ANALYSIS**:
```sql
SELECT 
    Product_Category,
    AVG(Price_per_unit) AS Average_Price,
    MIN(Price_per_unit) AS Minimum_price,
    MAX(Price_per_unit) AS Maximum_Price
FROM sales
GROUP BY Product_Category;
```

11. **TRANSACTION BEHAVIOR ANALYSIS**:
```sql
SELECT 
    Transaction_Id,
    SUM(Quantity) AS ItemsBought,
    SUM(Total_amount) AS TransactionValue
FROM sales
GROUP BY Transaction_Id
ORDER BY TransactionValue DESC;
```

12. **SEASONAL TREND ANALYSIS**:
```sql
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month_Number,
    DATE_FORMAT(Date, '%M') AS Month,
    SUM(Total_Amount) AS Monthly_Sales
FROM sales
GROUP BY Year, Month_Number, Month
ORDER BY Month_Number;
```

13. **TOP SPENDING CUSTOMERS**:
```sql
SELECT 
    Customer_Id,
    SUM(Total_amount) AS TotalSpend
FROM sales
GROUP BY Customer_Id
ORDER BY TotalSpend DESC;
```

## Findings

- *Customer Demographics:*  
  - Dataset covers multiple age groups.  
  - Age group *46–55* contributed the highest overall spend (₹100,690).  
  - Age group *18–25* had the highest average spend per transaction (₹500.30).  
  - Gender analysis shows *Female customers* spent slightly more overall (₹232,840) compared to Males (₹223,160).  

- *High‑Value Transactions:*  
  - Maximum transaction value recorded was *₹2,000, minimum was *₹25**.  
  - Clear spending tiers observed: premium (₹2000), mid‑range (₹900–₹1500), and budget (<₹500).  
  - Standard deviation ≈ *₹559.71*, indicating wide variation in transaction amounts.  

- *Sales Trends:*  
  - *Quarterly Sales (2023):* Q4 (₹126,190) and Q2 (₹123,735) were strongest; Q3 dipped to ₹96,045.  
  - *Monthly Sales (2023):* Peaks in *May (₹53,150), **October (₹46,580), and **December (₹44,690)*.  
  - Lowest month: *September (₹23,620)*.  
  - 2024 data begins with January (₹1,530).  

- *Product Insights:*  
  - *Electronics (₹156,905)* and *Clothing (₹155,580)* were top revenue drivers.  
  - *Beauty (₹143,515)* followed closely.  
  - Average price per unit ranged between *₹174–₹184*, with min ₹25 and max ₹500 across categories.  

## Reports

- *Sales Summary:*  
  1000 transactions analyzed across three product categories (Electronics, Clothing, Beauty).  

- *Trend Analysis:*  
  Seasonal peaks in May, October, and December highlight festive demand. September shows off‑season slowdown.  

- *Customer Insights:*  
  - Top spending age group: *46–55*.  
  - Highest average spend: *18–25*.  
  - Female customers slightly outspend males.  
  - Transaction tiers reveal premium, mid‑range, and budget shoppers.  

- *Product Analysis:*  
  Electronics and Clothing dominate revenue, Beauty remains strong.  
  Price distribution consistent across categories (₹25–₹500).  

## 🔹Conclusion

This project demonstrates SQL‑based retail sales analysis using the OIBSIP_data-analytics_1 database. By importing the dataset into MySQL Workbench, cleaning records, and running exploratory queries, we uncovered actionable insights on demographics, product performance, transaction behavior, and seasonal trends. The findings highlight how SQL can support business decisions by identifying profitable customer segments, peak seasons, and spending behaviors.  
