// Query adı: stg_orders
// Mənbə: olist_orders_dataset.csv | Gözlənilən sətir: 99.441
// Qərarlar: D5 (boş tarixlər saxlanılır), D18, D20
let
    Source = Csv.Document(
        File.Contents(RawDataPath & "olist_orders_dataset.csv"),
        [Delimiter = ",", Columns = 8, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    // Boş mətni null edirik ki, tarix tipinə çevrilmə xəta verməsin
    BlanksToNull = Table.ReplaceValue(
        PromotedHeaders, "", null, Replacer.ReplaceValue,
        {"order_approved_at", "order_delivered_carrier_date", "order_delivered_customer_date"}
    ),
    // "en-US" mədəniyyəti: kompüterin regional ayarından asılı olmadan tarixlər düzgün oxunur
    ChangedTypes = Table.TransformColumnTypes(
        BlanksToNull,
        {
            {"order_id", type text},
            {"customer_id", type text},
            {"order_status", type text},
            {"order_purchase_timestamp", type datetime},
            {"order_approved_at", type datetime},
            {"order_delivered_carrier_date", type datetime},
            {"order_delivered_customer_date", type datetime},
            {"order_estimated_delivery_date", type datetime}
        },
        "en-US"
    ),
    AddedPurchaseDate = Table.AddColumn(
        ChangedTypes, "order_purchase_date", each DateTime.Date([order_purchase_timestamp]), type date
    ),
    AddedEstimatedDate = Table.AddColumn(
        AddedPurchaseDate, "order_estimated_date", each DateTime.Date([order_estimated_delivery_date]), type date
    )
in
    AddedEstimatedDate
