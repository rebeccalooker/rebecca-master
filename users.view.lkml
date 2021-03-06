view: users {
  sql_table_name: public.USERS ;;

  parameter: all_or_completed_orders {
    type: unquoted
    allowed_value: { label: "All Orders" value: "all" }
    allowed_value: { label: "Completed Orders" value: "completed" }
  }

  filter: user_name_for_id {
    suggest_dimension: full_name
    sql: ${id} = (select ${id} from ${TABLE}
          where {% condition user_name_for_id %} ${full_name} {% endcondition %}) ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    html:     <div style="width:300px;text-align:center;background-color:#ffffff;border:5px solid #e3e3e3;vertical-align:middle;font-size:24px;@{html_format__style_bold_for_certain_kpis}"><div>{{rendered_value}}</div></div>;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    required_access_grants: [info_for_not_nothugo]
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
    # suggest_explore: users
    # suggest_dimension: users.last_name
  }

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: INITCAP(${TABLE}.last_name) ;;
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

  measure: count_of_users {
    type: count
    link: {
      label: "Testing"
      url: "{{ link }}"
    }
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

  measure: max_age {
    type: max
    sql: ${age} ;;
    html:     <div class="vis" style="text-align:center;background-color:#ffffff;border:5px solid #e3e3e3;vertical-align:middle;font-size:20px;@{html_format__style_bold_for_certain_kpis}">     <div>{{rendered_value}}</div></div>;;
  }

### Playing around with dynamic view selection for Wave HQ
#   measure: count_orders_dynamic {
#     type: number
#     sql: {% if all_or_completed_orders._parameter_value == 'all' %} ${dynamic_view.count_orders_made}
#           {% else %} ${dynamic_view.orders_completed} {% endif %} ;;
#   }
#
#   measure: count_orders_made {
#     type: number
#     sql: ${order_items.count_orders_made} ;;
#   }
#
#   measure: count_orders_completed {
#     type: number
#     sql: ${orders_completed.orders_completed} ;;
#   }


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
