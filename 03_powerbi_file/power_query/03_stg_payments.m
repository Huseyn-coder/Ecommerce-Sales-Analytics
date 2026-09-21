// Query adı: stg_payments
// Mənbə: olist_order_payments_dataset.csv | Gözlənilən sətir: 103.886
// Nəzarət: Credit Card 76.795; Boleto 19.784; Voucher 5.775; Debit Card 1.529; Not Defined 3
// Qərarlar: D21 (payment_value satış üçün istifadə olunmur), D22
let
    Source = Csv.Document(
        File.Contents(RawDataPath & "olist_order_payments_dataset.csv"),
        [Delimiter = ",", Columns = 5, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    ChangedTypes = Table.TransformColumnTypes(
        PromotedHeaders,
        {
            {"order_id", type text},
            {"payment_sequential", Int64.Type},
            {"payment_type", type text},
            {"payment_installments", Int64.Type},
            {"payment_value", Currency.Type}
        },
        "en-US"
    ),
    // credit_card -> Credit Card, not_defined -> Not Defined
    CleanPaymentType = Table.TransformColumns(
        ChangedTypes, {{"payment_type", each Text.Proper(Text.Replace(_, "_", " ")), type text}}
    )
in
    CleanPaymentType
