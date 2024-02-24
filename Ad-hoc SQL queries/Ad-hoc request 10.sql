/* Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021?
The final output contains these fields,
- division
- product_code
- product
- total_sold_quantity
- rank_order */

WITH CTE1 AS
		  (
		  SELECT
		  p.division,
		  p.product_code,
		  CONCAT(p.product,"(",p.variant,")") AS product,
		  SUM(s.sold_quantity) AS total_sold_quantity
		  FROM fact_sales_monthly s
		  JOIN dim_product p ON p.product_code = s.product_code
		  WHERE s.fiscal_year = 2021
 		  GROUP BY p.product_code
 		  ),
	 CTE2 AS
		 (
		 SELECT 
		 *, 
		 RANK() OVER(PARTITION BY division ORDER BY total_sold_quantity DESC) AS rank_order
		 FROM CTE1
         )
SELECT * FROM CTE2 WHERE rank_order <= 3;
