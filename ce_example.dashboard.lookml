# - dashboard: brand_comparison
#   title: Brand Comparison
#   layout: newspaper
#   elements:
#   - title: Transactions
#     name: Transactions
#     model: ce_transact
#     explore: trans
#     type: looker_column
#     fields:
#     - trans.brand_name
#     - trans.count
#     filters:
#       trans.main_brand: '"MACY''S"'
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.count desc
#     limit: 10
#     query_timezone: America/New_York
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: false
#     limit_displayed_rows: false
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: editable
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     series_types: {}
#     hidden_fields:
#     - of_total
#     y_axes:
#     - label: ''
#       maxValue:
#       minValue:
#       orientation: left
#       showLabels: true
#       showValues: true
#       tickDensity: default
#       tickDensityCustom: 5
#       type: linear
#       unpinAxis: false
#       valueFormat: '[>=1000000]0,,"M";[>=1000]0,"k";0'
#       series:
#       - id: trans.count
#         name: Count Transactions
#         axisId: trans.count
#     - label:
#       maxValue:
#       minValue:
#       orientation: right
#       showLabels: true
#       showValues: true
#       tickDensity: default
#       tickDensityCustom: 5
#       type: linear
#       unpinAxis: false
#       valueFormat:
#       series:
#       - id: of_total
#         name: "% of Total"
#         axisId: of_total
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 0
#     col: 0
#     width: 6
#     height: 6
#   - title: Total Spend
#     name: Total Spend
#     model: ce_transact
#     explore: trans
#     type: looker_column
#     fields:
#     - trans.brand_name
#     - trans.total_sales
#     filters:
#       trans.main_brand: '"MACY''S"'
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.total_sales desc
#     limit: 10
#     query_timezone: America/New_York
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: false
#     limit_displayed_rows: false
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: editable
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     series_types: {}
#     hidden_fields:
#     - of_total
#     y_axes:
#     - label: ''
#       maxValue:
#       minValue:
#       orientation: left
#       showLabels: true
#       showValues: true
#       tickDensity: default
#       tickDensityCustom:
#       type: linear
#       unpinAxis: false
#       valueFormat: '[>=1000000]$0,,"M";[>=1000]$0,"k";$0'
#       series:
#       - id: trans.total_sales
#         name: Total Sales
#         axisId: trans.total_sales
#     colors:
#     - "#CBCCCE"
#     - "#257891"
#     - "#332E56"
#     - "#231F20"
#     - "#71C6C2"
#     - "#C67F69"
#     - "#FB5C5C"
#     series_colors: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 0
#     col: 12
#     width: 6
#     height: 6
#   - title: Count of Cards
#     name: Count of Cards
#     model: ce_transact
#     explore: trans
#     type: looker_column
#     fields:
#     - trans.brand_name
#     - trans.count_cards
#     filters:
#       trans.main_brand: '"MACY''S"'
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.count_cards desc
#     limit: 10
#     query_timezone: America/New_York
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: false
#     limit_displayed_rows: false
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: editable
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     series_types: {}
#     hidden_fields:
#     - of_total
#     y_axes:
#     - label: ''
#       maxValue:
#       minValue:
#       orientation: left
#       showLabels: true
#       showValues: true
#       tickDensity: default
#       tickDensityCustom:
#       type: linear
#       unpinAxis: false
#       valueFormat: '[>=1000]0,"k";0'
#       series:
#       - id: trans.count_cards
#         name: Count Cards
#         axisId: trans.count_cards
#     colors:
#     - "#B2C7D8"
#     - "#CBCCCE"
#     - "#257891"
#     - "#332E56"
#     - "#231F20"
#     - "#71C6C2"
#     - "#C67F69"
#     - "#FB5C5C"
#     series_colors: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 0
#     col: 6
#     width: 6
#     height: 6
#   - title: Average Spend
#     name: Average Spend
#     model: ce_transact
#     explore: trans
#     type: looker_column
#     fields:
#     - trans.brand_name
#     - trans.average_sales
#     filters:
#       trans.main_brand: '"MACY''S"'
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.brand_name desc
#     limit: 10
#     query_timezone: America/New_York
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: false
#     limit_displayed_rows: false
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: editable
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     series_types: {}
#     hidden_fields:
#     - of_total
#     y_axes:
#     - label: ''
#       maxValue:
#       minValue:
#       orientation: left
#       showLabels: true
#       showValues: true
#       tickDensity: default
#       tickDensityCustom:
#       type: linear
#       unpinAxis: false
#       valueFormat: '[>=1000000]$0,,"M";[>=1000]$0,"k";$0'
#       series:
#       - id: trans.total_sales
#         name: Total Sales
#         axisId: trans.total_sales
#     colors:
#     - "#257891"
#     - "#332E56"
#     - "#231F20"
#     - "#71C6C2"
#     - "#C67F69"
#     - "#FB5C5C"
#     series_colors: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 0
#     col: 18
#     width: 6
#     height: 6
#   - title: Brand Shopping - Metrics (Summary)
#     name: Brand Shopping - Metrics (Summary)
#     model: ce_transact
#     explore: trans
#     type: table
#     fields:
#     - trans.brand_name
#     - trans.count
#     - trans.count_cards
#     - trans.total_sales
#     - trans.average_sales
#     filters:
#       trans.main_brand: '"MACY''S"'
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.count desc
#     limit: 500
#     query_timezone: America/New_York
#     show_view_names: false
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 10
#     col: 0
#     width: 12
#     height: 5
#   - title: Total Spend
#     name: Total Spend
#     model: ce_transact
#     explore: trans
#     type: table
#     fields:
#     - trans.brand_name
#     - trans.total_sales
#     filters:
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.total_sales desc
#     limit: 500
#     dynamic_fields:
#     - table_calculation: of_total
#       label: "% of Total"
#       expression: "${trans.total_sales}/index(${trans.total_sales},1)"
#       value_format:
#       value_format_name: percent_1
#       _kind_hint: measure
#       _type_hint: number
#     show_view_names: false
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 6
#     col: 12
#     width: 6
#     height: 4
#   - title: Count of Cards
#     name: Count of Cards
#     model: ce_transact
#     explore: trans
#     type: table
#     fields:
#     - trans.brand_name
#     - trans.count_cards
#     filters:
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.count_cards desc
#     limit: 500
#     dynamic_fields:
#     - table_calculation: of_total
#       label: "% of Total"
#       expression: "${trans.count_cards}/index(${trans.count_cards},1)"
#       value_format:
#       value_format_name: percent_1
#       _kind_hint: measure
#       _type_hint: number
#     show_view_names: false
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 6
#     col: 6
#     width: 6
#     height: 4
#   - title: Average Spend
#     name: Average Spend
#     model: ce_transact
#     explore: trans
#     type: table
#     fields:
#     - trans.brand_name
#     - trans.average_sales
#     filters:
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.average_sales desc
#     limit: 500
#     dynamic_fields:
#     - table_calculation: of_total
#       label: "% of Total"
#       expression: "${trans.average_sales}/index(${trans.average_sales},1)"
#       value_format:
#       value_format_name: percent_1
#       _kind_hint: measure
#       _type_hint: number
#     show_view_names: false
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 6
#     col: 18
#     width: 6
#     height: 4
#   - title: Spend Over Time
#     name: Spend Over Time
#     model: ce_transact
#     explore: trans
#     type: looker_column
#     fields:
#     - trans.brand_name
#     - trans.transaction_month
#     - trans.total_sales
#     pivots:
#     - trans.brand_name
#     fill_fields:
#     - trans.transaction_month
#     filters:
#       trans.main_brand: '"MACY''S"'
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.brand_name desc 0
#     - trans.transaction_month
#     limit: 500
#     query_timezone: America/New_York
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: false
#     limit_displayed_rows: false
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     series_types: {}
#     y_axes:
#     - label: ''
#       maxValue:
#       minValue:
#       orientation: left
#       showLabels: true
#       showValues: true
#       tickDensity: default
#       tickDensityCustom: 5
#       type: linear
#       unpinAxis: false
#       valueFormat: $[>1000000]#,,"M";$0
#       series:
#       - id: ZZOUNDS
#         name: ZZOUNDS
#         axisId: trans.total_sales
#       - id: ZYNGA
#         name: ZYNGA
#         axisId: trans.total_sales
#       - id: ZUMIEZ
#         name: ZUMIEZ
#         axisId: trans.total_sales
#       - id: ZULILY
#         name: ZULILY
#         axisId: trans.total_sales
#       - id: ZORO
#         name: ZORO
#         axisId: trans.total_sales
#       - id: ZOE'S KITCHEN
#         name: ZOE&#x27;S KITCHEN
#         axisId: trans.total_sales
#       - id: ZODIAC
#         name: ZODIAC
#         axisId: trans.total_sales
#       - id: ZIPCAR
#         name: ZIPCAR
#         axisId: trans.total_sales
#       - id: ZAXBYS
#         name: ZAXBYS
#         axisId: trans.total_sales
#       - id: ZARA HOME
#         name: ZARA HOME
#         axisId: trans.total_sales
#       - id: ZARA
#         name: ZARA
#         axisId: trans.total_sales
#       - id: ZAPPOS
#         name: ZAPPOS
#         axisId: trans.total_sales
#       - id: ZALES
#         name: ZALES
#         axisId: trans.total_sales
#       - id: ZACHARY PRELL
#         name: ZACHARY PRELL
#         axisId: trans.total_sales
#       - id: Z GALLERIE
#         name: Z GALLERIE
#         axisId: trans.total_sales
#       - id: YVES SAINT LAURENT
#         name: YVES SAINT LAURENT
#         axisId: trans.total_sales
#       - id: YRC FREIGHT
#         name: YRC FREIGHT
#         axisId: trans.total_sales
#       - id: YOYO.COM
#         name: YOYO.COM
#         axisId: trans.total_sales
#       - id: YOUTUBE TV
#         name: YOUTUBE TV
#         axisId: trans.total_sales
#       - id: YOUR OTHER WAREHOUSE
#         name: YOUR OTHER WAREHOUSE
#         axisId: trans.total_sales
#       - id: YOUNKERS
#         name: YOUNKERS
#         axisId: trans.total_sales
#       - id: YOLO
#         name: YOLO
#         axisId: trans.total_sales
#       - id: YOGURT NATION
#         name: YOGURT NATION
#         axisId: trans.total_sales
#       - id: YOGURT MOUNTAIN
#         name: YOGURT MOUNTAIN
#         axisId: trans.total_sales
#       - id: YARD HOUSE
#         name: YARD HOUSE
#         axisId: trans.total_sales
#       - id: YANKEE CANDLE
#         name: YANKEE CANDLE
#         axisId: trans.total_sales
#       - id: YAMAHA MOTORCYCLES
#         name: YAMAHA MOTORCYCLES
#         axisId: trans.total_sales
#       - id: XFINITY
#         name: XFINITY
#         axisId: trans.total_sales
#       - id: XBOX
#         name: XBOX
#         axisId: trans.total_sales
#       - id: WYNNSONG CINEMAS
#         name: WYNNSONG CINEMAS
#         axisId: trans.total_sales
#       - id: WYNN LAS VEGAS
#         name: WYNN LAS VEGAS
#         axisId: trans.total_sales
#       - id: WYNN
#         name: WYNN
#         axisId: trans.total_sales
#       - id: WYNDHAM VACATION RESORTS
#         name: WYNDHAM VACATION RESORTS
#         axisId: trans.total_sales
#       - id: WYNDHAM HOTELS
#         name: WYNDHAM HOTELS
#         axisId: trans.total_sales
#       - id: WRANGLER
#         name: WRANGLER
#         axisId: trans.total_sales
#       - id: WPI IFRIENDS
#         name: WPI IFRIENDS
#         axisId: trans.total_sales
#       - id: WOW!
#         name: WOW!
#         axisId: trans.total_sales
#       - id: WOTIF.COM
#         name: WOTIF.COM
#         axisId: trans.total_sales
#       - id: WORLDWIDECHOCOLATE.COM
#         name: WORLDWIDECHOCOLATE.COM
#         axisId: trans.total_sales
#       - id: WORLDS OF FUN
#         name: WORLDS OF FUN
#         axisId: trans.total_sales
#       - id: WORLDPAC
#         name: WORLDPAC
#         axisId: trans.total_sales
#       - id: WORLDMARK
#         name: WORLDMARK
#         axisId: trans.total_sales
#       - id: WORLD OF TILE
#         name: WORLD OF TILE
#         axisId: trans.total_sales
#       - id: WORLD OF JEANS & TOPS
#         name: WORLD OF JEANS &amp; TOPS
#         axisId: trans.total_sales
#       - id: WORLD GYM INT'L
#         name: WORLD GYM INT&#x27;L
#         axisId: trans.total_sales
#       - id: WOOT.COM
#         name: WOOT.COM
#         axisId: trans.total_sales
#       - id: WOLFGANG PUCK EXPRESS
#         name: WOLFGANG PUCK EXPRESS
#         axisId: trans.total_sales
#       - id: WOLFERMAN'S
#         name: WOLFERMAN&#x27;S
#         axisId: trans.total_sales
#       - id: WOLF CAMERA
#         name: WOLF CAMERA
#         axisId: trans.total_sales
#       - id: WLI
#         name: WLI
#         axisId: trans.total_sales
#     column_spacing_ratio:
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 15
#     col: 0
#     width: 24
#     height: 8
#   - name: Affinity
#     title: Affinity
#     model: ce_transact
#     explore: brand_cards
#     type: table
#     fields:
#     - brand_cards.brand_a
#     - brand_cards.brand_b
#     - brand_cards.overlap_cards
#     - brand_cards.overlap_card_pct
#     - brand_cards.add_on_frequency
#     - brand_cards.lift
#     - brand_cards.jaccard_similarity
#     filters:
#       trans.panel: '3'
#       trans.main_brand: '"MACY''S"'
#       brand_cards.brand_b: NORDSTROM,JCPENNEY,"BLOOMINGDALE'S"
#       brand_cards.brand_a: '"MACY''S"'
#     sorts:
#     - brand_cards.brand_b
#     limit: 500
#     query_timezone: America/New_York
#     show_view_names: false
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     row: 10
#     col: 12
#     width: 12
#     height: 5
#   - title: Spend Over Time (Table)
#     name: Spend Over Time (Table)
#     model: ce_transact
#     explore: trans
#     type: table
#     fields:
#     - trans.brand_name
#     - trans.transaction_month
#     - trans.total_sales
#     pivots:
#     - trans.brand_name
#     fill_fields:
#     - trans.transaction_month
#     filters:
#       trans.main_brand: '"MACY''S"'
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.brand_name desc 0
#     - trans.transaction_month
#     limit: 500
#     query_timezone: America/New_York
#     show_view_names: false
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: normal
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     title_hidden: true
#     row: 23
#     col: 0
#     width: 24
#     height: 8
#   - title: Transactions
#     name: Transactions
#     model: ce_transact
#     explore: trans
#     type: table
#     fields:
#     - trans.brand_name
#     - trans.count
#     filters:
#       trans.panel: '3'
#       trans.is_main_brand_shopper_min: 'Yes'
#     sorts:
#     - trans.count desc
#     limit: 500
#     dynamic_fields:
#     - table_calculation: of_total
#       label: "% of Total"
#       expression: "${trans.count}/index(${trans.count},1)"
#       value_format:
#       value_format_name: percent_1
#       _kind_hint: measure
#       _type_hint: number
#     show_view_names: false
#     show_row_numbers: false
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     listen:
#       Shopped at Brand: trans.main_brand
#       Shopping Period: trans.brand_compare_date
#       Shopped at Above Brand at Least __ Times: trans.brand_count_threshold_min
#       Compare Brands: trans.brand_name
#       Compare Period: trans.transaction_date
#       State: card.state_abbr
#       Panel: trans.panel
#     title_hidden: true
#     row: 6
#     col: 0
#     width: 6
#     height: 4
#   filters:
#   - name: Shopped at Brand
#     title: Shopped at Brand
#     type: field_filter
#     default_value: '"MACY''S"'
#     model: ce_transact
#     explore: trans
#     field: trans.main_brand
#     listens_to_filters: []
#     allow_multiple_values: true
#     required: false
#   - name: Shopping Period
#     title: Shopping Period
#     type: field_filter
#     default_value: 2017/01/01 to 2017/12/30
#     model: ce_transact
#     explore: trans
#     field: trans.brand_compare_date
#     listens_to_filters: []
#     allow_multiple_values: true
#     required: false
#   - name: Shopped at Above Brand at Least __ Times
#     title: Shopped at Above Brand at Least __ Times
#     type: field_filter
#     default_value: '4'
#     model: ce_transact
#     explore: trans
#     field: trans.brand_count_threshold_min
#     listens_to_filters: []
#     allow_multiple_values: true
#     required: false
#   - name: Compare Brands
#     title: Compare Brands
#     type: field_filter
#     default_value: NORDSTROM,JCPENNEY,"BLOOMINGDALE'S","MACY'S"
#     model: ce_transact
#     explore: trans
#     field: trans.brand_name
#     listens_to_filters: []
#     allow_multiple_values: true
#     required: false
#   - name: Compare Period
#     title: Compare Period
#     type: field_filter
#     default_value: '2017'
#     model: ce_transact
#     explore: trans
#     field: trans.transaction_date
#     listens_to_filters: []
#     allow_multiple_values: true
#     required: false
#   - name: State
#     title: State
#     type: field_filter
#     default_value: ''
#     model: ce_transact
#     explore: trans
#     field: card.state_abbr
#     listens_to_filters: []
#     allow_multiple_values: true
#     required: false
#   - name: Panel
#     title: Panel
#     type: field_filter
#     default_value: '3'
#     model: ce_transact
#     explore: trans
#     field: trans.panel
#     listens_to_filters: []
#     allow_multiple_values: true
#     required: false
