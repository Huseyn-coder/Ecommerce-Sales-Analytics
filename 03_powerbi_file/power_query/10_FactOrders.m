// Query adı: FactOrders
// Dənəvərlik: 1 sifariş | Gözlənilən sətir: 99.441
// Mənbə: stg_orders + stg_reviews_latest
// Nəzarət: is_delivered = TRUE 96.470; delivery_days ortalaması 12,56 (median 10,22);
//          is_late = TRUE 6.534 (delivered-in 6,77%-i); review_score dolu 98.673, ortalama 4,0864
// Qərarlar: D13, D14, D18, D19, D20
let
    Source = stg_orders,
    MergedReviews = Table.NestedJoin(Source, {"order_id"}, stg_reviews_latest, {"order_id"}, "review", JoinKind.LeftOuter),
    ExpandedReviews = Table.ExpandTableColumn(MergedReviews, "review", {"review_score"}),
    // Çatdırılmış = status delivered VƏ müştəriyə çatdırılma tarixi dolu
    AddedIsDelivered = Table.AddColumn(
        ExpandedReviews, "is_delivered",
        each [order_status] = "delivered" and [order_delivered_customer_date] <> null,
        type logical
    ),
    // Çatdırılma müddəti (gün, onluq): yalnız çatdırılmış sifarişlər üçün
    AddedDeliveryDays = Table.AddColumn(
        AddedIsDelivered, "delivery_days",
        each if [is_delivered]
            then Duration.TotalDays([order_delivered_customer_date] - [order_purchase_timestamp])
            else null,
        type nullable number
    ),
    // Gecikmə: çatdırılma günü təxmini tarixdən sonradırsa
    AddedIsLate = Table.AddColumn(
        AddedDeliveryDays, "is_late",
        each if [is_delivered]
            then DateTime.Date([order_delivered_customer_date]) > [order_estimated_date]
            else null,
        type nullable logical
    ),
    AddedDeliveredDate = Table.AddColumn(
        AddedIsLate, "order_delivered_date",
        each if [order_delivered_customer_date] = null then null else DateTime.Date([order_delivered_customer_date]),
        type nullable date
    ),
    FinalColumns = Table.SelectColumns(
        AddedDeliveredDate,
        {"order_id", "customer_id", "order_status", "order_purchase_date", "order_purchase_timestamp",
         "order_delivered_date", "order_estimated_date", "is_delivered", "delivery_days", "is_late", "review_score"}
    ),
    FinalTypes = Table.TransformColumnTypes(FinalColumns, {{"review_score", Int64.Type}})
in
    FinalTypes
