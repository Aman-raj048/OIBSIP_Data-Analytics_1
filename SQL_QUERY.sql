USE retail_sales;

-- 1. How many total records (rows) are in the dataset?
SELECT COUNT(*) FROM sales;

-- 2. What are the unique product categories present?
SELECT DISTINCT Product_Category FROM sales;

-- 3. What is the earliest and latest transaction date in the dataset?
SELECT 
    MIN(Date) AS earlist_transaction_date,
    MAX(Date) AS latest_transaction_date
FROM sales;

-- 4. What is the average, minimum, maximum, and standard deviation of the total amount spent?
SELECT 
    AVG(Total_Amount) AS average_spent_amt,
    MIN(Total_Amount) AS min_spent_amt,
    MAX(Total_Amount) AS max_spent_amt,
    STDDEV(Total_Amount) AS standarddev_spent_amt
FROM sales;

-- 5. What is the median transaction amount?
SELECT AVG(Total_Amount) AS MedianTransactionAmount
FROM (
    SELECT Total_Amount FROM Sales
    ORDER BY Total_Amount
    LIMIT 2 OFFSET 499
) AS MedianValues;

-- 6. What is the most frequently occurring transaction amount (mode)?
SELECT Total_Amount FROM sales
GROUP BY Total_Amount
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 7. What are the monthly sales totals across the dataset?
SELECT 
    MONTH(Date) AS Month, 
    SUM(Total_Amount) AS MonthlySales
FROM sales
GROUP BY MONTH(Date)
ORDER BY Month;

-- 8. What are the quarterly sales totals?
SELECT 
    QUARTER(Date) AS Quarter,
    SUM(Total_Amount) AS QuarterlySales
FROM sales
GROUP BY QUARTER(Date)
ORDER BY Quarter;

-- 9. How much do male vs female customers spend in total and on average?
SELECT 
    Gender,
    SUM(Total_Amount) AS TotalSpent,
    AVG(Total_Amount) AS AvgSpent
FROM sales
GROUP BY Gender;

-- 10. How much do customers of different age groups spend in total and on average?
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

-- 11. Which product categories generate the highest sales revenue?
SELECT 
    Product_Category, SUM(Total_Amount) AS Total_Revenue
FROM sales
GROUP BY Product_Category
ORDER BY Total_Revenue DESC;

-- 12. What is the average, minimum, and maximum price per unit for each product category?
SELECT 
    Product_Category,
    AVG(Price_per_unit) AS Average_Price,
    MIN(Price_per_unit) AS Minimum_price,
    MAX(Price_per_unit) AS Maximum_Price
FROM sales
GROUP BY Product_Category;

-- 13. How many items are bought per transaction, and what is the total value of each transaction?
SELECT 
    Transaction_Id,
    SUM(Quantity) AS ItemsBought,
    SUM(Total_amount) AS TransactionValue
FROM sales
GROUP BY Transaction_Id
ORDER BY TransactionValue DESC;

-- 14. How do monthly sales vary across the year (seasonal shopping habits)?
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month_Number,
    DATE_FORMAT(Date, '%M') AS Month,
    SUM(Total_Amount) AS Monthly_Sales
FROM sales
GROUP BY Year, Month_Number, Month
ORDER BY Month_Number;

-- 15. Which customers spend the most overall?
SELECT 
    Customer_Id,
    SUM(Total_amount) AS TotalSpend
FROM sales
GROUP BY Customer_Id
ORDER BY TotalSpend DESC;

-- END OF PROJECT