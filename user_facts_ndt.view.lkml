# If necessary, uncomment the line below to include explore_source.
# include: "rebecca_fashionly.model.lkml"
# include: "order_items.view"

view: user_facts_ndt {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: rebecca_fashionly_default_datagroup
    distribution_style: even
    sortkeys: ["id"]
    explore_source: users {
      column: id {}
      column: count_orders_made { field: order_items.count_orders_made }
      column: total_gross_revenue { field: order_items.total_gross_revenue }
      column: items_returned { field: order_items.items_returned }
      column: average_sale_price { field: order_items.average_sale_price }
    }
  }
  dimension: id {
    type: number
    primary_key: yes
  }
  dimension: count_orders_made {
    type: number
  }
  dimension: total_gross_revenue {
    value_format: "$#,##0.00"
    type: number
  }
  dimension: items_returned {
    type: number
  }
  dimension: average_sale_price {
    value_format: "$#,##0.00"
    type: number
  }
}
