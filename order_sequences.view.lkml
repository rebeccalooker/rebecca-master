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
