resource "azurerm_resource_group" "main" {
  location = "uk-south"
  name     = "test-rg"
  tags     = {}
}

resource "azurerm_monitor_metric_alert" "main" {
  for_each = var.metric_alerts

  name                     = each.value.name
  description              = each.value.description
  resource_group_name      = azurerm_resource_group.main.name
  scopes                   = each.value.scopes
  enabled                  = each.value.enabled
  auto_mitigate            = each.value.auto_mitigate
  severity                 = each.value.severity
  frequency                = each.value.frequency
  window_size              = each.value.window_size
  target_resource_type     = each.value.target_resource_type
  target_resource_location = each.value.target_resource_location
  tags                     = var.tags

  dynamic "criteria" {
    for_each = each.value.criteria
    content {
      metric_namespace       = criteria.value.metric_namespace
      metric_name            = criteria.value.metric_name
      aggregation            = criteria.value.aggregation
      operator               = criteria.value.operator
      threshold              = criteria.value.threshold
      skip_metric_validation = criteria.value.skip_metric_validation
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

  dynamic "dynamic_criteria" {
    for_each = each.value.dynamic_criteria
    content {
      metric_namespace         = dynamic_criteria.value.metric_namespace
      metric_name              = dynamic_criteria.value.metric_name
      aggregation              = dynamic_criteria.value.aggregation
      operator                 = dynamic_criteria.value.operator
      alert_sensitivity        = dynamic_criteria.value.alert_sensitivity
      evaluation_total_count   = dynamic_criteria.value.evaluation_total_count
      evaluation_failure_count = dynamic_criteria.value.evaluation_failure_count
      ignore_data_before       = dynamic_criteria.value.ignore_data_before
      skip_metric_validation   = dynamic_criteria.value.skip_metric_validation
      dynamic "dimension" {
        for_each = dynamic_criteria.value.dimension
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }
  action {
    action_group_id = each.value.action_group_id
  }
}
