-- 09: Genişləndirilmiş data quality auditi (tarix məntiqi, boş dəyərlər, qiymət, ödəniş, rəy balı)
-- Nəticə: hər yoxlama üçün təsirlənən sətir sayı. 0 = problem yoxdur.
-- Tarixlər 'YYYY-MM-DD HH:MM:SS' mətn formatındadır, ona görə mətn müqayisəsi xronoloji işləyir.

SELECT 'A01 tarix formatı: purchase_timestamp 19 simvol deyil' AS check_name,
       COUNT(*) AS affected_rows FROM orders
       WHERE length(order_purchase_timestamp) <> 19
UNION ALL SELECT 'A02 delivered statusu, amma müştəriyə çatdırılma tarixi boş',
       COUNT(*) FROM orders WHERE order_status = 'delivered' AND order_delivered_customer_date IS NULL
UNION ALL SELECT 'A03 delivered deyil, amma müştəriyə çatdırılma tarixi var',
       COUNT(*) FROM orders WHERE order_status <> 'delivered' AND order_delivered_customer_date IS NOT NULL
UNION ALL SELECT 'A04 approved_at boş (bütün statuslar)',
       COUNT(*) FROM orders WHERE order_approved_at IS NULL
UNION ALL SELECT 'A05 approved_at < purchase_timestamp',
       COUNT(*) FROM orders WHERE order_approved_at < order_purchase_timestamp
UNION ALL SELECT 'A06 carrier tarixi < purchase_timestamp',
       COUNT(*) FROM orders WHERE order_delivered_carrier_date < order_purchase_timestamp
UNION ALL SELECT 'A07 müştəriyə çatdırılma < purchase_timestamp',
       COUNT(*) FROM orders WHERE order_delivered_customer_date < order_purchase_timestamp
UNION ALL SELECT 'A08 müştəriyə çatdırılma < carrier tarixi',
       COUNT(*) FROM orders WHERE order_delivered_customer_date < order_delivered_carrier_date
UNION ALL SELECT 'A09 estimated_delivery < purchase_timestamp',
       COUNT(*) FROM orders WHERE order_estimated_delivery_date < order_purchase_timestamp
UNION ALL SELECT 'B01 price <= 0',
       COUNT(*) FROM order_items WHERE price <= 0
UNION ALL SELECT 'B02 freight_value < 0',
       COUNT(*) FROM order_items WHERE freight_value < 0
UNION ALL SELECT 'B03 freight_value = 0 (pulsuz çatdırılma, məlumat üçün)',
       COUNT(*) FROM order_items WHERE freight_value = 0
UNION ALL SELECT 'C01 payment_value <= 0',
       COUNT(*) FROM payments WHERE payment_value <= 0
UNION ALL SELECT 'C02 payment_type = not_defined',
       COUNT(*) FROM payments WHERE payment_type = 'not_defined'
UNION ALL SELECT 'C03 payment_installments = 0',
       COUNT(*) FROM payments WHERE payment_installments = 0
UNION ALL SELECT 'C04 ödəniş sətri olmayan sifariş',
       COUNT(*) FROM orders WHERE order_id NOT IN (SELECT order_id FROM payments)
UNION ALL SELECT 'C05 ödəniş cəmi ilə (price + freight) arasında 1-dən çox fərq olan sifariş',
       COUNT(*) FROM (
         SELECT i.order_id
         FROM (SELECT order_id, SUM(price + freight_value) AS items_total FROM order_items GROUP BY order_id) AS i
         JOIN (SELECT order_id, SUM(payment_value) AS paid_total FROM payments GROUP BY order_id) AS p
           ON p.order_id = i.order_id
         WHERE ABS(p.paid_total - i.items_total) > 1)
UNION ALL SELECT 'D01 review_score 1–5 aralığından kənar',
       COUNT(*) FROM reviews WHERE review_score NOT BETWEEN 1 AND 5 OR review_score IS NULL
UNION ALL SELECT 'D02 review_answer_timestamp < review_creation_date',
       COUNT(*) FROM reviews WHERE review_answer_timestamp < review_creation_date
UNION ALL SELECT 'E01 çəki/ölçü boş olan məhsul',
       COUNT(*) FROM products WHERE product_weight_g IS NULL
UNION ALL SELECT 'E02 unikal customer_state sayı (məlumat üçün)',
       COUNT(DISTINCT customer_state) FROM customers
UNION ALL SELECT 'E03 unikal seller_state sayı (məlumat üçün)',
       COUNT(DISTINCT seller_state) FROM sellers
UNION ALL SELECT 'E04 unikal müştəri (customer_unique_id, məlumat üçün)',
       COUNT(DISTINCT customer_unique_id) FROM customers;
