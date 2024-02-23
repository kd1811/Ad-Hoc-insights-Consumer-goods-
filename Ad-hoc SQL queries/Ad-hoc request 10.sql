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