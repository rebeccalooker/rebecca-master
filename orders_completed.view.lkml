include: "order_items.view"
view: dynamic_view {
  extends: [order_items, orders_completed]
  sql_table_name: {% if users.all_or_completed_orders._parameter_value == 'all' %} ${order_items.SQL_TABLE_NAME}
                  {% else %} ${orders_completed.SQL_TABLE_NAME} {% endif %} ;;

  dimension: item_id { primary_key: no }
}


view: orders_completed {
  derived_table: {
    sql:
      SELECT id, order_id, sale_price, returned_at, user_id
        FROM ${order_items.SQL_TABLE_NAME}
        WHERE status NOT IN ('Cancelled', 'Returned');;
    sql_trigger_value: SELECT CURRENT_DATE ;;
    indexes: ["id"]
    distribution_style: all
  }

  parameter: profit_or_margin {
    type: unquoted
    allowed_value: { label: "Average Order Profit" value: "profit" }
    allowed_value: { label: "Gross Margin %" value: "margin" }
  }

  dimension: item_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    hidden: yes
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    hidden: yes
  }

  dimension: returned_at {
    type: date
    sql: ${TABLE}.returned_at ;;
    hidden: yes
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  measure: orders_completed {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: dynamic_measure {
    type: number
    sql: {% if profit_or_margin._parameter_value == 'profit' %} ${average_order_profit}
          {% else %} ${gross_margin_percentage} {% endif %} ;;
    html: {% if profit_or_margin._parameter_value == 'profit' %} {{ average_order_profit._rendered_value }}
          {% else %} {{ gross_margin_percentage._rendered_value }} {% endif %} ;;
  }

  measure: gross_margin_percentage {
    type: number
    sql: SUM(${sale_price} - ${inventory_items.cost}) / SUM(${order_items.sale_price}) ;;
    value_format_name: percent_2
    drill_fields: [brand_details*]
  }

  measure: average_order_profit {
    type: number
    sql: (SUM(${sale_price} - ${inventory_items.cost})) / ${orders_completed} ;;
    value_format_name: usd
    drill_fields: [brand_details*]
  }

  set: product_pricing {
    fields: [
      item_id,
      inventory_items.product_name,
      inventory_items.product_brand,
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
