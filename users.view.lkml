## 2018-11-20 test comment

view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    group_label: "{% if  _user_attributes[\"first_name\"] == 'Rebecca' %}
             {% else %} 'Some Label' {% endif %}"
    label: "{% if  _user_attributes[\"first_name\"] == 'Rebecca' %}
             {% else %} 'Age' {% endif %}"
  }

  dimension: age_group {
    type: tier
    tiers: [15, 26, 36, 51, 66]
    style: integer
    sql: ${age} ;;
    group_label: "{% if  _user_attributes[\"first_name\"] == 'Rebecca' %}
    {% else %} 'Some Label' {% endif %}"
  }

  dimension: city {
    group_label: "Address"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    group_label: "Address"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: created_date_limit {
    type: yesno
    sql: ${created_raw} <= (select max(${created_raw}) from ${TABLE}) ;;
  }

  dimension: created_quarter_2 {
    type: date_quarter
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    # html: <span style="width:30px;background-color: red;">{{value}}</span> ;;
    html: <div style="width:30px">{{value}}</div> ;;
    tags: ["email"]
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
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
  }

  dimension: state {
    group_label: "Address"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    group_label: "Address"
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: is_new_customer {
    type: yesno
    sql: ${days_since_signup} <= 90 ;;
  }

  # ------ PS Case Study, Use Case #2 ------
  dimension: days_since_signup {
    type: number
    expression: diff_days(${users.created_date}, now()) ;;
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
    label: "{{ _filters['users.gender'] }} Users Count"
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
  filter: months_ago_when_customer_signed_up {
    suggest_explore: users
    suggest_dimension: months_since_signup
  }
  # -----------------------

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


# view: Male {
#   sql_table_name: public.users ;;
#
#   dimension: id {
#     type: number
#     primary_key: yes
#     sql: ${TABLE}.id ;;
#     hidden: yes
#   }
#
#   dimension: gender {
#     type: string
#     sql: ${TABLE}.gender ;;
#     hidden: yes
#   }
#
#   measure: count {
#     label: "{{ _view._name }} Users Count"
#     type: count
#     filters: { field: gender value: "Male" }
# #     html:  {{linked_value}} ;;
# #     drill_fields: [user_details*, events.count]
#   }
# }
#
# view: Female {
#   sql_table_name: public.users ;;
#
#   dimension: id {
#     type: number
#     primary_key: yes
#     sql: ${TABLE}.id ;;
#     hidden: yes
#   }
#
#   dimension: gender {
#     type: string
#     sql: ${TABLE}.gender ;;
#     hidden: yes
#   }
#
#   measure: count {
#     label: "{{ _view._name }} Users Count"
#     type: count
#     filters: { field: gender value: "Female" }
# #     html:  {{linked_value}} ;;
# #     drill_fields: [user_details*, events.count]
#   }
# }
