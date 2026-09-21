// Query adı: stg_category_translation
// Mənbə: product_category_name_translation.csv | Gözlənilən sətir: 71
// Qeyd: fayl UTF-8 BOM ilə başlayır; ilk sütunun adı mövqeyə görə yenidən verilir (D24)
let
    Source = Csv.Document(
        File.Contents(RawDataPath & "product_category_name_translation.csv"),
        [Delimiter = ",", Columns = 2, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    RenamedByPosition = Table.RenameColumns(
        PromotedHeaders,
        {
            {Table.ColumnNames(PromotedHeaders){0}, "product_category_name"},
            {Table.ColumnNames(PromotedHeaders){1}, "product_category_name_english"}
        }
    ),
    ChangedTypes = Table.TransformColumnTypes(
        RenamedByPosition,
        {{"product_category_name", type text}, {"product_category_name_english", type text}}
    )
in
    ChangedTypes
