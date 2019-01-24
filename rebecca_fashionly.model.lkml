connection: "thelook_events_redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: rebecca_fashionly_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: rebecca_fashionly_default_datagroup

# explore: bsandell {}

# explore: company_list {}

# explore: distribution_centers {}

# explore: events {
#  join: users {
#    type: left_outer
#    sql_on: ${events.user_id} = ${users.id} ;;
#    relationship: many_to_one
#  }
# }

# explore: inventory_items {
#  join: products {
#    type: left_outer
#    sql_on: ${inventory_items.product_id} = ${products.id} ;;
#    relationship: many_to_one
#  }

#  join: distribution_centers {
#    type: left_outer
#    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#    relationship: many_to_one
#  }
# }

explore: order_items {
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: returns {
    type: left_outer
    sql_on: ${order_items.id} = ${returns.item_id} ;;
    relationship: one_to_one
  }

  join: orders_completed {
    view_label: "Order Items"
    type: left_outer
    sql_on: ${order_items.id} = ${orders_completed.item_id} ;;
    relationship: one_to_one
  }
}

explore: products {}

explore: product_comparisons {
  view_label: "Product"
#   join: distribution_centers {
#    type: left_outer
#    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#    relationship: many_to_one
#   }
#
#   join: inventory_items {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: one_to_many
#   }
#
#   join: order_items {
#     type: left_outer
#     sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
#     relationship: one_to_many
#   }
}

explore: users {
  fields: [
    ALL_FIELDS*,
    -order_items.user_id,
    -order_items.id,
    -inventory_items.id,
    -inventory_items.product_distribution_center_id,
    -inventory_items.product_id,
    -inventory_items.created_date
    ]

#   always_filter: {
#     filters: {
#       field: users.id
#       value: "NOT NULL"
#     }
#   }

  join: returns {
    type: left_outer
    sql_on: ${users.id} = ${returns.user_id} ;;
    relationship: one_to_one
  }

  join: order_items {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }

  join: orders_completed {
    view_label: "Orders"
    type: left_outer
    sql_on: ${users.id} = ${orders_completed.user_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

#   join: event_facts {
#     view_label: "Session Details"
#     type: left_outer
#     sql_on: ${users.id} = ${event_facts.user_id} ;;
#     relationship: one_to_many
#   }

  join: user_facts {
    view_label: "Customer Facts"
    type: inner
    sql_on: ${users.id} = ${user_facts.customer_id} ;;
    relationship: one_to_one
  }

#   join: user_order_sequences {
#     view_label: "Customer Facts"
#     from: order_sequences
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${users.id} = ${user_order_sequences.user_id} ;;
#     fields: [user_order_sequences.min_inter_order_days,
#       user_order_sequences.is_quick_repurchase_customer,
#       user_order_sequences.avg_days_between_orders,
#       user_order_sequences.max_days_between_orders]
#   }

#   join: order_sequences {
#     view_label: "Orders"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${users.id} = ${order_sequences.user_id}
#             and ${order_items.order_id} = ${order_sequences.order_id} ;;
#     fields: [order_sequences.order_sequence_number,
#       order_sequences.days_until_next_order,
#       order_sequences.is_first_purchase,
#       order_sequences.has_subsequent_order]
#   }

#   join: Male {
#     view_label: "Customer Details"
#     sql_on: ${users.id} = ${Male.id} ;;
#     type: inner
#     relationship: one_to_one
#   }
#
#   join: Female {
#     view_label: "Customer Details"
#     sql_on: ${users.id} = ${Female.id} ;;
#     type: inner
#     relationship: one_to_one
#   }
}

explore: users_ext {
  label: "Users+"
  extends: [users]          ## activate the joins so you don't need to retype them
  view_name: users      ## set view name back to the original explore's base view name
  from: users_ext
  view_label: "Users"
}

explore: order_items_basic {
  extends: [order_items]
  view_name: order_items
  join: users {
    from: users_ext
    type: inner
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  hidden: yes
}

explore: monthly_user_orders {}
