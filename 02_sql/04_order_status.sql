-- 04: Sifariş statuslarının sayını, faizini və tarix aralığını göstərir
SELECT order_status,
       COUNT(*) AS orders,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM orders), 2) AS pct,
       MIN(order_purchase_timestamp) AS first_order,
       MAX(order_purchase_timestamp) AS last_order
FROM orders
GROUP BY order_status
ORDER BY orders DESC;