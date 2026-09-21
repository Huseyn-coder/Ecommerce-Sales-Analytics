# Insights və biznes tövsiyələri

**Dövr:** 2017-01 – 2018-08 (20 tam ay, `is_trend_period` filtri) · **Mənbə:** Olist e-ticarət datası, Power BI hesabatı
**Qayda:** burada yalnız dashboard-da görünən real rəqəmlər var. Səbəb-nəticə iddiası edilmir; əlaqələr "əlaqə" kimi təqdim olunur.

## 1. Ümumi mənzərə (`Ümumi baxış` səhifəsi)

Dövr üzrə net satış **13,45 mln BRL**, satışı olan sifariş sayı **97.905**, unikal müştəri **95.774**, orta sifariş dəyəri **137,37 BRL**.

Aylıq trend 2017-01-dən 2017-11-ə qədər sürətlə artır (120 min → 1,00 mln BRL), sonra 2018-01 – 2018-08 aralığında 838–994 min BRL arasında dalğalanır, yüksələn meyl yoxdur. Yəni şirkət böyümə mərhələsindən sabitləşmə mərhələsinə keçib.

Qeyd: 2017-11 ayı (1,00 mln BRL) tək aylıq zirvədir və Braziliyada Black Friday dövrünə düşür — plato səviyyəsi təxminən 900 min BRL-dir, zirvə deyil.

**Tövsiyə:** böyümə yeni müştəri cəlbindən gəlirdisə, plato dövründə diqqət mövcud müştərinin təkrar alışına yönəlməlidir (bax bölmə 3).

## 2. Kateqoriyalar

Top 10 kateqoriya bütün satışın böyük hissəsini təşkil edir; lider kateqoriyalar Health Beauty, Watches Gifts, Bed Bath Table, Sports Leisure, Computers Accessories.

Kateqoriya cədvəlindəki ikinci qat daha maraqlıdır — satış həcmi ilə müştəri məmnuniyyəti üst-üstə düşmür:

| Kateqoriya | Satış | Rəy balı | Çatdırılma (gün) |
|---|---|---|---|
| Bed Bath Table | 1.035.485 | 3,97 | 12,99 |
| Computers Accessories | 902.923 | 4,03 | 13,16 |
| Auto | 585.177 | 4,09 | 12,30 |
| Books General Interest | 45.503 | 4,46 | 11,53 |
| Arts And Craftmanship | 1.814 | 4,17 | 5,80 |

Ən böyük beş kateqoriyanın üçündə (Watches Gifts 4,07, Computers Accessories 4,03, Bed Bath Table 3,97) rəy balı orta göstəricidən (4,09) aşağıdır; Health Beauty (4,18) və Sports Leisure (4,17) isə ortadan yuxarıdır. Kiçik həcmli kateqoriyalarda həm çatdırılma sürətlidir, həm bal yüksəkdir.

**Tövsiyə:** Bed Bath Table və Computers Accessories üzrə rəy mətnləri araşdırılmalıdır — hər ikisi ilk beş kateqoriyadadır (Bed Bath Table sifariş sayına görə birincidir) və məmnuniyyəti aşağı çəkir. Həcmi böyük kateqoriyada balın 0,1 artması ümumi bala kiçik kateqoriyadan daha çox təsir edir.

## 3. Müştəri davranışı

Müştərilərin cəmi **3,11%-i** birdən çox sifariş verib (hesabatdakı dövr üzrə; bütün dövr üzrə 3,12%). Bu, e-ticarət üçün çox aşağıdır.

Qeyd: Olist marketplace-dir, müştəri satıcı ilə deyil, platforma ilə əlaqə qurur; buna görə təkrar alış təbii olaraq aşağı ola bilər. Amma 3,11% yenə də böyümənin demək olar ki, tamamilə yeni müştəri cəlbindən asılı olduğunu göstərir.

