// Query adı: stg_reviews_latest
// Mənbə: olist_order_reviews_dataset.csv | Xam sətir: 99.224 -> nəticə: 98.673 (sifarişə 1 rəy)
// Nəzarət: review_score ortalaması 4,0864
// Qərarlar: D13 (ən son rəy), D14 (rəyi olmayan sifariş silinmir), D24 (çoxsətirli şərhlər)
let
    // QuoteStyle.Csv: dırnaq içindəki yeni sətirlər ayrıca sətir sayılmır
    Source = Csv.Document(
        File.Contents(RawDataPath & "olist_order_reviews_dataset.csv"),
        [Delimiter = ",", Columns = 7, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    // Şərh mətnləri v1-də analiz olunmur, çıxarırıq
    SelectedColumns = Table.SelectColumns(
        PromotedHeaders,
        {"review_id", "order_id", "review_score", "review_creation_date", "review_answer_timestamp"}
    ),
    ChangedTypes = Table.TransformColumnTypes(
        SelectedColumns,
        {
            {"review_id", type text},
            {"order_id", type text},
            {"review_score", Int64.Type},
            {"review_creation_date", type datetime},
            {"review_answer_timestamp", type datetime}
        },
        "en-US"
    ),
    // Hər sifariş üçün ən gec cavablandırılmış rəyi seçirik
    GroupedLatest = Table.Group(
        ChangedTypes,
        {"order_id"},
        {
            {
                "latest",
                each Table.First(
                    Table.Sort(
                        _,
                        {
                            {"review_answer_timestamp", Order.Descending},
                            {"review_creation_date", Order.Descending},
                            {"review_id", Order.Descending}
                        }
                    )
                ),
                type record
            }
        }
    ),
    Expanded = Table.ExpandRecordColumn(
        GroupedLatest, "latest",
        {"review_id", "review_score", "review_creation_date", "review_answer_timestamp"}
    ),
    FinalTypes = Table.TransformColumnTypes(
        Expanded,
        {
            {"review_id", type text},
            {"review_score", Int64.Type},
            {"review_creation_date", type datetime},
            {"review_answer_timestamp", type datetime}
        }
    )
in
    FinalTypes
