# Business Questions

Layihənin cavablandırdığı biznes sualları mövcud sütunlara əsasən seçilib. Trend və müqayisə dövrü: 2017-01 – 2018-08. Kök `README.md` bunların səkkiz başlıq sualını göstərir; aşağıdakı cədvəl tam siyahıdır.

| # | Sual | Data (cədvəl.sütun) | Səhifə | Versiya |
|---|---|---|---|---|
| 1 | Gross və Net Sales nə qədərdir, ləğv olunmuş satışın payı nədir? | order_items.price, orders.order_status | Ümumi baxış | v1 |
| 2 | Satış və sifariş sayı aylar üzrə necə dəyişir? | orders.order_purchase_timestamp, order_items.price | Ümumi baxış | v1 |
| 3 | 2018 yanvar–avqust 2017-nin eyni dövrünə görə neçə faiz dəyişib (YoY)? | orders.order_purchase_timestamp, order_items.price | Ümumi baxış | v1 |
| 4 | Orta sifariş dəyəri (AOV) nə qədərdir və zamanla dəyişirmi? | order_items.price, order_items.order_id | Ümumi baxış | v1 |
| 5 | Hansı kateqoriyalar ən çox satış gətirir, hansılar ən zəifdir? | products.product_category_name, category_translation, order_items.price | Kateqoriyalar | v1 |
| 6 | Unikal müştərilərin neçə faizi təkrar alış edib? | customers.customer_unique_id, orders.order_id | Müştəri və çatdırılma | v1 |
| 7 | Hansı ştatlar ən çox satış və müştəri gətirir? | customers.customer_state, order_items.price | Müştəri və çatdırılma | v1 |
| 8 | Ödəniş üsulu və taksit sayı sifariş dəyəri ilə necə əlaqəlidir? | payments.payment_type, payment_installments, payment_value | Müştəri və çatdırılma | v1 |
| 9 | Orta çatdırılma müddəti neçə gündür, gecikmiş sifarişlərin payı nədir? | orders.order_purchase_timestamp, order_delivered_customer_date, order_estimated_delivery_date | Müştəri və çatdırılma | v1 |
| 10 | Hansı ştatlarda gecikmə daha çoxdur? | customers.customer_state, orders tarixləri | Müştəri və çatdırılma | v1 |
| 11 | Gecikmə ilə rəy balı arasında əlaqə varmı? | reviews.review_score, orders tarixləri, customers.customer_state | Müştəri və çatdırılma | v1 — **ştat səviyyəsində** (24 ştat üzrə r = −0,89) |
| 12 | Gecikmiş **sifarişlərin** rəy balı vaxtında çatdırılanlardan fərqlənirmi? | reviews.review_score (sifarişə 1 rəy), orders tarixləri | — | v2 |
| 13 | Satışın 80%-i neçə kateqoriyadan gəlir (Pareto)? | products, order_items.price | — | v2 |
| 14 | Çatdırılma haqqının satışa nisbəti kateqoriyaya görə fərqlənirmi? | order_items.freight_value, price, products | — | v2 |

**11 və 12 arasındakı fərq vacibdir.** 11-ci sual ştat səviyyəsində ölçülüb — bu, ekoloji korrelyasiyadır və ayrı-ayrı sifarişlərə şamil edilə bilməz. Sifariş səviyyəsində müqayisə (12) v2-yə saxlanılıb.

**Datanın cavab vermədiyi suallar:** mənfəət və marja (cost sütunu yoxdur), endirimin təsiri (endirim sütunu yoxdur), konkret məhsul adları, müştəri demoqrafiyası, marketinq kanalı.

**Qayda:** 8 və 11-ci sualların nəticəsi əlaqə kimi təqdim olunur, səbəb kimi yox.
