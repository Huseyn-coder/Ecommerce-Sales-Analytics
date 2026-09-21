# Xam data

Bu qovluq xam CSV fayllarını saxlayır. **Fayllar repoda yoxdur** — datasetin lisenziyası (CC BY-NC-SA 4.0) və faylların ölçüsü səbəbindən `.gitignore` onları çıxarır.

## Datanı əldə etmək

1. Kaggle-dan yüklə: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Arxivi aç və 9 CSV faylını bu qovluğa qoy.
3. Power BI faylını açıb `RawDataPath` parametrini bu qovluğun yoluna yönəlt (sonunda `\` olmalıdır).

## Gözlənilən fayllar və sətir sayları

| Fayl | Sətir |
|---|---|
| `olist_orders_dataset.csv` | 99.441 |
| `olist_order_items_dataset.csv` | 112.650 |
| `olist_order_payments_dataset.csv` | 103.886 |
| `olist_order_reviews_dataset.csv` | 99.224 |
| `olist_customers_dataset.csv` | 99.441 |
| `olist_products_dataset.csv` | 32.951 |
| `olist_sellers_dataset.csv` | 3.095 |
| `product_category_name_translation.csv` | 71 |
| `olist_geolocation_dataset.csv` | 1.000.163 (bu versiyada istifadə olunmur) |

Sətir sayları yükləmədən sonra yoxlanmalıdır — `olist_order_reviews_dataset.csv` faylında çoxsətirli şərhlər var, ona görə Excel bu faylı səhv sayda göstərə bilər (bax `04_documentation/data_quality_report.md`).

## Qayda

Xam fayllar **heç vaxt dəyişdirilmir** (D4). Bütün təmizləmə Power Query-də aparılır; səbəb: Excel-də açıb saxlamaq zip kodların əvvəlindəki sıfırları və tarix formatını pozur.

## Lisenziya

Data mənbəyi və istifadə şərtləri: `04_documentation/license_note.txt`
