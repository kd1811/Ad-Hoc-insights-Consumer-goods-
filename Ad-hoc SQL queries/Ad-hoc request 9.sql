/* Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?
The final output contains these fields,
- channel
- gross_sales_mln
- percentage */

WITH CTE1 AS
(
SELECT
c.channel,
CONCAT(ROUND(SUM(g.gross_price * s.sold_quantity) / 1000000,2), ' M') AS gross_sales_mln
FROM fact_sales_monthly s
JOIN fact_gross_price g USING (product_code)
JOIN dim_customer c USING (customer_code)
WHERE s.fiscal_year = 2021
GROUP BY c.channel)

SELECT
*,
ROUND(gross_sales_mln*100/SUM(gross_sales_mln) OVER (),2) AS percentage
FROM CTE1
ORDER BY percentage DESC;
