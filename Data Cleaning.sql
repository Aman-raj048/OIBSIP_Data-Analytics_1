-- Data Cleaning

USE retail_sales;

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