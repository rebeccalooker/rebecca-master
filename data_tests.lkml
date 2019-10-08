test: testing_event_data {
  explore_source: events {
    column: count { field: events.count }
    filters: {
      field: created_date
      value: "3 days"
    }
  }
  assert: recent_events_exist {
    expression: ${orders.count} > 0 ;;
  }
}
