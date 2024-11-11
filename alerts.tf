resource "azurerm_monitor_scheduled_query_rules_alert_v2" "main" {
  for_each = var.scheduled_query_alerts

  auto_mitigation_enabled          = each.value.auto_mitigation_enabled
  description                      = each.value.description
  enabled                          = each.value.enabled
  evaluation_frequency             = each.value.evaluation_frequency
  location                         = data.azurerm_resource_group.main.location
  name                             = each.value.name
  resource_group_name              = data.azurerm_resource_group.main.name
  scopes                           = [data.azurerm_cognitive_account.main.id]
  severity                         = each.value.severity
  skip_query_validation            = each.value.skip_query_validation
  tags                             = var.tags
  target_resource_types            = each.value.target_resource_types
  window_duration                  = each.value.window_duration
  workspace_alerts_storage_enabled = each.value.workspace_alerts_storage_enabled

  dynamic "criteria" {
    for_each = each.value.criteria
    content {
      operator                = criteria.value.operator
      threshold               = criteria.value.threshold
      time_aggregation_method = criteria.value.time_aggregation_method
      query                   = criteria.value.query
      resource_id_column      = criteria.value.resource_id_column
      metric_measure_column   = criteria.value.metric_measure_column
      failing_periods {
        minimum_failing_periods_to_trigger_alert = criteria.value.failing_periods.minimum_failing_periods_to_trigger_alert
        number_of_evaluation_periods             = criteria.value.failing_periods.number_of_evaluation_periods
      }
      dynamic "dimension" {
        for_each = { for d in criteria.value.dimension : d.name => d }
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  action {
    action_groups = [var.action_group_id]
  }
}