**Tövsiyə:** yeni müştəri cəlbinin maya dəyəri artarsa, gəlir də dayanacaq. İlk alışdan sonra 30–60 gün ərzində təkrar alışı hədəfləyən kampaniya (e-mail, endirim kuponu) sınaqdan keçirilməlidir; ölçü göstəricisi Repeat Customer Rate-dir.

## 4. Çatdırılma və region

Orta çatdırılma **12,5 gün**, sifarişlərin **6,79%-i** vəd olunan tarixdən gec çatdırılıb.

Amma ortalama regional fərqi gizlədir:

| Ştat | Satış | Müştəri | Gecikmə % | Çatdırılma (gün) |
|---|---|---|---|---|
| MG | 1.568.856 | 11.222 | 4,59% | 12,0 |
| RJ | 1.802.436 | 12.330 | 12,14% | 15,3 |
| PA | 177.734 | 945 | 11,25% | 23,8 |
| AL | 80.232 | 399 | 21,46% | 24,5 |
| RO | 46.032 | 240 | 2,88% | 19,4 |

İki ayrı problem görünür:
1. **RJ** — həcmcə ikinci ştat, gecikmə 12,14%, yəni ümumi ortadan təxminən iki dəfə çoxdur. Həcm böyük olduğu üçün mütləq sayda ən çox gecikmiş sifariş buradadır.
2. **Uzaq şimal/şimal-şərq ştatları (PA, AL)** — çatdırılma 24 günə yaxındır, gecikmə 11–21%.

Diqqət: RO ştatında çatdırılma 19,4 gün olsa da gecikmə cəmi 2,88%-dir. Yəni gecikmə uzun çatdırılmanın özündən deyil, **vədin real müddətə uyğun olmamasından** asılıdır: uzaq regionlarda müddət realdır, RJ-də isə vəd real deyil.

**Tövsiyə:**
- RJ üzrə çatdırılma proqnozu (estimated delivery date) yenidən hesablanmalıdır — vəd real müddətə uyğunlaşdırılsa, gecikmə faizi düzəlir.
- PA, AL kimi uzaq ştatlarda logistika tərəfdaşı və ya anbar yerləşməsi araşdırılmalıdır.

## 5. Gecikmə və məmnuniyyət

Gecikmə faizi yüksək olan ştatlarda rəy balı aşağı meyllidir: ən azı 100 çatdırılmış sifarişi olan 24 ştat üzrə gecikmə faizi ilə orta rəy balı arasında korrelyasiya **r = −0,89**-dur. Bu **əlaqədir, səbəb deyil** — datada müştərinin niyə aşağı bal verdiyi yazılmır.

**Tövsiyə:** gecikmiş sifarişlər üzrə rəy balı ayrıca ölçülməli (v2 metrikası) və çatdırılma layihələrinin nəticəsi bu göstərici ilə yoxlanmalıdır.

## Datanın cavab vermədiyi suallar

Aşağıdakılar bu datasetdə yoxdur və dashboard-da qəsdən göstərilmir:

- **Mənfəət və marja** — məhsulun maya dəyəri yoxdur.
- **Endirim və kampaniyanın təsiri** — endirim sütunu yoxdur.
- **Konkret məhsul adları** — yalnız kateqoriya var.
- **Müştəri demoqrafiyası və marketinq kanalı** — datada yoxdur.

Ayrıca hesabatda nəzərə alınmış məhdudiyyətlər: trend 2017-01 – 2018-08 dövrü üzrədir (natamam aylar çıxarılıb); satış = məhsul qiyməti (çatdırılma haqqı daxil deyil); 775 sifarişin məhsul sətri yoxdur və AOV-yə daxil edilmir; 610 məhsulun kateqoriyası boşdur (`Unknown`); carrier mərhələsinin tarixlərində 166 məntiqsiz qeyd olduğu üçün yalnız alış → müştəri müddəti ölçülür.
