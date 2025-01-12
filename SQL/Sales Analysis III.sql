SELECT S.product_id,P.product_name
FROM Sales S
JOIN Product P using(product_id)
GROUP BY 1,2
HAVING min(S.sale_date)>='2019-01-01' and max(S.sale_date)<='2019-03-31'