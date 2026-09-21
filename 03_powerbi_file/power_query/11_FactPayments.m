// Query adı: FactPayments
// Dənəvərlik: 1 ödəniş (order_id + payment_sequential) | Gözlənilən sətir: 103.886
// Mənbə: stg_payments + stg_orders
// Qərarlar: D8 (FactSales ilə birbaşa bağlanmır), D21, D22
let
    Source = stg_payments,
    MergedOrders = Table.NestedJoin(Source, {"order_id"}, stg_orders, {"order_id"}, "orders", JoinKind.LeftOuter),
    ExpandedOrders = Table.ExpandTableColumn(
        MergedOrders, "orders", {"customer_id", "order_status", "order_purchase_date"}
    ),
    FinalColumns = Table.SelectColumns(
        ExpandedOrders,
        {"order_id", "payment_sequential", "customer_id", "order_status", "order_purchase_date",
         "payment_type", "payment_installments", "payment_value"}
    )
in
    FinalColumns
