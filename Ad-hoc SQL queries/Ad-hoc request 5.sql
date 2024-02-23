#Products that have the highest and lowest manufacturing costs

SELECT 
p.product_code,
p.product,
ROUND(m.manufacturing_cost,2) AS manufacturing_cost
FROM dim_product p
JOIN fact_manufacturing_cost m
ON m.product_code = p.product_code
WHERE manufacturing_cost IN
(
(SELECT MAX(m.manufacturing_cost) FROM fact_manufacturing_cost m),
(SELECT MIN(m.manufacturing_cost) FROM fact_manufacturing_cost m)
)
ORDER BY m.manufacturing_cost DESC;