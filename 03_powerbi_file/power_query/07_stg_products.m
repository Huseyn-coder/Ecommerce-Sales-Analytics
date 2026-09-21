// Query adı: stg_products
// Mənbə: olist_products_dataset.csv + stg_category_translation | Gözlənilən sətir: 32.951
// Nəzarət: 74 kateqoriya (71 tərcümə + 2 tərcüməsiz + Unknown); Unknown = 610 məhsul
// Qərarlar: D10 (kateqoriya səviyyəsi), D11 (Unknown, Portuqalca saxlanılır)
let
    Source = Csv.Document(
        File.Contents(RawDataPath & "olist_products_dataset.csv"),
        [Delimiter = ",", Columns = 9, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    // Ölçü, çəki, foto və ad uzunluğu sütunları v1-də istifadə olunmur (xam faylda qalır)
    SelectedColumns = Table.SelectColumns(PromotedHeaders, {"product_id", "product_category_name"}),
    ChangedTypes = Table.TransformColumnTypes(
        SelectedColumns, {{"product_id", type text}, {"product_category_name", type text}}
    ),
    MergedTranslation = Table.NestedJoin(
        ChangedTypes, {"product_category_name"},
        stg_category_translation, {"product_category_name"},
        "translation", JoinKind.LeftOuter
    ),
    ExpandedTranslation = Table.ExpandTableColumn(
        MergedTranslation, "translation", {"product_category_name_english"}
    ),
    // Boş -> Unknown; tərcümə yoxdursa Portuqalca ad; alt xətt -> boşluq, hər söz böyük hərflə
    AddedCategory = Table.AddColumn(
        ExpandedTranslation,
        "product_category",
        each
            if [product_category_name] = null or [product_category_name] = "" then
                "Unknown"
            else
                Text.Proper(
                    Text.Replace(
                        if [product_category_name_english] = null or [product_category_name_english] = ""
                        then [product_category_name]
                        else [product_category_name_english],
                        "_", " "
                    )
                ),
        type text
    ),
    RenamedPortuguese = Table.RenameColumns(
        AddedCategory, {{"product_category_name", "product_category_pt"}}
    ),
    FinalColumns = Table.SelectColumns(
        RenamedPortuguese, {"product_id", "product_category", "product_category_pt"}
    )
in
    FinalColumns
