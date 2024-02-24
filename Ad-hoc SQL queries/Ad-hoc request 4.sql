/* Which segment had the most increase in unique products in 2021 vs 2020?
The final output contains these fields,
- segment
- product_count_2020
- product_count_2021
- difference */

WITH a AS
			(SELECT
			p.segment,
			COUNT(DISTINCT(s.product_code)) AS product_count_2020
			FROM dim_product p
            JOIN fact_sales_monthly s
            ON s.product_code = p.product_code
            WHERE fiscal_year = 2020
            GROUP BY p.segment
			),
	 b AS
			(SELECT
			p.segment,
			COUNT(DISTINCT(s.product_code)) AS product_count_2021
			FROM dim_product p
            JOIN fact_sales_monthly s
            ON s.product_code = p.product_code
            WHERE fiscal_year = 2021
            GROUP BY p.segment
            )
SELECT
a.segment,
a.product_count_2020,
b.product_count_2021,
(b.product_count_2021 - a.product_count_2020) AS difference
FROM a
JOIN b
ON a.segment = b.segment
ORDER BY difference DESC;
