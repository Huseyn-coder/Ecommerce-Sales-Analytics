-- 02: Primary key sütunlarında təkrar dəyər olub-olmadığını yoxlayır
SELECT 'orders.order_id' AS check_name, COUNT(*) - COUNT(DISTINCT order_id) AS duplicates FROM orders
UNION ALL SELECT 'customers.customer_id', COUNT(*) - COUNT(DISTINCT customer_id) FROM customers
UNION ALL SELECT 'products.product_id', COUNT(*) - COUNT(DISTINCT product_id) FROM products
UNION ALL SELECT 'sellers.seller_id', COUNT(*) - COUNT(DISTINCT seller_id) FROM sellers
UNION ALL SELECT 'order_items (order_id + order_item_id)',
       COUNT(*) - (SELECT COUNT(*) FROM (SELECT DISTINCT order_id, order_item_id FROM order_items))
       FROM order_items
UNION ALL SELECT 'reviews.review_id', COUNT(*) - COUNT(DISTINCT review_id) FROM reviews
UNION ALL SELECT 'reviews.order_id', COUNT(*) - COUNT(DISTINCT order_id) FROM reviews;