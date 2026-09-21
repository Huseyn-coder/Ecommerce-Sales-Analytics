# Power BI faylı

`olist_sales_dashboard.pbix` — E-commerce Sales & Customer Analytics Dashboard hesabatı (≈31 MB).

## Səhifələr

| # | Səhifə | Nə göstərir |
|---|---|---|
| 1 | `Yoxlama` | **Gizlidir.** Daxili QA səhifəsi |
| 2 | `Ümumi baxış` | KPI-lar, aylıq trend (keçən illə müqayisə), ən çox satan kateqoriya və ştatlar |
| 3 | `Kateqoriyalar` | Kateqoriya üzrə satış, rəy balı, çatdırılma müddəti |
| 4 | `Müştəri və çatdırılma` | Təkrar alış, gecikmə faizi, ştat üzrə kəsim, ödəniş üsulları |
| 5 | `Dashboard` | Bir ekranda ümumi mənzərə və əsas tapıntılar paneli |

Bütün səhifələr `is_trend_period` (2017-01 – 2018-08) dövrü üzrə işləyir.

## Qovluq quruluşu

| Fayl | Məzmun |
|---|---|
| `olist_sales_dashboard.pbix` | Power BI hesabatı |
| `power_query/` | Məlumatların emalı üçün M kodu (staging, model, DimDate) |
| `dax/measures.dax` | 21 DAX measure — satış, sifarişlər, müştəri, çatdırılma metrikaları |
| `theme/olist_dark_theme.json` | Hesabatda istifadə olunan rəng sxemi |
| `theme/olist_corporate_theme.json` | İlkin açıq rəng sxemi — istifadə olunmur, müqayisə üçün saxlanılıb |

## Texniki qeydlər

- **Data mənbəyi:** `RawDataPath` parametri ilə idarə olunur. Xam CSV-lər bu repoda yoxdur — lisenziya və yüklənmə qaydaları üçün [kök README](../README.md)-ə bax.
- **Star schema:** FactSales, FactOrders, FactPayments; DimCustomer, DimProduct, DimSeller, DimDate.
