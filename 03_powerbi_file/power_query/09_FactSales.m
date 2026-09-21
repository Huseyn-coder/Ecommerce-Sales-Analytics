// Query adı: FactSales
// Dənəvərlik: sifarişdəki 1 məhsul (order_id + order_item_id) | Gözlənilən sətir: 112.650
// Mənbə: stg_order_items + stg_orders
// Nəzarət: price cəmi 13.591.643,70; is_net_sale = TRUE olanların price cəmi 13.494.400,74
// Qərarlar: D7, D15, D17
let
    Source = stg_order_items,
    MergedOrders = Table.NestedJoin(Source, {"order_id"}, stg_orders, {"order_id"}, "orders", JoinKind.LeftOuter),
    ExpandedOrders = Table.ExpandTableColumn(
        MergedOrders, "orders", {"customer_id", "order_status", "order_purchase_date"}
    ),
    // Net Sales üçün bayraq: canceled və unavailable satışa daxil deyil
    AddedNetFlag = Table.AddColumn(
        ExpandedOrders, "is_net_sale",
        each not List.Contains({"canceled", "unavailable"}, [order_status]),
        type logical
    ),
    FinalColumns = Table.SelectColumns(
        AddedNetFlag,
        {"order_id", "order_item_id", "product_id", "seller_id", "customer_id",
         "order_status", "order_purchase_date", "price", "freight_value", "is_net_sale"}
    )
in
    FinalColumns
