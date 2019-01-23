view: month_series {
  derived_table: {
    sql: select distinct date_format(date, '%Y-%m') as month
        FROM ${date_series.SQL_TABLE_NAME} ;;
    sql_trigger_value: select curdate() ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }
}

view: date_series {
  derived_table: {
    sql: SELECT date
        FROM (
            SELECT curdate() - interval (a.a + (10 * b.a) + (100 * c.a) + (1000 * d.a) + (10000 * e.a)) day as date
            FROM (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a
            CROSS JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as b
            CROSS JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as c
            CROSS JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as d
            CROSS JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as e
             ) dates
        WHERE date >= '2012-01-01'
        ORDER BY date ;;
    sql_trigger_value: select curdate() ;;
  }

  dimension_group: calendar {
    type: time
    timeframes: [date, month]
    sql: ${TABLE}.date ;;
  }
}
