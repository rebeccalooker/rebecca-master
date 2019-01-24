view: month_series {
  derived_table: {
    sql: select extract(year from date) || '-' || lpad(extract(month from date),2,0) as month
        FROM ${date_series.SQL_TABLE_NAME} ;;
    sql_trigger_value: select current_date ;;
    distribution_style: all
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }
}

view: date_series {
  derived_table: {
    distribution_style: all
    sortkeys: ["date"]
    sql_trigger_value:  select current_date ;;
    sql: -- ## 1) Create a Date table with a row for each date.
      SELECT '2014-01-01'::DATE + d AS date
      FROM
        (SELECT ROW_NUMBER() OVER(ORDER BY id) -1 AS d
        FROM ${order_items.SQL_TABLE_NAME}
        ORDER BY id LIMIT 2190) AS  d     -- 365 * 6 years = 2190 days
       ;;
  }

  dimension_group: calendar {
    type: time
    timeframes: [date, month]
    sql: ${TABLE}.date ;;
  }
}
