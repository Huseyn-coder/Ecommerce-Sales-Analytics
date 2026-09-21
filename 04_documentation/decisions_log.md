# Decisions Log

Hər qərar: nə edildi və niyə.

| # | Tarix | Qərar | Səbəb |
|---|---|---|---|
| D1 | 2026-09-17 | Dataset: Olist | Çatdırılma, review, ödəniş və region datası bir yerdədir; AdventureWorks və Northwind-də yoxdur |
| D2 | 2026-09-17 | Layihə "E-commerce" kimi təqdim olunur, "retail mağaza şəbəkəsi" kimi yox | Olist onlayn marketplace-dir; dürüst təqdimat |
| D3 | 2026-09-17 | Model qurulmadan əvvəl ayrıca SQL profiling mərhələsi aparılır | Sətir sayları, təkrarlar və orphan əlaqələr müstəqil yoxlanmalıdır; problem Power Query mərhələsində tapılsa, geri qayıtmaq bahalı olur |
| D4 | 2026-09-17 | `01_raw_data` faylları heç vaxt dəyişdirilmir | Excel zip kodların sıfırlarını və tarix formatını poza bilər |
| D5 | 2026-09-17 | Çatdırılma tarixi boş olan sifarişlər silinmir | Çatdırılmamış sifarişlərdir, biznes məlumatıdır |
| D6 | 2026-09-17 | Repeat Customer Rate `customer_unique_id` ilə hesablanır | `customer_id` hər sifariş üçün ayrıcadır |
| D7 | 2026-09-17 | Satış = `order_items.price`; `payment_value` ilə toplanmır | Satış iki dəfə hesablanar |
| D8 | 2026-09-17 | `order_items` və `payments` birbaşa JOIN edilmir | Hər ikisində sifarişə çox sətir var; sətirlər çoxalar |
| D9 | 2026-09-17 | Profit və Profit Margin hesablanmır | Cost datası yoxdur |
| D10 | 2026-09-17 | Məhsul analizi kateqoriya səviyyəsindədir | Məhsul adı yoxdur |
| D11 | 2026-09-17 | Boş kateqoriya → `Unknown`; tərcüməsi olmayan kateqoriya Portuqalca qalır | Həmin məhsulların satışı var |
| D12 | 2026-09-17 | `geolocation` v1-də istifadə olunmur; region = `customer_state` / `customer_city` | Zip kodlar təkrarlanır, sətirlər çoxalar |
| D13 | 2026-09-17 | Reviews sifariş səviyyəsinə endirilir: sifarişə ən son rəy (ən gec `review_answer_timestamp`) | 547 sifarişin çox rəyi var; orta bal təhrif olunur |
| D14 | 2026-09-17 | Rəyi olmayan 768 sifariş silinmir, bal boş qalır (0 yazılmır) | 0 orta balı süni aşağı salar |
| D15 | 2026-09-17 | Gross Sales (bütün) + Net Sales (canceled/unavailable çıxılmaqla); çatdırılma metrikaları yalnız delivered | Real şirkət praktikası; gəlir şişirdilmir |
| D16 | 2026-09-17 | Trend dövrü 2017-01 – 2018-08; digər aylar datada qalır, qrafiklərdə filtrlənir | Natamam aylar yalançı "çöküş" göstərir |
| D17 | 2026-09-17 | AOV yalnız satışı olan sifarişlər üzrə; Total Orders bütün sifarişləri sayır | 775 sifarişin məhsul sətri yoxdur |
| D18 | 2026-09-17 | Çatdırılma müddəti = `order_delivered_customer_date` − `order_purchase_timestamp`, yalnız delivered + tarixi dolu (96.470) | 8 delivered sifarişin tarixi boşdur; purchase → customer ardıcıllığında anomaliya yoxdur (A07 = 0) |
| D19 | 2026-09-17 | Carrier mərhələsi (purchase → carrier, carrier → customer) v1-də ölçülmür | 166 + 23 məntiqsiz tarix; 171 günə qədər xəta |
| D20 | 2026-09-17 | Status əsas götürülür: çatdırılma tarixi olan 6 canceled sifariş canceled sayılır | Sifariş ləğv olunub; çatdırılma metrikasına düşməməlidir |
| D21 | 2026-09-17 | `payment_value` yalnız ödəniş üsulu və taksit analizində istifadə olunur | 249 sifarişdə ödəniş ≠ price + freight (232-sində çox; fərziyyə: taksit faizi/voucher) |
| D22 | 2026-09-17 | `not_defined` → `Not defined`; 0 məbləğli 9 ödəniş və 0 taksitli 2 ödəniş saxlanılır | Az saydadır, silmək üçün əsas yoxdur |
| D23 | 2026-09-17 | Zip kodlar Power BI-da Text; SQLite zip dəyərləri heç yerdə istifadə olunmur | SQLite 23.995 müştəri və 1.027 satıcı zip-inin sıfırını silib |
| D24 | 2026-09-17 | Power Query reviews-i CSV quote rejimi ilə oxuyur; 99.224 sətir nəzarət rəqəmidir; translation faylında BOM yoxlanır | Çoxsətirli şərhlər; UTF-8 BOM |
| D27 | 2026-09-17 | Power Query tip çevrilmələri "en-US" mədəniyyəti ilə aparılır | Kompüterin regional ayarı nöqtəli onluq və tarixləri səhv oxuya bilər |
| D28 | 2026-09-17 | Staging query-lər (`stg_`) xam CSV-dən oxuyur; ölçü/çəki/şərh sütunları staging-də çıxarılır | v1-də istifadə olunmur; model yüngül qalır, xam faylda saxlanılır |
| D29 | 2026-09-17 | Kateqoriya, ödəniş üsulu, şəhər adları oxunaqlı formata salınır (health_beauty → Health Beauty, credit_card → Credit Card) | Dashboard-da texniki kodlar görünməsin |
| D30 | 2026-09-19 | Hesabatın interfeys dili azərbaycanca; measure adları və data dəyərləri ingiliscə qalır | Hesabat yerli komanda üçündür; measure adı kod adıdır, data dəyərini tərcümə etmək mənbəni təhrif edər |
| D31 | 2026-09-19 | Tünd tema (`olist_dark_theme.json`) tətbiq olundu, bar chart-lara rəqəm etiketləri əlavə edildi | Ekran şəklində kontrast və oxunaqlıq |
| D32 | 2026-09-19 | Şirkət loqosu istifadə olunmur | Data Olist-in publik datasetidir; loqo rəsmi hesabat təəssüratı yaradar |
| D33 | 2026-09-19 | Dashboard səhifəsinə "Əsas tapıntılar" mətn paneli əlavə olundu | Dashboard rəqəm göstərməklə kifayətlənməməli, nəticəni də deməlidir; qərar dəstəyi budur |
| D34 | 2026-09-19 | Ştat cədvəlində Gecikmə % sütununa şərti formatlaşdırma (tünd → qırmızı gradient) | Problemli regionlar oxumadan görünsün; rəng yalnız diqqət tələb edən göstəriciyə tətbiq olunur |
| D35 | 2026-09-19 | Ödəniş qrafiki hər iki səhifədə donut, eyni rənglər (Credit Card mavi, Boleto sarı), etiketlər dilimin üstündə | Bütöv-hissə sualı üçün donut uyğundur; eyni metrika hər yerdə eyni görünməlidir |
| D36 | 2026-09-19 | Pul measure-lərinin formatı `#,##0 "R$"` xüsusi format sətrinə keçirildi | Power BI kompüterin regional ayarına görə manat (₼) simvolu göstərirdi; data Braziliyadandır, valyuta realdır |
| D37 | 2026-09-19 | Dashboard səhifəsində bar chart-lar Top 10 yerinə Top 7; detal səhifələrində Top 10 qalır | 250 px hündürlükdə 10 sətir sürüşdürmə tələb edirdi — "Top 10" yazıb 7 göstərmək yanlış təəssürat yaradır |
| D38 | 2026-09-19 | Tapıntı panelinə dövr qeydi əlavə olundu | Mətn statikdir, slicer dəyişəndə yenilənmir; oxucu bunu bilməlidir |
| D39 | 2026-09-19 | Aylıq trend qrafikinə `Net Sales PY` ikinci xətt kimi əlavə olundu (Ümumi baxış və Dashboard) | YoY müqayisəsi bir rəqəmdə yox, hər ay üzrə görünür; böyümənin harada dayandığı aydın olur |
| D40 | 2026-09-19 | `Yoxlama` səhifəsi gizlədildi (Hide) | Daxili QA səhifəsidir; təqdimatda görünməməlidir, amma faylda qalır və izah oluna bilər |
| D41 | 2026-09-19 | Qovluq nömrələnməsi iş axını ardıcıllığına uyğunlaşdırıldı | Nömrələrdə boşluq vardı; indi sıra iş axını ilə üst-üstə düşür: xam data → SQL → Power BI → sənədlər → ekran şəkilləri |
| D42 | 2026-09-19 | "Ən çox satan iki kateqoriyanın rəy balı aşağıdır" ifadəsi düzəldildi | Xam datadan müstəqil yoxlama göstərdi ki, satışa görə ilk iki kateqoriya Health Beauty (4,18) və Watches Gifts (4,07)-dir; Bed Bath Table satışa görə 3-cü, Computers Accessories 5-cidir. Dəqiq ifadə: ilk beş kateqoriyanın üçündə bal ortadan aşağıdır |
| D43 | 2026-09-19 | Gecikmə tərifi README-də açıq yazıldı (tarix səviyyəsində müqayisə) | `order_estimated_delivery_date`-də saat yoxdur; timestamp müqayisəsi 8,11%, tarix müqayisəsi 6,77% verir. Fərq izah olunmasa, yoxlayan fərqli rəqəm alıb səbəbini soruşa bilər |
| D44 | 2026-09-19 | Təkrar alış üzrə iki rəqəmin fərqi araşdırıldı və sənədlərdə açıqlandı | Hesabat 3,11% göstərir (dövr üzrə: 2.975 / 95.774 = 3,1063%), nəzarət rəqəmi isə 3,12%-dir (bütün dövr: 2.997 / 96.096 = 3,1188%). İkisi də düzgündür; sənədlərdə hesabatın rəqəmi əsas götürülür, fərq mötərizədə yazılır |
| D45 | 2026-09-19 | `Müştəri və çatdırılma` səhifəsindəki il filtri təmizləndi və bütün səhifələrin slicer vəziyyəti yoxlanıldı | Səhifə 2018 seçimi ilə saxlanılmışdı: bütün KPI-lar yarı dəyər göstərirdi (53K müştəri, 2,19% təkrar alış). Power BI faylı filtr seçimini yadda saxlayır |
| D46 | 2026-09-19 | `Dashboard` səhifəsinin başlığı "Ümumi baxış"dan "Dashboard"a dəyişdirildi | İki fərqli səhifə eyni başlığı daşıyırdı |
| D47 | 2026-09-19 | Bar chart başlıqlarından rəqəm çıxarıldı ("10 kateqoriya" → "kateqoriyalar"), `Net Sales PY` → "Keçən il", xətt qrafikində y-oxu başlığı söndürüldü | Başlıq 10 deyirdi, vizual 8–9 sətir göstərirdi (qalanı sürüşdürmə ilə); y-oxu başlığı "Xalis satış and Keç..." kimi yarı ingilis görünürdü |
| D48 | 2026-09-19 | Yayımdan əvvəl bütün səhifələrin bir yerdə yoxlanması qaydası qəbul edildi | 2026-09-19 yoxlamasında tapılan 5 qüsurun hamısı ayrı-ayrılıqda yoxlanmış, amma birlikdə baxılmamış dəyişikliklərdən yaranmışdı |
| D49 | 2026-09-19 | Sənədlərdəki səhifə adları hesabatdakı real adlarla əvəz olundu (Executive Overview → `Ümumi baxış` və s.), measure sayı 21 kimi vahidləşdirildi | README və business_questions oxucunu hesabatda mövcud olmayan səhifə adlarına yönləndirirdi; measure sayı üç sənəddə üç cür yazılmışdı |
| D50 | 2026-09-19 | Plato və gecikmə–məmnuniyyət tapıntıları rəqəmlə möhkəmləndirildi | Plato: 2018-də aylıq satış 838–994 min BRL, yüksələn meyl yox; 2017-11 zirvəsi Black Friday dövrüdür. Gecikmə–rəy əlaqəsi: 24 ştat üzrə r = −0,89 (xam datadan hesablanıb) |
