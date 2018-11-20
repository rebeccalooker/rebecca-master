view: z_bughunt_1 {
  derived_table: {
    sql: select user_id,
      min(created_at) as first_order_date,
      max(created_at) as last_order_date,
      count(order_id) as count_orders_made,
      count(id) as count_items_ordered,
      sum(sale_price) as lifetime_sales,
      avg(sale_price) as avg_item_price
from public.order_items
group by 1
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: first_order_date {
    type: time
    sql: ${TABLE}.first_order_date ;;
  }

  dimension_group: last_order_date {
    type: time
    sql: ${TABLE}.last_order_date ;;
  }

  dimension: count_orders_made {
    type: number
    sql: ${TABLE}.count_orders_made ;;
  }

  dimension: count_items_ordered {
    type: number
    sql: ${TABLE}.count_items_ordered ;;
  }

  dimension: lifetime_sales {
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  dimension: avg_item_price {
    type: number
    sql: ${TABLE}.avg_item_price ;;
  }

  set: detail {
    fields: [
      user_id,
      first_order_date_time,
      last_order_date_time,
      count_orders_made,
      count_items_ordered,
      lifetime_sales,
      avg_item_price
    ]
  }
}
