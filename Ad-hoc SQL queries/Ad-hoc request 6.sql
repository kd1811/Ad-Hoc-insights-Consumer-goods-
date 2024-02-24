/* Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market.
The final output contains these fields,
- customer_code
- customer
- average_discount_percentage */

#Top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market

SELECT
d.customer_code,
c.customer,
ROUND(AVG(d.pre_invoice_discount_pct*100),2) AS average_discount_percentage
FROM dim_customer c
JOIN fact_pre_invoice_deductions d
ON c.customer_code = d.customer_code
WHERE c.market = "India" AND d.fiscal_year = 2021
GROUP BY d.customer_code, c.customer
ORDER BY average_discount_percentage DESC
LIMIT 5;
