# Data Dictionary

**Mənbə:** Brazilian E-Commerce Public Dataset by Olist (Kaggle), CC BY-NC-SA 4.0 · **Yaradılıb:** 2026-09-17

"Power BI tipi" sütunu Power Query-də təyin olunacaq tipdir. Nümunə dəyərlər xam CSV-dəki ilk dolu dəyərdir; ID-lər qısaldılıb.

## orders

Fayl: `olist_orders_dataset.csv` · Sətir: 99.441 · Hər sətir 1 sifarişdir. PK: order_id

| Sütun | Power BI tipi | Təsvir | Boş | Unikal dəyər | Nümunə |
| --- | --- | --- | --- | --- | --- |
| `order_id` | Text | Sifariş ID (PK) | 0 | 99.441 | `e481f51cbdc5…` |
| `customer_id` | Text | Sifarişə məxsus müştəri ID (FK → customers) | 0 | 99.441 | `9ef432eb6251…` |
| `order_status` | Text | Sifariş statusu | 0 | 8 | `delivered` |
| `order_purchase_timestamp` | Date/Time | Alış vaxtı; əsas tarix sütunu | 0 | 98.875 | `2017-10-02 10:56:33` |
| `order_approved_at` | Date/Time | Ödənişin təsdiq vaxtı | 160 | 90.733 | `2017-10-02 11:07:15` |
| `order_delivered_carrier_date` | Date/Time | Daşıyıcıya təhvil vaxtı; anomaliyalar var. v1-də istifadə olunmur | 1.783 | 81.018 | `2017-10-04 19:55:00` |
| `order_delivered_customer_date` | Date/Time | Müştəriyə çatdırılma vaxtı | 2.965 | 95.664 | `2017-10-10 21:25:13` |
| `order_estimated_delivery_date` | Date | Təxmini çatdırılma tarixi; gecikmə bununla ölçülür | 0 | 459 | `2017-10-18 00:00:00` |

Status dəyərləri: delivered (96.478), shipped (1.107), canceled (625), unavailable (609), invoiced (314), processing (301), created (5), approved (2)

## order_items

Fayl: `olist_order_items_dataset.csv` · Sətir: 112.650 · Hər sətir sifarişdəki 1 məhsul vahididir. PK: order_id + order_item_id. Satış fact cədvəli

| Sütun | Power BI tipi | Təsvir | Boş | Unikal dəyər | Nümunə |
| --- | --- | --- | --- | --- | --- |
| `order_id` | Text | FK → orders | 0 | 98.666 | `00010242fe8c…` |
| `order_item_id` | Whole number | Sifariş içində sıra nömrəsi | 0 | 21 | `1` |
| `product_id` | Text | FK → products | 0 | 32.951 | `4244733e06e7…` |
| `seller_id` | Text | FK → sellers | 0 | 3.095 | `48436dade18a…` |
| `shipping_limit_date` | Date/Time | Satıcının daşıyıcıya təhvil son tarixi | 0 | 93.318 | `2017-09-19 09:45:35` |
| `price` | Decimal (BRL) | Məhsul qiyməti; satış bununla hesablanır | 0 | 5.968 | `58.90` |
| `freight_value` | Decimal (BRL) | Bu məhsul üçün çatdırılma haqqı | 0 | 6.999 | `13.29` |

## payments

Fayl: `olist_order_payments_dataset.csv` · Sətir: 103.886 · Hər sətir sifarişin 1 ödənişidir. PK: order_id + payment_sequential

| Sütun | Power BI tipi | Təsvir | Boş | Unikal dəyər | Nümunə |
| --- | --- | --- | --- | --- | --- |
| `order_id` | Text | FK → orders | 0 | 99.440 | `b81ef226f3fe…` |
| `payment_sequential` | Whole number | Ödənişin sıra nömrəsi | 0 | 29 | `1` |
| `payment_type` | Text | Ödəniş üsulu | 0 | 5 | `credit_card` |
| `payment_installments` | Whole number | Taksit sayı | 0 | 24 | `8` |
| `payment_value` | Decimal (BRL) | Ödəniş məbləği; satış üçün istifadə olunmur | 0 | 29.077 | `99.33` |

Ödəniş üsulları: credit_card (76.795), boleto (19.784), voucher (5.775), debit_card (1.529), not_defined (3)

## reviews

Fayl: `olist_order_reviews_dataset.csv` · Sətir: 99.224 · Hər sətir 1 rəydir; bir sifarişin bir neçə rəyi ola bilər. Power BI-da sifarişə 1 rəy saxlanılır

