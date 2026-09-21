-- 05: Aylıq sifariş sayını göstərir, natamam ayları tapmaq üçün
SELECT substr(order_purchase_timestamp, 1, 7) AS order_month,
       COUNT(*) AS orders
FROM orders
GROUP BY order_month
ORDER BY order_month;