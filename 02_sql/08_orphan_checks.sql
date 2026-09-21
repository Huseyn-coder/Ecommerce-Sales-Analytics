-- 08: Foreign key dəyərlərinin qarşı cədvəldə olub-olmadığını yoxlayır (orphan yoxlaması)
SELECT 'order_items.order_id -> orders' AS check_name, COUNT(*) AS orphans FROM order_items WHERE order_id NOT IN (SELECT order_id FROM orders)
UNION ALL SELECT 'order_items.product_id -> products', COUNT(*) FROM order_items WHERE product_id NOT IN (SELECT product_id FROM products)
UNION ALL SELECT 'order_items.seller_id -> sellers', COUNT(*) FROM order_items WHERE seller_id NOT IN (SELECT seller_id FROM sellers)
UNION ALL SELECT 'orders.customer_id -> customers', COUNT(*) FROM orders WHERE customer_id NOT IN (SELECT customer_id FROM customers)
UNION ALL SELECT 'payments.order_id -> orders', COUNT(*) FROM payments WHERE order_id NOT IN (SELECT order_id FROM orders)
UNION ALL SELECT 'reviews.order_id -> orders', COUNT(*) FROM reviews WHERE order_id NOT IN (SELECT order_id FROM orders)
UNION ALL SELECT 'kateqoriya: tərcüməsi olmayan', COUNT(DISTINCT product_category_name) FROM products
          WHERE product_category_name <> '' AND product_category_name NOT IN (SELECT product_category_name FROM category_translation)
UNION ALL SELECT 'kateqoriya: boş olan məhsul', COUNT(*) FROM products
          WHERE product_category_name IS NULL OR product_category_name = '';