# Data Quality Report

**Tarix:** 2026-09-17 · **Mənbə:** Olist CSV-ləri (`01_raw_data`) və `02_sql/olist.db` · **Sorğular:** `02_sql/01`–`09`

## Xülasə

Data analiz üçün yararlıdır. Kritik bloklayan problem yoxdur: primary key-lər unikaldır, foreign key-lərdə orphan yoxdur, qiymətlər müsbətdir, tarix formatı düzgündür. Düzəliş və ya qərar tələb edən 12 məsələ var, hamısı `decisions_log.md`-də həll yolu ilə qeyd olunub.

## 1. Import bütövlüyü (CSV ↔ SQLite)

| Cədvəl | CSV sətir | SQLite sətir | Sütunlar uyğun | Strukturu pozulmuş sətir | Tam təkrar sətir |
|---|---|---|---|---|---|
| orders | 99.441 | 99.441 | ✅ | 0 | 0 |
| order_items | 112.650 | 112.650 | ✅ | 0 | 0 |
| payments | 103.886 | 103.886 | ✅ | 0 | 0 |
| reviews | 99.224 | 99.224 | ✅ | 0 | 0 |
| customers | 99.441 | 99.441 | ✅ | 0 | 0 |
| products | 32.951 | 32.951 | ✅ | 0 | 0 |
| sellers | 3.095 | 3.095 | ✅ | 0 | 0 |
| category_translation | 71 | 71 | ✅ | 0 | 0 |
| geolocation | 1.000.163 | import edilməyib | — | 0 | **261.831** |

CSV-lər proper CSV parser ilə oxunub (dırnaq içindəki yeni sətirlər nəzərə alınıb). Excel-in reviews üçün göstərdiyi 103.388 sətir səhvdir.

**Import yan təsirləri:**

| Məsələ | Həcm | Təsir |
|---|---|---|
| Zip kodlar SQLite-də INTEGER | 23.995 müştəri, 1.027 satıcı zip-inin əvvəlindəki 0 itib | Yalnız SQLite-də; Power BI-da Text olacaq |
| "Trim fields" seçimi | 27 mesaj, 2 başlıq (yalnız boşluq) NULL oldu; 9.424 mesajın kənar boşluqları silindi | Şərh mətni analiz olunmur, təsir yoxdur |
| `product_category_name_translation.csv` UTF-8 BOM ilə başlayır | 1 fayl | Power Query-də ilk sütun adı yoxlanmalıdır |

## 2. Boş dəyərlər (CSV)

| Cədvəl.sütun | Boş | Səbəb / qərar |
|---|---|---|
| orders.order_approved_at | 160 (141 canceled, 5 created, 14 delivered) | Saxlanılır; approved tarixi analizdə istifadə olunmur |
| orders.order_delivered_carrier_date | 1.783 | Çatdırılmamış sifarişlər; saxlanılır |
| orders.order_delivered_customer_date | 2.965 | Çatdırılmamış sifarişlər; saxlanılır |
| reviews.review_comment_title | 87.656 | Şərh məcburi deyil |
| reviews.review_comment_message | 58.247 | Şərh məcburi deyil |
| products.product_category_name | 610 | `Unknown` kimi işarələnəcək |
| products.name/description/photos | 610 | Kateqoriyası boş olan eyni məhsullar; istifadə olunmur |
| products.weight/length/height/width | 2 | İstifadə olunmur |

## 3. Açar və əlaqə yoxlamaları

| Yoxlama | Nəticə |
|---|---|
| orders, customers, products, sellers primary key təkrarı | 0 |
| order_items (order_id + order_item_id) təkrarı | 0 |
| reviews.review_id təkrarı | 814 artıq sətir (789 rəy bir neçə sifarişə bağlı) |
| reviews.order_id təkrarı | 551 artıq sətir (547 sifariş), 202 sifarişdə ballar fərqli |
| Rəyi olmayan sifariş | 768 |
| Məhsul sətri olmayan sifariş | 775 (603 unavailable, 164 canceled, 5 created, 2 invoiced, 1 shipped) |
| Foreign key orphan (6 əlaqə) | 0 |
| Tərcüməsi olmayan kateqoriya | 2 |

## 4. Məntiqi yoxlamalar (SQL 09)

| Kod | Yoxlama | Sətir | Şərh |
|---|---|---|---|
| A01 | purchase_timestamp formatı səhv | 0 | ✅ |
| A02 | delivered, amma çatdırılma tarixi boş | 8 | Çatdırılma metrikalarından avtomatik çıxır |
| A03 | delivered deyil, amma çatdırılma tarixi var | 6 | Hamısı canceled; status əsas götürülür |
| A04 | approved_at boş | 160 | Bax bölmə 2 |
| A05 | approved_at < purchase | 0 | ✅ |
| A06 | carrier tarixi < purchase | 166 | Maksimum fərq 4.109 saat (≈171 gün); data xətası. Carrier mərhələsi ölçülmür |
| A07 | müştəriyə çatdırılma < purchase | 0 | ✅ Əsas çatdırılma metrikası etibarlıdır |
| A08 | müştəriyə çatdırılma < carrier tarixi | 23 | Carrier mərhələsi ölçülmür |
| A09 | estimated < purchase | 0 | ✅ |
| B01 | price ≤ 0 | 0 | ✅ |
| B02 | freight < 0 | 0 | ✅ |
| B03 | freight = 0 | 383 | Pulsuz çatdırılma; məlumat üçün |
| C01 | payment_value ≤ 0 | 9 (6 voucher, 3 not_defined) | Saxlanılır |
| C02 | payment_type = not_defined | 3 | `Not defined` kimi göstəriləcək |
| C03 | installments = 0 | 2 | Saxlanılır |
| C04 | ödəniş sətri olmayan sifariş | 1 (delivered) | Satış price-dan hesablandığı üçün təsir yoxdur |
| C05 | ödəniş cəmi ≠ price + freight (fərq > 1) | 249 (232-sində ödəniş çox) | Fərziyyə: taksit faizi və ya voucher; satış üçün payment_value istifadə olunmur |
| D01 | review_score 1–5 kənar | 0 | ✅ |
| D02 | cavab tarixi < rəy tarixi | 0 | ✅ |
| E01 | çəki/ölçü boş məhsul | 2 | İstifadə olunmur |
| E02 | unikal customer_state | 27 | Məlumat |
| E03 | unikal seller_state | 23 | Məlumat |
| E04 | unikal müştəri (customer_unique_id) | 96.096 | Nəzarət rəqəmi |

## 5. Tarix aralığı və tamlıq

Sifarişlər 2016-09-04 – 2018-10-17 aralığındadır. 2016-11 ayında sifariş yoxdur; 2016-09 (4), 2016-12 (1), 2018-09 (16), 2018-10 (4) natamamdır. Trend analizi 2017-01 – 2018-08 dövrü üzrə aparılır.
