# include: "/Model/rebecca.model"

test: test_recent_event_data {
  explore_source: events {
    column: count { field: events.count }
    filters: {
#       field: created_date
      field: events.created_date
      value: "3 days"
    }
  }
  assert: recent_events_exist {
    expression: ${events.count} > 0 ;;
  }
}

test: test_2018_event_data {
  explore_source: events {
    column: count { field: events.count }
    filters: {
      field: events.created_date
      value: "2018"
    }
  }
  assert: 2018_event_data_is_correct {
    expression: ${events.count} = 843862 ;;
  }
}
#
