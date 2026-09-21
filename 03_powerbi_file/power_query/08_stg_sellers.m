// Query adı: stg_sellers
// Mənbə: olist_sellers_dataset.csv | Gözlənilən sətir: 3.095
// Qərarlar: D23 (zip Text)
let
    Source = Csv.Document(
        File.Contents(RawDataPath & "olist_sellers_dataset.csv"),
        [Delimiter = ",", Columns = 4, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    ChangedTypes = Table.TransformColumnTypes(
        PromotedHeaders,
        {
            {"seller_id", type text},
            {"seller_zip_code_prefix", type text},
            {"seller_city", type text},
            {"seller_state", type text}
        }
    ),
    CleanText = Table.TransformColumns(
        ChangedTypes,
        {
            {"seller_city", each Text.Proper(Text.Trim(_)), type text},
            {"seller_state", each Text.Upper(Text.Trim(_)), type text}
        }
    )
in
    CleanText
