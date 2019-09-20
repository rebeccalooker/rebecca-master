include: "order_items.view"
include: "users.view"

view: dynamic_table {
  extends: [order_items, users]
  sql_table_name: public.{% if _user_attributes['is_internal'] == "1" %}
                          {% if _user_attributes['my_view_override'].size > 0 %}
                          {{ _user_attributes['my_view_override'] }}
                          {% else %} {{ _user_attributes['my_view'] }} {% endif %}
                         {% else %} {{ _user_attributes['my_view'] }} {% endif %};;
}
