-- 03: Reviews cədvəlində təkrar rəylərin növünü və rəyi olmayan sifarişləri yoxlayır
SELECT
  (SELECT COUNT(*) FROM (SELECT review_id FROM reviews GROUP BY review_id HAVING COUNT(DISTINCT order_id) > 1)) AS reviews_linked_to_many_orders,
  (SELECT COUNT(*) FROM (SELECT order_id FROM reviews GROUP BY order_id HAVING COUNT(*) > 1)) AS orders_with_many_reviews,
  (SELECT COUNT(*) FROM (SELECT order_id FROM reviews GROUP BY order_id HAVING COUNT(DISTINCT review_score) > 1)) AS orders_with_different_scores,
  (SELECT COUNT(*) FROM orders WHERE order_id NOT IN (SELECT order_id FROM reviews)) AS orders_without_review;