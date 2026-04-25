USE retail_sales;

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