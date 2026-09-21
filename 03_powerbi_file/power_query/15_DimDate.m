// Query adı: DimDate
// Aralıq: 2016-01-01 – 2018-12-31 (1.096 gün). Tam illər götürülür ki, YoY müqayisəsi düzgün işləsin.
// Data aralığı: sifariş 2016-09-04 – 2018-10-17; təxmini çatdırılma ən gec 2018-11-12.
// is_trend_period = D16 qərarı: trend qrafikləri yalnız 2017-01 – 2018-08 dövrünü göstərir.
let
    StartDate = #date(2016, 1, 1),
    EndDate = #date(2018, 12, 31),
    DayCount = Duration.Days(EndDate - StartDate) + 1,
    DateList = List.Dates(StartDate, DayCount, #duration(1, 0, 0, 0)),
    ToTable = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}),
    TypedDate = Table.TransformColumnTypes(ToTable, {{"Date", type date}}),
    AddYear = Table.AddColumn(TypedDate, "Year", each Date.Year([Date]), Int64.Type),
    AddQuarter = Table.AddColumn(AddYear, "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])), type text),
    AddMonthNo = Table.AddColumn(AddQuarter, "Month No", each Date.Month([Date]), Int64.Type),
    AddMonthName = Table.AddColumn(AddMonthNo, "Month", each Date.ToText([Date], "MMM", "en-US"), type text),
    AddYearMonth = Table.AddColumn(AddMonthName, "Year-Month", each Date.ToText([Date], "yyyy-MM", "en-US"), type text),
    AddMonthLabel = Table.AddColumn(AddYearMonth, "Month-Year", each Date.ToText([Date], "MMM yyyy", "en-US"), type text),
    AddYearMonthSort = Table.AddColumn(AddMonthLabel, "Year-Month Sort", each [Year] * 100 + [Month No], Int64.Type),
    AddTrendFlag = Table.AddColumn(
        AddYearMonthSort, "is_trend_period",
        each [Year] * 100 + [Month No] >= 201701 and [Year] * 100 + [Month No] <= 201808,
        type logical
    )
in
    AddTrendFlag
