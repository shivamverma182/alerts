variable "metric_alerts" {
  description = "Map of metric Alerts configuration."
  type = map(object({
    name                     = optional(string, null)
    description              = optional(string, null)
    enabled                  = optional(bool, true)
    auto_mitigate            = optional(bool, true)
    severity                 = optional(number, 3)
    frequency                = optional(string, "PT5M")
    window_size              = optional(string, "PT5M")
    target_resource_type     = optional(string, null)
    target_resource_location = optional(string, null)

    criteria = optional(list(object({
      metric_namespace       = string
      metric_name            = string
      aggregation            = string
      operator               = string
      threshold              = number
      skip_metric_validation = optional(bool, false)
      dimension = optional(list(object({
        name     = string
        operator = optional(string, "Include")
        values   = list(string)
      })), [])
    })), [])

    dynamic_criteria = optional(list(object({
      metric_namespace         = string
      metric_name              = string
      aggregation              = string
      operator                 = string
      alert_sensitivity        = optional(string, "Medium")
      evaluation_total_count   = optional(number, 4)
      evaluation_failure_count = optional(number, 4)
      ignore_data_before       = optional(string)
      skip_metric_validation   = optional(bool, false)
      dimension = optional(list(object({
        name     = string
        operator = optional(string, "Include")
        values   = list(string)
      })), [])
    })), [])
  }))
}

variable "scheduled_query_alerts" {
  type = map(object({
    auto_mitigation_enabled          = optional(bool, true)
    description                      = optional(string, null)
    enabled                          = optional(bool, true)
    evaluation_frequency             = optional(string, "PT5M")
    name                             = optional(string, null)
    severity                         = optional(number, 3)
    skip_query_validation            = optional(bool, false)
    target_resource_types            = optional(list(string), [])
    window_duration                  = optional(string, "PT5M")
    workspace_alerts_storage_enabled = optional(bool, false)
    criteria = optional(list(object({
      operator                = string
      threshold               = number
      time_aggregation_method = string
      query                   = string
      resource_id_column      = optional(string, null)
      metric_measure_column   = optional(string, null)
      failing_periods = optional(object({
        minimum_failing_periods_to_trigger_alert = optional(number, 1)
        number_of_evaluation_periods             = optional(number, 1)
      }), {})
      dimension = optional(list(object({
        name     = string
        operator = string
        values   = list(string)
      })), [])
    })), [])
  }))
}

variable "action_group_id" {
  default = "/subscriptions/69cf3aa7-f245-4af3-a39d-85d7e638ba05/resourceGroups/test-rg/providers/microsoft.insights/actiongroups/test-email"
}

variable "tags" {
  default = {}
}
