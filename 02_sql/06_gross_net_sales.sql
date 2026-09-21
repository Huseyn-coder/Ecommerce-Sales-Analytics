-- 06: Gross Sales, Net Sales və ləğv olunmuş satış (məhsul qiyməti üzrə); çatdırılma haqqı ayrıca
SELECT
  ROUND(SUM(oi.price), 2) AS gross_sales,
  ROUND(SUM(CASE WHEN o.order_status NOT IN ('canceled', 'unavailable') THEN oi.price ELSE 0 END), 2) AS net_sales,
  ROUND(SUM(CASE WHEN o.order_status IN ('canceled', 'unavailable') THEN oi.price ELSE 0 END), 2) AS canceled_unavailable_sales,
  ROUND(SUM(oi.freight_value), 2) AS total_freight
FROM order_items AS oi
JOIN orders AS o ON o.order_id = oi.order_id;