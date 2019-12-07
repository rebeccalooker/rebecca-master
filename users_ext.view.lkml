# ------ This makes sure the LDE can find the views to extend ------
include: "users.view"
include: "order_items.view"
include: "events.view"
# ------------------------------------------------------------------

view: users_ext {
  sql_table_name: {% if created_date._in_query %}
                    public.users
                  {% elsif created_month._in_query %}
                    public.order_items
                  {% else %}
                    public.events
                  {% endif %} ;;
  extends: [users, order_items, events]
}
