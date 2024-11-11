metric_alerts = {
  "DocumentsProcessedCount" = {
    name          = "DocumentsProcessedCount-alert"
    description   = "Document processed count alert"
    enabled       = true
    auto_mitigate = true
    severity      = 3
    frequency     = "PT15M"
    window_size   = "PT15M"
    criteria = [
      {
        metric_namespace       = "Microsoft.Search/searchServices"
        metric_name            = "DocumentsProcessedCount"
        aggregation            = "Total"
        operator               = "GreaterThan"
        threshold              = 100
        skip_metric_validation = false
      }
    ]
  },
  "SearchLatency" = {
    name          = "SearchLatency-alert"
    description   = "Search latency alert"
    enabled       = true
    auto_mitigate = true
    severity      = 3
    frequency     = "PT30M"
    window_size   = "PT30M"
    criteria = [
      {
        metric_namespace       = "Microsoft.Search/searchServices"
        metric_name            = "SearchLatency"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 1 / 10
        skip_metric_validation = false
      }
    ]
  },
  "SearchQueriesPerSecond" = {
    name          = "SearchQueriesPerSecond-alert"
    description   = "Search queries per second alert"
    enabled       = true
    auto_mitigate = true
    severity      = 3
    frequency     = "PT30M"
    window_size   = "PT30M"
    criteria = [
      {
        metric_namespace       = "Microsoft.Search/searchServices"
        metric_name            = "SearchQueriesPerSecond"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 10
        skip_metric_validation = false
      }
    ]
  },
  "ThrottledSearchQueriesPercentage" = {
    name          = "ThrottledSearchQueriesPercentage-alert"
    description   = "Throttled search queries percentage alert"
    enabled       = true
    auto_mitigate = true
    severity      = 3
    frequency     = "PT30M"
    window_size   = "PT30M"
    criteria = [
      {
        metric_namespace       = "Microsoft.Search/searchServices"
        metric_name            = "ThrottledSearchQueriesPercentage"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 0
        skip_metric_validation = false
      }
    ]
  }
}
