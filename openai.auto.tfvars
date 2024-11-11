scheduled_query_alerts = {
  "AzureOpenAIRequestsByStatusCode" = {
    "auto_mitigation_enabled"          = true
    "description"                      = "Alert when HTTP success rate for Azure OpenAI service falls below threshold"
    "enabled"                          = true
    "evaluation_frequency"             = "PT10M"
    "name"                             = "AzureOpenAIRequestsByStatusCode"
    "severity"                         = 3
    "skip_query_validation"            = true
    "window_duration"                  = "PT10M"
    "workspace_alerts_storage_enabled" = false
    "criteria" = [
      {
        "operator"                = "LessThan"
        "threshold"               = 95
        "time_aggregation_method" = "Count"
        resource_id_column        = "SuccessRate"
        "query"                   = <<-QUERY
          let timeFrame = ago(10m);
          let successStatusCode = "200";
          AzureDiagnostics
          | where TimeGenerated >= timeFrame
          | where Category == "RequestResponse"
          | summarize SuccessCount = countif(ResultSignature == successStatusCode),
                      TotalCount = count()
          | extend SuccessRate = todouble(SuccessCount) / todouble(TotalCount) * 100
          | where SuccessRate < 95
          | project SuccessRate
        QUERY
      }
    ]
  },
  "AzureOpenAIRequestsByDeployment" = {
    "auto_mitigation_enabled"          = true
    "description"                      = "Alert when HTTP success rate for Azure OpenAI service falls below threshold"
    "enabled"                          = true
    "evaluation_frequency"             = "PT10M"
    "name"                             = "AzureOpenAIRequestsByDeployment"
    "severity"                         = 3
    "skip_query_validation"            = true
    "window_duration"                  = "PT10M"
    "workspace_alerts_storage_enabled" = false
    "criteria" = [
      {
        "operator"                = "LessThan"
        "threshold"               = 95
        "time_aggregation_method" = "Count"
        resource_id_column        = "SuccessRate"
        "query"                   = <<-QUERY
          let timeFrame = ago(10m);
          let successStatusCode = "200";
          AzureDiagnostics
          | where TimeGenerated >= timeFrame
          | where Category == "RequestResponse"
          | summarize SuccessCount = countif(ResultSignature == successStatusCode),
                      TotalCount = count()
          | extend SuccessRate = todouble(SuccessCount) / todouble(TotalCount) * 100
          | where SuccessRate < 95
          | project SuccessRate
        QUERY
      }
    ]
  },
}
