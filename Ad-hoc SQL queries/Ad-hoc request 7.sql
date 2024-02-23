SELECT
MONTHNAME(s.date) AS Month,
YEAR(s.date) AS Year,
CONCAT(ROUND(SUM(g.gross_price * s.sold_quantity) / 1000000,2), ' M') AS gross_sales_amount
FROM fact_sales_monthly s
JOIN fact_gross_price g
USING (product_code)
JOIN dim_customer c
ON c.customer_code = s.customer_code
WHERE c.customer = "Atliq Exclusive"
GROUP BY Month,Year
ORDER BY Year;