| Sütun | Power BI tipi | Təsvir | Boş | Unikal dəyər | Nümunə |
| --- | --- | --- | --- | --- | --- |
| `review_id` | Text | Rəy ID (unikal deyil) | 0 | 98.410 | `7bc2406110b9…` |
| `order_id` | Text | FK → orders | 0 | 98.673 | `73fc7af87114…` |
| `review_score` | Whole number | Bal. 1–5 | 0 | 5 | `4` |
| `review_comment_title` | Text | Şərh başlığı (Portuqalca). v1-də istifadə olunmur | 87.656 | 4.527 | `recomendo` |
| `review_comment_message` | Text | Şərh mətni (Portuqalca). v1-də istifadə olunmur | 58.247 | 36.159 | `Recebi bem a…` |
| `review_creation_date` | Date | Rəy sorğusunun göndərilmə tarixi | 0 | 636 | `2018-01-18 00:00:00` |
| `review_answer_timestamp` | Date/Time | Rəyin cavablandırılma vaxtı; ən son rəyi seçmək üçün | 0 | 98.248 | `2018-01-18 21:46:59` |

## customers

Fayl: `olist_customers_dataset.csv` · Sətir: 99.441 · Hər sətir 1 sifarişin müştəri qeydidir. PK: customer_id

| Sütun | Power BI tipi | Təsvir | Boş | Unikal dəyər | Nümunə |
| --- | --- | --- | --- | --- | --- |
| `customer_id` | Text | Sifarişə məxsus ID (PK) | 0 | 99.441 | `06b8999e2fba…` |
| `customer_unique_id` | Text | Real müştəri ID; təkrar alış bununla ölçülür | 0 | 96.096 | `861eff4711a5…` |
| `customer_zip_code_prefix` | Text | Zip kodun ilk 5 rəqəmi; Text saxlanılır | 0 | 14.994 | `14409` |
| `customer_city` | Text | Şəhər | 0 | 4.119 | `franca` |
| `customer_state` | Text | Ştat kodu | 0 | 27 | `SP` |

## products

Fayl: `olist_products_dataset.csv` · Sətir: 32.951 · Hər sətir 1 məhsuldur. PK: product_id

| Sütun | Power BI tipi | Təsvir | Boş | Unikal dəyər | Nümunə |
| --- | --- | --- | --- | --- | --- |
| `product_id` | Text | Məhsul ID (PK) | 0 | 32.951 | `1e9e8ef04dbc…` |
| `product_category_name` | Text | Kateqoriya (Portuqalca); 610 boş → Unknown | 610 | 73 | `perfumaria` |
| `product_name_lenght` | Whole number | Məhsul adının uzunluğu (mənbədə səhv yazılıb: lenght) | 610 | 66 | `40` |
| `product_description_lenght` | Whole number | Təsvirin uzunluğu | 610 | 2.960 | `287` |
| `product_photos_qty` | Whole number | Foto sayı | 610 | 19 | `1` |
| `product_weight_g` | Whole number | Çəki. qram | 2 | 2.204 | `225` |
| `product_length_cm` | Whole number | Uzunluq. sm | 2 | 99 | `16` |
| `product_height_cm` | Whole number | Hündürlük. sm | 2 | 102 | `10` |
| `product_width_cm` | Whole number | En. sm | 2 | 95 | `14` |

## sellers

Fayl: `olist_sellers_dataset.csv` · Sətir: 3.095 · Hər sətir 1 satıcıdır. PK: seller_id

| Sütun | Power BI tipi | Təsvir | Boş | Unikal dəyər | Nümunə |
| --- | --- | --- | --- | --- | --- |
| `seller_id` | Text | Satıcı ID (PK) | 0 | 3.095 | `3442f8959a84…` |
| `seller_zip_code_prefix` | Text | Zip kodun ilk 5 rəqəmi | 0 | 2.246 | `13023` |
| `seller_city` | Text | Şəhər | 0 | 611 | `campinas` |
| `seller_state` | Text | Ştat kodu | 0 | 23 | `SP` |

## category_translation

Fayl: `product_category_name_translation.csv` · Sətir: 71 · Kateqoriya tərcüməsi. PK: product_category_name. Fayl UTF-8 BOM ilə başlayır

| Sütun | Power BI tipi | Təsvir | Boş | Unikal dəyər | Nümunə |
| --- | --- | --- | --- | --- | --- |
| `product_category_name` | Text | Portuqalca ad (PK) | 0 | 71 | `beleza_saude` |
| `product_category_name_english` | Text | İngiliscə ad | 0 | 71 | `health_beauty` |

## geolocation

Fayl: `olist_geolocation_dataset.csv` · Sətir: 1.000.163 (261.831 tam təkrar) · v1-də istifadə olunmur.
