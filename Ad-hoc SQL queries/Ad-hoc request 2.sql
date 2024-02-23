WITH CTE1 AS
(SELECT 
COUNT(DISTINCT(product_code)) AS unique_products_2020
FROM fact_sales_monthly
WHERE fiscal_year = 2020),

CTE2 AS
(SELECT 
COUNT(DISTINCT(product_code)) AS unique_products_2021
FROM fact_sales_monthly
WHERE fiscal_year = 2021)

SELECT
unique_products_2020,
unique_products_2021,
ROUND((unique_products_2021 - unique_products_2020)/unique_products_2020*100,2) AS percentage_chg
FROM CTE1,CTE2;