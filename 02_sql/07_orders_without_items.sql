-- 07: order_items cədvəlində heç bir məhsul sətri olmayan sifarişləri statusa görə sayır
SELECT o.order_status,
       COUNT(*) AS orders_without_items
FROM orders AS o
LEFT JOIN order_items AS oi ON oi.order_id = o.order_id
WHERE oi.order_id IS NULL
GROUP BY o.order_status
ORDER BY orders_without_items DESC;