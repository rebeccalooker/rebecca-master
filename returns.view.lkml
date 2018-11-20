view: returns {
  derived_table: {
    sql:
      SELECT u.id AS customer_id, u.first_name, u.last_name, oi.order_id, oi.id AS item_id
        FROM users u
          JOIN order_items oi ON u.id = oi.user_id
        WHERE oi.returned_at IS NOT NULL;;
    sql_trigger_value: SELECT CURRENT_DATE ;;
    indexes: ["customer_id"]
    distribution_style: all
  }

  dimension: user_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.first_name || ' ' || ${TABLE}.last_name ;;
    hidden: yes
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    hidden: yes
  }

  dimension: item_id {
    type: number
    sql: ${TABLE}.item_id ;;
    hidden: yes
  }

}

# view: users_with_returns {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
