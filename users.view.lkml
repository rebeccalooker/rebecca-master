view: users {
  sql_table_name: public.USERS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_group {
    type: tier
    tiers: [15, 26, 36, 51, 66]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    group_label: "Address"
    type: string
    sql: ${TABLE}.city ;;
    hidden: yes
  }

  dimension: country {
    group_label: "Address"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    hidden: yes
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
    convert_tz: no
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    hidden: yes
  }

  dimension: first_name {
    type: string
    sql: INITCAP(${TABLE}.first_name) ;;
    suggest_explore: users
    suggest_dimension: users.last_name
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    hidden: no
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
    hidden: yes
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
    hidden: yes
  }

  dimension: customer_location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
    hidden: yes
  }

  dimension: state {
    group_label: "Address"
    type: string
    sql: ${TABLE}.state ;;
    hidden: yes
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    group_label: "Address"
    type: zipcode
    sql: ${TABLE}.zip ;;
    hidden: yes
  }

  dimension: is_new_customer {
    type: yesno
    sql: ${days_since_signup} <= 90 ;;
  }

  # ------ PS Case Study, Use Case #2 ------
  dimension: days_since_signup {
    type: number
#     expression: diff_days(${created_date}, now()) ;;
    sql: DATEDIFF(day, ${created_date}, current_date) ;;
    group_label: "Registration"
  }

  dimension: signup_days_cohort {
    type: tier
    sql: ${days_since_signup} ;;
    tiers: [31, 61, 181, 366, 731]
    style: integer
    group_label: "Registration"
  }

  dimension: months_since_signup {
    type: number
    sql: (DATEDIFF(day, ${created_date}, current_date)) / 30 ;;
    group_label: "Registration"
  }

  dimension: signup_months_cohort {
    type: tier
    sql: ${months_since_signup} ;;
    tiers: [1, 6, 12, 24, 36, 60]
    style: integer
    group_label: "Registration"
  }
  # ----------------------------------------

  measure: count {
    type: count
#     html:  {{linked_value}} ;;
    drill_fields: [user_details*, events.count]
  }

  measure: number_of_customers_returning_items {
    type: count_distinct
    sql: ${returns.user_id} ;;
    drill_fields: [user_details*]
  }

  measure: percent_of_users_with_returns {
    type: count_distinct
    sql: ${returns.user_id} / ${id} ;;
    value_format_name: percent_2
    drill_fields: [user_details*, order_items.order_id, inventory_items.product_name]
  }

  measure: average_spend_per_customer {
    type: number
    sql: SUM(${order_items.sale_price}) / COUNT(${id}) ;;
    value_format_name: usd
    drill_fields: [user_details*]
  }

  measure: total_sales_new_customers {
    type: sum
    sql: ${order_items.sale_price} ;;
    filters: {
      field: is_new_customer
      value: "yes"
    }
    value_format_name: usd
    drill_fields: [order_items.product_pricing*]
  }

  # ------ PS Case Study, Use Case #2 ------
  measure: average_days_since_signup {
    type: average
    sql: ${days_since_signup} ;;
  }

  measure: average_months_since_signup {
    type: average
    sql: ${months_since_signup} ;;
    value_format_name: decimal_1
  }
  # ----------------------------------------

  # ------ Filter ------
  filter: signup_period_a {
    type: date
  }

  filter: signup_period_b {
    type: date
  }
  # -----------------------

  dimension: is_in_signup_period_a {
    type: yesno
    sql: ${id} in (select ${id} from USERS
                  where {% condition signup_period_a %} ${created_date} {% endcondition %}) ;;
  }

  dimension: is_in_signup_period_b {
    type: yesno
    sql: ${id} in (select ${id} from USERS
      where {% condition signup_period_b %} ${created_date} {% endcondition %}) ;;
  }

  measure: count_of_signup_period_a {
    type: count
    filters: { field: is_in_signup_period_a value: "Yes" }
  }

  measure: count_of_signup_period_b {
    type: count
    filters: { field: is_in_signup_period_b value: "Yes" }
  }


  set: user_details {
    fields: [
      id,
      first_name,
      last_name,
      age_group,
      gender,
      order_items.count
    ]
  }
}
