view: products {
  sql_table_name: public.PRODUCTS ;;

# ------ Filters ------
  filter: main_brand {
    type: string
    suggest_dimension: brand
  }

# ------ Dimensions ------
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "{{ value }} Dashboard"
      url: "https://sandboxcl.dev.looker.com/dashboards/484?Brand%20Name={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    order_by_field: brand_order
  }

  dimension: brand_order {
    type: string
    sql: CASE WHEN {% parameter main_brand %} = '' THEN ${brand}
             WHEN {% condition main_brand %} ${brand} {% endcondition %} THEN 'first' || '-' || ${brand}
          ELSE 'last'
          END ;;
    hidden: yes
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    link: {
      label: "{{ value }} Dashboard"
      url: "https://sandboxcl.dev.looker.com/dashboards/484?Category={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

# ------ Measures ------
  measure: count {
    type: count
    drill_fields: [id, name
      , distribution_centers.id
      , distribution_centers.name
      , inventory_items.count
      ]
  }

##   Can a dimension be used as a parameter?
#   measure: total_brand_sales {
#     type: sum
#     sql: CASE WHEN ${name} LIKE {% parameter name %}
#                 THEN ${order_items.sale_price}
#               ELSE null
#               END ;;
#  }
}