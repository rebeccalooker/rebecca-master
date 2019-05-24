## Fills in null "Previous Order Date" values even when user made no orders in a given month.
view: monthly_user_orders {
  derived_table: {
    sql_trigger_value: select current_date ;;
    distribution_style: all
    sql: SELECT m1.month
          , m1.user_id
          , coalesce(m1.num_orders_this_month, 0) as num_orders_this_month
          , case when m1.previous_order_date is null then (
              select max(previous_order_date)
              from ${monthly_user_orders_with_nulls.SQL_TABLE_NAME} m2
              where m1.user_id = m2.user_id and m2.month < m1.month
              ) else m1.previous_order_date end as previous_order_date
        FROM ${monthly_user_orders_with_nulls.SQL_TABLE_NAME} m1
        ;;
  }

  dimension: pk {
    type: string
    sql: ${month} || ${user_id} ;;
    primary_key: yes
    hidden: yes
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: num_orders_this_month {
    type: number
    sql: ${TABLE}.num_orders_this_month ;;
  }

  dimension: previous_order_date {
    type: date
    sql: ${TABLE}.previous_order_date ;;
  }

  dimension: is_current {
    type: yesno
    sql: ${num_orders_this_month} > 0 and datediff(month, ${previous_order_date}, cast(${month} || '-01' as date)) = 1 ;;
  }

  dimension: is_sleeping {
    type: yesno
    sql: ${num_orders_this_month} = 0 and datediff(month, ${previous_order_date}, cast(${month} || '-01' as date)) >= 1 ;;
  }

  dimension: is_resuscitated {
    type: yesno
    sql: ${num_orders_this_month} > 0 and datediff(month, ${previous_order_date}, cast(${month} || '-01' as date)) > 1 ;;
  }

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: count_users_current {
    type: count_distinct
    sql: ${user_id} ;;
    filters: { field: is_current value: "Yes" }
  }

  measure: count_users_sleeping {
    type: count_distinct
    sql: ${user_id} ;;
    filters: { field: is_sleeping value: "Yes" }
  }

  measure: count_users_resuscitated {
    type: count_distinct
    sql: ${user_id} ;;
    filters: { field: is_resuscitated value: "Yes" }
  }

  measure: count_orders {
    type: sum
    sql: ${num_orders_this_month} ;;
  }
}


## Contains null values for "Previous Order Date" when user made no orders in a given month.
view: monthly_user_orders_with_nulls {
  derived_table: {
    sql_trigger_value: select current_date ;;
    distribution_style: all
    sql: SELECT months_and_users.month AS month
          , months_and_users.user_id
          , user_orders.num_orders_this_month
          , user_orders.previous_order_date
        FROM ${months_and_users.SQL_TABLE_NAME} months_and_users
        LEFT OUTER JOIN ${user_orders.SQL_TABLE_NAME} user_orders
            on months_and_users.month = user_orders.order_month
            and months_and_users.user_id = user_orders.user_id
        ;;
  }
}


view: months_and_users {
  derived_table: {
    sql_trigger_value: select current_date ;;
    distribution_style: all
    sql: SELECT distinct month_series.month  AS month
          , order_items.user_id
        FROM ${month_series.SQL_TABLE_NAME} month_series
        CROSS JOIN ${order_items.SQL_TABLE_NAME} order_items
        ;;
  }
}


view: user_orders {
  derived_table: {
    sql_trigger_value: select current_date ;;
    distribution_style: all
    sql: SELECT TO_CHAR(DATE_TRUNC('month', o1.created_at ), 'YYYY-MM') as order_month
          , o1.user_id  AS user_id
          , count(distinct o1.order_id) as num_orders_this_month
          , max(o2.created_at) as previous_order_date
        FROM ${order_items.SQL_TABLE_NAME} o1
        LEFT JOIN ${order_items.SQL_TABLE_NAME} o2 on o1.user_id = o2.user_id
                      and date_trunc('month', o1.created_at) > date_trunc('month', o2.created_at)
        GROUP BY 1, 2
        ;;
  }

  dimension: order_month {
    type: string
    sql: ${TABLE}.order_month ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: num_orders_this_month {
    type: number
    sql: ${TABLE}.num_orders_this_month ;;
  }

  dimension: previous_order_date {
    type: date
    sql: ${TABLE}.previous_order_date ;;
  }
}


# view: order_sequences {
#   derived_table: {
#     sql: WITH order_days as
#           (WITH order_facts as
#             (SELECT user_id, order_id, created_at, order_amount,
#                     ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at) as order_sequence_number
#             FROM
#               (SELECT user_id, order_id, created_at, SUM(sale_price) as order_amount
#               FROM ${order_items.SQL_TABLE_NAME}
#               GROUP BY user_id, order_id, created_at)
#             )
#
#             SELECT a.*, DATEDIFF(DAY, a.created_at, b.created_at) as days_until_next_order
#             FROM order_facts a
#             LEFT JOIN order_facts b
#               ON b.user_id = a.user_id and b.order_sequence_number = a.order_sequence_number + 1
#             )
#
#         SELECT *, MIN(days_until_next_order) over (
#             PARTITION BY user_id ORDER BY order_sequence_number asc
#             rows between unbounded preceding and unbounded following
#           ) as min_inter_order_days
#         FROM order_days
#           ;;
#
#     sql_trigger_value: select current_date ;;
#     distribution_style: all
#   }
#
#   dimension: primary_key {
#     primary_key: yes
#     type: string
#     sql: ${user_id} || '-' || ${order_id} ;;
#     hidden: yes
#   }
#
#   dimension: user_id {
#     type: number
#     sql: ${TABLE}.user_id ;;
#     hidden: yes
#   }
#
#   dimension: order_id {
#     type: number
#     sql: ${TABLE}.order_id ;;
#     hidden: yes
#   }
#
#   dimension_group: created {
#     type: time
#     sql: ${TABLE}.created_at ;;
#     hidden: yes
#   }
#
#   dimension: order_amount {
#     type: number
#     sql: ${TABLE}.order_amount ;;
#     hidden: yes
#   }
#
#   dimension: order_sequence_number {
#     type: number
#     sql: ${TABLE}.order_sequence_number ;;
#   }
#
#   dimension: days_until_next_order {
#     type: number
#     sql: ${TABLE}.days_until_next_order ;;
#   }
#
#   dimension: min_inter_order_days {
#     label: "Individual Min Days Between Orders"
#     type: number
#     sql: ${TABLE}.max_inter_order_days ;;
#   }
#
#   dimension: is_first_purchase {
#     type: yesno
#     sql: ${order_sequence_number} = 1 ;;
#   }
#
#   dimension: has_subsequent_order {
#     type: yesno
#     sql: ${order_sequence_number} IS NOT NULL ;;
#   }
#
#   dimension: is_quick_repurchase_customer {
#     type: yesno
#     sql: ${min_inter_order_days} <= 60 ;;
#   }
#
#   measure: count_orders {
#     type: count
#     drill_fields: [detail*]
#     hidden: yes
#   }
#
#   measure: avg_days_between_orders {
#     type: average
#     sql: ${days_until_next_order} ;;
#     drill_fields: [detail*]
#   }
#
#   measure: max_days_between_orders {
#     type: max
#     sql: ${days_until_next_order} ;;
#   }
#
#   set: detail {
#     fields: [
#       user_id,
#       order_id,
#       created_time,
#       order_amount,
#       order_sequence_number,
#       days_until_next_order
#     ]
#   }
#
# }
