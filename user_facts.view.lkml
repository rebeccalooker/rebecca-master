view: user_facts {
  derived_table: {
    sql:
      SELECT u.id AS customer_id,
          u.first_name,
          u.last_name,
          u.age,
          u.gender,
          COUNT(oi.order_id) AS customer_total_orders,
          SUM(oi.sale_price) AS customer_total_revenue,
          MIN(oi.created_at) AS first_customer_order,
          MAX(oi.created_at) AS last_customer_order
        FROM ${users.SQL_TABLE_NAME} u
          JOIN ${order_items.SQL_TABLE_NAME} oi ON u.id = oi.user_id
        GROUP BY customer_id, first_name, last_name, u.age, u.gender
      ;;
    sql_trigger_value: SELECT CURRENT_DATE ;;
    indexes: ["customer_id"]
#     distribution_style: all
  }

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: fake_name {
    label: "{{ fake_name._sql | strip }} Name"
    type: string
    sql: 'Rebecca Tester' ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.first_name || ' ' || ${TABLE}.last_name ;;
  }

  dimension: customer_total_orders {
    type: number
    sql: ${TABLE}.customer_total_orders ;;
    hidden: yes
  }

  dimension: lifetime_orders {
    description: "Customer groupings by number of orders placed"
    case: {
      when: {
        sql: ${customer_total_orders} = 1 ;;
        label: "1 Order"
      }
      when: {
        sql: ${customer_total_orders} = 2 ;;
        label: "2 Orders"
      }
      when: {
        sql: ${customer_total_orders} >= 3 and ${customer_total_orders} <= 5 ;;
        label: "3-5 Orders"
      }
      when: {
        sql: ${customer_total_orders} >= 6 and ${customer_total_orders} <= 9 ;;
        label: "6-9 Orders"
      }
      when: {
        sql: ${customer_total_orders} >= 10 ;;
        label: "10+ Orders"
      }
      else: "N/A"
    }
    drill_fields: [user_profile*]
  }

  dimension: customer_total_revenue {
    type: number
    sql: ${TABLE}.customer_total_revenue ;;
    value_format_name: usd
    hidden: yes
  }

  dimension: lifetime_revenue {
    description: "Customer groupings by revenue brought in"
    case: {
      when: {
        sql: ${customer_total_revenue} >= 0.00 and ${customer_total_revenue} < 5.00 ;;
        label: "$0.00 - $4.99"
      }
      when: {
        sql: ${customer_total_revenue} >= 5.00 and ${customer_total_revenue} < 20.00 ;;
        label: "$5.00 - $19.99"
      }
      when: {
        sql: ${customer_total_revenue} >= 20.00 and ${customer_total_revenue} < 50.00 ;;
        label: "$20.00 - $49.99"
      }
      when: {
        sql: ${customer_total_revenue} >= 50.00 and ${customer_total_revenue} < 100.00 ;;
        label: "$50.00 - $99.99"
      }
      when: {
        sql: ${customer_total_revenue} >= 100.00 and ${customer_total_revenue} < 500.00 ;;
        label: "$100.00 - $499.99"
      }
      when: {
        sql: ${customer_total_revenue} >= 500.00 and ${customer_total_revenue} < 1000.00 ;;
        label: "$500.00 - $999.99"
      }
      when: {
        sql: ${customer_total_revenue} >= 1000.00 ;;
        label: "$1,000.00+"
      }
      else: "N/A"
    }
    drill_fields: [user_profile*]
  }

  dimension_group: first_order {
    description: "Date of customer's first order placed on the website"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year]
    sql: ${TABLE}.first_customer_order ;;
  }

  dimension_group: latest_order {
    description: "Date of customer's latest order placed on the website"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year]
    sql: ${TABLE}.last_customer_order ;;
  }

  dimension: is_active {
    description: "Whether or not the customer is 'active'"
    type: yesno
    sql: DATEDIFF(day, ${TABLE}.last_customer_order, current_date) <= 90 ;;
  }

  dimension: days_since_latest_order {
    description: "Number of days since customer's latest order"
    type: number
    sql: DATEDIFF(day, ${TABLE}.last_customer_order, current_date) ;;
  }

  dimension: ordered_recently {
    description: "Whether or not the customer made a recent order"
    type: yesno
    sql: ${days_since_latest_order} <= 30 ;;
  }

  dimension: repeat_customer {
    description: "Whether or not the customer has ordered from the website more than once"
    type: yesno
    sql: ${customer_total_orders} > 1 ;;
  }

  measure: count {
    description: "Number of customers"
    type: count
    drill_fields: [user_profile*]
    hidden: yes
  }

  measure: total_lifetime_orders {
    description: "Sum of orders from all customers in this group"
    type: sum
    sql: ${customer_total_orders} ;;
    drill_fields: [user_orders*]
  }

  measure: average_lifetime_orders {
    description: "Average number of orders from all customers in this group"
    type: average
    sql: ${customer_total_orders} ;;
    value_format_name: decimal_2
    drill_fields: [user_orders*]
  }

  measure: total_lifetime_revenue {
    description: "Sum of revenue from all customers in this group"
    type: sum
    sql: ${customer_total_revenue} ;;
    value_format_name: usd
    drill_fields: [user_profile*]
  }

  measure: average_lifetime_revenue {
    description: "Average revenue from all customers in this group"
    type: average
    sql: ${customer_total_revenue} ;;
    value_format_name: usd
    drill_fields: [user_profile*]
  }

  measure: average_days_since_latest_order {
    description: "Average days since the latest order from each customer in this group"
    type: average
    sql: ${days_since_latest_order} ;;
    drill_fields: [user_dates*]
  }

  # ------ Drill fields ------

  set: user_profile {
    fields: [
      customer_id,
      full_name,
      users.age,
      users.gender
    ]
  }

  set: user_orders {
    fields: [
      customer_id,
      full_name,
      orders_completed.order_id
    ]
  }

  set: user_dates {
    fields: [
      customer_id,
      full_name,
      first_order_date,
      latest_order_date
    ]
  }

}
