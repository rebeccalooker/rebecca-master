# ------ This makes sure the LDE can find the view to extend ------
include: "users*"
# -----------------------------------------------------------------

view: users_ext {
  extends: [users]

  dimension: city {
    hidden: no
  }

  dimension: country {
    hidden: no
  }

  dimension: email {
    hidden: no
  }

  dimension: last_name {
    hidden: no
  }

  dimension: latitude {
    hidden: no
  }

  dimension: longitude {
    hidden: no
  }

  dimension: customer_location {
    hidden: no
  }

  dimension: state {
    hidden: no
  }

  dimension: zip {
    hidden: no
  }

  dimension: is_new_customer {
    sql: ${days_since_signup} <= 60 ;;
  }
}
