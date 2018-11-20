view: inventory_items {
  sql_table_name: public.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
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

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
    # html: <a href="https://www.google.com/search?q={{value}}" target="_blank"><button>{{value}}</button></a>
    #    ;;
    link: {
      label: "{{ value }} Dashboard"
      url: "https://sandboxcl.dev.looker.com/dashboards/484?Brand%20Name={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    drill_fields: [
      product_category,
      product_name
    ]
  }

  dimension: product_facebook {
    label: "Facebook Link"
    type: string
    sql: ${TABLE}.product_brand ;;
    html: <a href="https://www.facebook.com/search/top/?q={{value}}" target="_blank"><button>{{value}} Facebook</button></a>
        ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
    link: {
      label: "Category Link~"
      url: "http://www.google.com/search?q={{value}}"
      icon_url: "https://files.slack.com/files-pri/T024F428S-F8YLV4GDR/image.png"
    }
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  measure: count {
    type: count
    drill_fields: [inventory_details*]
  }

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
    value_format_name: usd
    drill_fields: [inventory_details*]
  }

  measure: average_cost {
    type: average
    sql: ${cost} ;;
    value_format_name: usd
    drill_fields: [inventory_details*]
  }

  # ----- Sets of fields for drilling ------
  set: inventory_details {
    fields: [
      id,
      product_name,
      products.id,
      products.name,
      order_items.count]
  }
}
