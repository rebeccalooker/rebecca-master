view: product_comparisons {
  derived_table: {
    sql: SELECT p.brand, p.category, oi.created_at
          , count(oi.id) as volume_sold
          , sum(oi.sale_price) as revenue
        FROM public.products as p
          JOIN public.inventory_items as ii
            ON p.id = ii.product_id
          JOIN public.order_items as oi
            ON ii.id = oi.inventory_item_id
        WHERE p.brand != {% parameter compare_brand %}
        {% if compare_category._is_filtered %}
          AND {% condition compare_category %} p.category {% endcondition %}
          {% endif %}
        GROUP BY 1, 2, 3
        ;;
  }

  dimension: brand {
    primary_key: yes
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "{{ value }} Dashboard"
      url: "https://sandboxcl.dev.looker.com/dashboards/484?Brand%20Name={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
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

  dimension_group: purchase {
    type: time
    timeframes: [raw
      , date
      , month
      , quarter
      , year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
    value_format_name: usd
    hidden: yes
  }

  dimension: volume_sold {
    type: number
    sql: ${TABLE}.volume_sold ;;
    hidden: yes
  }

#   dimension: brand_and_category {
#     description: "Indicates whether the selected Compare Brand has products for the selected Compare Category"
#     type: yesno
#     sql: ${brand} IN (
#         SELECT ${brand}
#         FROM ${TABLE}
#         WHERE
#           {% condition compare_category %} ${category} {% endcondition %}
#           and {% parameter compare_brand %} = ${brand}
#         ) ;;
#   }

#   dimension: category_in_brand {
#     description: "Brand in the same selected Compare Category"
#     type: string
#     sql: ${category} IN (
#         SELECT ${category}
#         FROM ${TABLE}
#         WHERE
#           {% condition compare_brand %} ${brand} {% endcondition %}
#         ) ;;
#     hidden: yes
#   }

# ------ Measures ------
  measure: total_revenue {
    type: sum
    sql: ${revenue} ;;
    value_format_name: usd
  }

  measure: total_volume_sold {
    type: sum
    sql: ${volume_sold} ;;
  }

#   measure: count_items_ordered_for_main_brand {
#     description: "Uses 'Compare Brand' filter"
#     type: count_distinct
#     sql: ${order_items.id} ;;
#     filters: {
#       field: brand
#       value: "{% parameter compare_brand %}"
#     }
#   }
#
#   measure: total_revenue_for_main_brand {
#     type: sum
#     sql: ${order_items.sale_price} ;;
#     filters: {
#       field: brand
#       value: "{% parameter compare_brand %}"
#     }
#   }

# ------ Filters ------
  filter: compare_category {
    description: "Product category for comparison"
    type: string
    suggest_dimension: category
  }

  parameter: compare_brand {
    description: "Main brand for comparison"
    type: string
    suggest_dimension: brand
  }
}
