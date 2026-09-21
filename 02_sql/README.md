# SQL — data understanding və data quality yoxlamaları

**Mühit:** SQLite (DB Browser for SQLite 3.13.1). Baza `olist.db` geolocation xaric 8 CSV-dən import edilib.
**Qeyd:** `olist.db` GitHub-a yüklənmir (xam data + 67 MB). Bazanı yenidən qurmaq üçün: DB Browser → File → Import → Table from CSV file, ayırıcı `,`, dırnaq `"`, UTF-8, cədvəl adları aşağıdakı kimi.

| Cədvəl | CSV faylı |
|---|---|
| orders | olist_orders_dataset.csv |
| order_items | olist_order_items_dataset.csv |
| payments | olist_order_payments_dataset.csv |
| reviews | olist_order_reviews_dataset.csv |
| customers | olist_customers_dataset.csv |
| products | olist_products_dataset.csv |
| sellers | olist_sellers_dataset.csv |
| category_translation | product_category_name_translation.csv |

## Sorğular

| # | Fayl | Məqsəd | Əsas nəticə | Nəticə faylı |
|---|---|---|---|---|
| 01 | `01_row_counts.sql` | Sətir sayları | orders 99.441; order_items 112.650; payments 103.886; reviews 99.224; customers 99.441; products 32.951; sellers 3.095; category_translation 71 | `results/01_row_counts.csv` |
| 02 | `02_duplicate_checks.sql` | Primary key təkrarları | 5 cədvəldə 0; reviews.review_id 814, reviews.order_id 551 artıq sətir | `results/02_duplicate_checks.csv` |
| 03 | `03_review_duplicates.sql` | Reviews təkrarlarının növü | 789 rəy çox sifarişə bağlı; 547 sifarişin çox rəyi; 202-sində bal fərqli; 768 sifarişin rəyi yoxdur | `results/03_review_duplicates.csv` |
| 04 | `04_order_status.sql` | Status paylanması, tarix aralığı | delivered 96.478 (97,02%); aralıq 2016-09-04 – 2018-10-17 | `results/04_order_status.csv` |
| 05 | `05_monthly_orders.sql` | Aylıq sifarişlər | Natamam aylar: 2016-09, 2016-11 (yox), 2016-12, 2018-09, 2018-10 | `results/05_monthly_orders.csv` |
| 06 | `06_gross_net_sales.sql` | Satış nəzarət rəqəmləri | Gross 13.591.643,70; Net 13.494.400,74; freight 2.251.909,54 | `results/06_gross_net_sales.csv` |
| 07 | `07_orders_without_items.sql` | Məhsul sətri olmayan sifarişlər (LEFT JOIN) | 775 (603 unavailable, 164 canceled) | `results/07_orders_without_items.csv` |
| 08 | `08_orphan_checks.sql` | Foreign key orphan yoxlaması | 6 əlaqədə 0 orphan; 2 kateqoriyanın tərcüməsi yox; 610 məhsulun kateqoriyası boş | `results/08_orphan_checks.csv` |
| 09 | `09_data_quality_audit.sql` | Tarix məntiqi, qiymət, ödəniş, rəy yoxlamaları (23 yoxlama) | Bax `04_documentation/data_quality_report.md` | `results/09_data_quality_audit.csv` |

Bütün sorğular 2026-09-17 tarixində `olist.db`-nin surətində yenidən icra olunub və eyni nəticəni verib.
