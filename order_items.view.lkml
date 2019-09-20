## 2018-11-20 change the test comment

view: order_items {
  sql_table_name: public.ORDER_ITEMS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
#     html: <img src="https://avatars0.githubusercontent.com/u/1437874?s=400&v=4" height="42" width="42"> ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    suggest_explore: users
    suggest_dimension: users.first_name
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: create_month {
    type: date_month_name
    sql: ${TABLE}.created_at ;;
    hidden: yes
  }

  dimension: is_expensive_item_returned_in_past_30_days {
    type: yesno
    sql: ${sale_price} >= 100.00 and
        DATEDIFF(day, ${returned_date}, current_date) <= 30 ;;
    # hidden: yes
  }

  measure: count_orders_made {
    type: number
    sql: COUNT(${order_id}) ;;
    drill_fields: [
      users.id,
      users.first_name,
      users.last_name,
      order_id]
  }

  measure: count_items_ordered {
    label: "Items Ordered"
    type: count
    drill_fields: [detail*]
#     html: some other html ;;
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [product_pricing*]
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [product_pricing*]
  }

  measure: cumulative_total_sales {
    type: running_total
    sql: ${total_sale_price} ;;
    value_format_name: usd
    drill_fields: [product_pricing*]
  }

  measure: total_gross_revenue {
    type: sum
    sql: ${sale_price} ;;
    filters: {
      field: status
      value: "-Cancelled, -Returned"
      }
    value_format_name: usd
  }

  measure: average_gross_revenue {
    type: average
    sql: ${sale_price} ;;
    filters: {
      field: status
      value: "-Cancelled, -Returned"
        }
    value_format_name: usd
  }

  measure: total_gross_margin {
    type: sum
    sql: ${sale_price} - ${inventory_items.cost} ;;
    filters: {
      field: status
      value: "-Cancelled, -Returned"
      }
    value_format_name: usd
    drill_fields: [brand_details*]
  }

  measure: average_gross_margin {
    description: "For order items"
    type: average
    sql: ${sale_price} - ${inventory_items.cost} ;;
    filters: {
      field: status
      value: "-Cancelled, -Returned"
      }
    value_format_name: usd
    drill_fields: [product_pricing*]
  }

  measure: items_returned {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: returned_time
      value: "-NULL"
    }
    drill_fields: [detail*, sale_price]
    link: {
      label: "Explore Top 10 Results"
      url: "{% assign vis_config = '{
  \"type\": \"table\",
  \"show_view_names\": false,
  \"show_row_numbers\": false,
  \"truncate_column_names\": false,
  \"table_theme\": \"gray\",
  \"enable_conditional_formatting\": true,
  \"conditional_formatting\": [
    {
      \"type\": \"low to high\",
      \"value\": null,
      \"background_color\": null,
      \"font_color\": null,
      \"palette\": {
        \"name\": \"Custom\",
        \"colors\": [
          \"#FFFFFF\",
          \"#6e00ff\"
        ]},
      \"bold\": false,
      \"italic\": false,
      \"strikethrough\": false,
      \"fields\": [
        \"growth_rate\"
      ]},{
      \"type\": \"low to high\",
      \"value\": null,
      \"background_color\": null,
      \"font_color\": null,
      \"palette\": {
        \"name\": \"Custom\",
        \"colors\": [
          \"#FFFFFF\",
          \"#88ff78\"
        ]},
      \"bold\": false,
      \"italic\": false,
      \"strikethrough\": false,
      \"fields\": [
        \"percent_of_total\"
      ]}]}' %}
      {{ items_returned._link}}&sorts=order_items.sale_price+desc&limit=20"
    }
  }

  measure: item_return_rate {
    type: number
    sql: 1.000 * ${items_returned} / ${count_items_ordered} ;;
    value_format_name: percent_2
    drill_fields: [detail*]
  }

  measure: expensive_items_returned_in_past_30_days {
    type: count_distinct
    sql: ${is_expensive_item_returned_in_past_30_days} ;;
    filters: {
      field: is_expensive_item_returned_in_past_30_days
      value: "yes"
      }
    }

  measure: dynamic_order_finances {
    type: number
    label_from_parameter: order_finances
    sql:
      CASE WHEN {% parameter order_finances %} ='total_sale_price' THEN ${total_sale_price}
        WHEN {% parameter order_finances %} ='order_count' THEN ${count_orders_made}
        WHEN {% parameter order_finances %} ='average_sale_price' THEN ${average_sale_price}
        ELSE null
       END ;;
  }

  measure: monthly_target {
    type: number
    sql:
    (max(case when to_char(${TABLE}.created_at, 'YYYY-MM') in ('2016-01','2016-02', '2016-03') then 200000
    when to_char(${TABLE}.created_at, 'YYYY-MM') in ('2016-04','2016-05', '2016-06') then 215000
    when to_char(${TABLE}.created_at, 'YYYY-MM') in ('2016-07','2016-08', '2016-09') then 230000
    when to_char(${TABLE}.created_at, 'YYYY-MM') in ('2016-10','2016-11', '2016-12') then 245000
    else null end)) ;;
  }

  measure: latest_order {
    type: date_time
    sql: max(${created_time}) ;;
  }

  # ------ Parameters ------
  ## produce "FILTER-ONLY FIELDS" in frontend
  parameter: order_finances {
    allowed_value: {
      label: "Total Sale Price"
      value: "total_sale_price"
    }
    allowed_value: {
      label: "Order Count"
      value: "order_count"
    }
    allowed_value: {
      label: "Average Sale Price"
      value: "average_sale_price"
    }
  }

  parameter: agg_type {
    suggestions: ["Sum", "Average", "Min", "Max"]
    hidden: yes
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }

  set: product_pricing {
    fields: [
      id,
      inventory_items.product_name,
      sale_price,
      inventory_items.cost
    ]
  }

  set: brand_details {
    fields: [
      inventory_items.product_name,
      inventory_items.product_category,
      inventory_items.product_brand,
      inventory_items.product_facebook,
      inventory_items.product_department
    ]
  }
}
