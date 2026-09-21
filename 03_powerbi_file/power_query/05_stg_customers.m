// Query adı: stg_customers
// Mənbə: olist_customers_dataset.csv | Gözlənilən sətir: 99.441 | Unikal customer_unique_id: 96.096
// Qərarlar: D6 (real müştəri = customer_unique_id), D23 (zip Text)
let
    Source = Csv.Document(
        File.Contents(RawDataPath & "olist_customers_dataset.csv"),
        [Delimiter = ",", Columns = 5, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    // Zip Text qalır ki, əvvəlindəki sıfırlar itməsin (01310 -> 1310 olmasın)
    ChangedTypes = Table.TransformColumnTypes(
        PromotedHeaders,
        {
            {"customer_id", type text},
            {"customer_unique_id", type text},
            {"customer_zip_code_prefix", type text},
            {"customer_city", type text},
            {"customer_state", type text}
        }
    ),
    // sao paulo -> Sao Paulo (hesabatda oxunaqlı görünsün)
    CleanText = Table.TransformColumns(
        ChangedTypes,
        {
            {"customer_city", each Text.Proper(Text.Trim(_)), type text},
            {"customer_state", each Text.Upper(Text.Trim(_)), type text}
        }
    )
in
    CleanText
