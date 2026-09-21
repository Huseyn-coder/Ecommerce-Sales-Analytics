# Power Query — M kodları

Bu qovluq hesabatın bütün data hazırlıq kodunu saxlayır: xam CSV-lərdən staging query-lərə, oradan star schema model cədvəllərinə və date table-a qədər. Hər fayl bir query-dir; faylın ilk sətrindəki `Query adı` query-nin Power BI-dakı adıdır.

Ardıcıllıq: **staging (01–08) → model cədvəlləri (09–14) → DimDate (15) → əlaqələr**.

---

## 1. Staging query-lər (01–08)

### Ardıcıllıq

| # | Fayl | Query adı | Gözlənilən sətir |
|---|---|---|---|
| 0 | `00_RawDataPath.m` | RawDataPath (parametr) | — |
| 1 | `01_stg_orders.m` | stg_orders | 99.441 |
| 2 | `02_stg_order_items.m` | stg_order_items | 112.650 |
| 3 | `03_stg_payments.m` | stg_payments | 103.886 |
| 4 | `04_stg_reviews_latest.m` | stg_reviews_latest | 98.673 |
| 5 | `05_stg_customers.m` | stg_customers | 99.441 |
| 6 | `06_stg_category_translation.m` | stg_category_translation | 71 |
| 7 | `07_stg_products.m` | stg_products | 32.951 |
| 8 | `08_stg_sellers.m` | stg_sellers | 3.095 |

`stg_category_translation` mütləq `stg_products`-dan əvvəl yaradılmalıdır.

### Hər query üçün addımlar

1. Power BI Desktop → **Home** → **Transform data** (Power Query Editor açılır).
2. **Home** → **New Source** → **Blank Query**.
3. **Home** → **Advanced Editor** → içindəkini sil → `.m` faylının məzmununu yapışdır → **Done**.
4. Sağda **Query Settings** → **Name**: cədvəldəki query adını yaz.

