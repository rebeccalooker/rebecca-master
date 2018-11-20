# ------ This makes sure Looker can find the view to extend ------
include: "users*"
# ----------------------------------------------------------------

view: users_basic {
  view_label: "Customers Basic"
  extends: [users]

  dimension: email {
    hidden: yes
  }

  dimension: customer_location {
    hidden: yes
  }

  # ------ Change this definition from USERS ------
  dimension: is_new_customer {
    type: yesno
    sql: DATEDIFF(day, ${created_date}, current_date) <= 30 ;;
  }
  # -----------------------------------------------

}
