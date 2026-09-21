// Query adı: stg_order_items
// Mənbə: olist_order_items_dataset.csv | Gözlənilən sətir: 112.650
// Nəzarət: price cəmi 13.591.643,70; freight_value cəmi 2.251.909,54
// Qərarlar: D7 (satış = price)
let
    Source = Csv.Document(
        File.Contents(RawDataPath & "olist_order_items_dataset.csv"),
        [Delimiter = ",", Columns = 7, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    // "en-US": 58.90 nöqtəli onluq kimi oxunur (az-AZ ayarında 5890 kimi oxunmasın)
    ChangedTypes = Table.TransformColumnTypes(
        PromotedHeaders,
        {
            {"order_id", type text},
            {"order_item_id", Int64.Type},
            {"product_id", type text},
            {"seller_id", type text},
            {"shipping_limit_date", type datetime},
            {"price", Currency.Type},
            {"freight_value", Currency.Type}
        },
        "en-US"
    )
in
    ChangedTypes