Parametr üçün: **Home** → **Manage Parameters** → **New** → Name: `RawDataPath`, Type: `Text`, Current Value: xam CSV-lərin olduğu `01_raw_data` qovluğunun tam yolu (sonunda `\` olmalıdır) → **OK**.

### Niyə belə yazılıb

| Texniki seçim | Səbəb |
|---|---|
| `Encoding = 65001` | Fayllar UTF-8-dir |
| `QuoteStyle = QuoteStyle.Csv` | Reviews-dəki çoxsətirli şərhlər ayrıca sətir sayılmır |
| Tip çevrilməsində `"en-US"` | Kompüterin regional ayarı `58.90`-ı səhv oxumasın, tarixlər düzgün çevrilsin |
| Boş mətn → `null` (orders) | Boş tarix xanaları xəta vermir |
| Zip kodlar `type text` | Əvvəldəki sıfırlar itmir |
| `Currency.Type` (Fixed decimal) | Pul məbləğlərində yuvarlaqlaşdırma xətası olmur |
| `RawDataPath` parametri | Qovluq dəyişsə, yalnız bir yerdə düzəldilir |

### Nəzarət rəqəmləri (yükləmədən sonra yoxlanır)

| Yoxlama | Gözlənilən |
|---|---|
| stg_order_items: price cəmi | 13.591.643,70 |
| stg_order_items: freight_value cəmi | 2.251.909,54 |
| stg_reviews_latest: review_score ortalaması | 4,0864 |
| stg_products: unikal product_category | 74 |
| stg_products: Unknown | 610 |
| stg_customers: unikal customer_unique_id | 96.096 |
| stg_payments: payment_type | Credit Card 76.795 · Boleto 19.784 · Voucher 5.775 · Debit Card 1.529 · Not Defined 3 |

Nəzarət rəqəmləri Python ilə xam CSV-lərdən eyni qaydalarla hesablanıb (2026-09-17).

---

## 2. Model cədvəlləri (09–14)

Staging (`stg_`) query-lərindən dashboard modeli üçün 3 fact və 3 dimension cədvəli qurulur. Date table növbəti bölmədədir.

| # | Fayl | Query adı | Dənəvərlik | Gözlənilən sətir |
|---|---|---|---|---|
| 9 | `09_FactSales.m` | FactSales | Sifarişdəki 1 məhsul | 112.650 |
| 10 | `10_FactOrders.m` | FactOrders | 1 sifariş | 99.441 |
| 11 | `11_FactPayments.m` | FactPayments | 1 ödəniş | 103.886 |
| 12 | `12_DimCustomer.m` | DimCustomer | 1 customer_id | 99.441 |
| 13 | `13_DimProduct.m` | DimProduct | 1 məhsul | 32.951 |
| 14 | `14_DimSeller.m` | DimSeller | 1 satıcı | 3.095 |

### Addımlar

1. Power BI → **Transform data**.
2. Hər fayl üçün: **New Source** → **Blank Query** → **Advanced Editor** → yapışdır → **Done** → adı yaz.
3. 8 `stg_` query-nin hər birinə sağ klik → **Enable load** işarəsini götür (query-lər kursivlə görünəcək). Onlar işləməyə davam edir, sadəcə modelə ayrıca yüklənmir.
4. **Close & Apply** → **Ctrl + S**.
5. **File** → **Options and settings** → **Options** → **CURRENT FILE / Data Load** → **Auto date/time** işarəsini götür → **OK**.

### Niyə 3 fact cədvəli

| Cədvəl | Səbəb |
|---|---|
| FactSales | Satış məhsul səviyyəsindədir; kateqoriya və satıcı yalnız burada var |
| FactOrders | Sifariş sayı, çatdırılma və rəy sifariş səviyyəsindədir; FactSales-də sayılsa, çox məhsullu sifarişlər təkrar sayılar |
| FactPayments | Bir sifarişin bir neçə ödənişi var; FactSales ilə birləşdirilsə sətirlər çoxalar (D8) |

Üç fact cədvəli ümumi dimension-lar (DimCustomer, Date) üzərindən filtrlənir — bu, "multi-fact star schema"-dır.

### Nəzarət rəqəmləri (xam CSV-dən Python ilə hesablanıb)

| Göstərici | Dəyər |
|---|---|
| Çatdırılmış sifariş (is_delivered) | 96.470 |
| Orta çatdırılma müddəti | 12,56 gün (median 10,22) |
| Gecikmiş sifariş | 6.534 (6,77%) |
| Net Sales-i olan sifariş | 98.199 |
| Net AOV | 137,42 |
| Gross AOV | 137,75 (98.666 sifariş) |
| Real müştəri | 96.096 |
| 1-dən çox sifarişi olan müştəri | 2.997 (3,12%, bütün statuslar) |

Bu rəqəmlər insight deyil, DAX yoxlaması üçündür; bütün dövr üzrədir. Təfsir `04_documentation/insights.md`-dədir.

---

## 3. DimDate və əlaqələr (star schema)

### DimDate
`15_DimDate.m` → query adı `DimDate`, 1.096 sətir (2016-01-01 – 2018-12-31), 9 sütun.
Power BI-da **Mark as date table** edilib, açar sütun: `Date`.
`is_trend_period` sütunu 2017-01 – 2018-08 aralığını işarələyir (D16).

### Əlaqələr (7 ədəd)

| # | From (çox tərəf) | To (bir tərəf) | Növ | Status |
|---|---|---|---|---|
| 1 | FactOrders[order_purchase_date] | DimDate[Date] | çox : 1, tək istiqamət | Aktiv |
| 2 | FactOrders[order_delivered_date] | DimDate[Date] | çox : 1, tək istiqamət | **Deaktiv** |
| 3 | DimCustomer[customer_id] | FactOrders[customer_id] | 1 : 1 | Aktiv |
| 4 | FactSales[order_id] | FactOrders[order_id] | çox : 1 | Aktiv |
| 5 | FactPayments[order_id] | FactOrders[order_id] | çox : 1 | Aktiv |
| 6 | FactSales[product_id] | DimProduct[product_id] | çox : 1 | Aktiv |
| 7 | FactSales[seller_id] | DimSeller[seller_id] | çox : 1 | Aktiv |

### Model məntiqi

`FactOrders` sifariş başlığıdır (order header): tarix və müştəri filtrləri ona bağlanır, oradan `FactSales` və `FactPayments`-ə ötürülür. Bu, order header → order line modelidir və sifariş səviyyəli göstəricilərin (sifariş sayı, çatdırılma, rəy) məhsul sətirləri səbəbindən təkrar sayılmasının qarşısını alır (D8, D17).

`DimProduct` və `DimSeller` yalnız `FactSales`-ə bağlanır, çünki kateqoriya və satıcı məhsul sətri səviyyəsindədir.

İkinci tarix əlaqəsi (order_delivered_date → DimDate) deaktiv saxlanılıb: bu versiyada bütün analiz alış tarixinə görədir. Çatdırılma tarixi üzrə kəsim lazım olsa, DAX-da `USERELATIONSHIP` ilə aktivləşdirilə bilər.
