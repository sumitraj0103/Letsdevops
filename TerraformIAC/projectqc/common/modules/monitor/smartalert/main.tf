resource "azurerm_monitor_smart_detector_alert_rule" "alertdetect" {
  name                = var.smart_detector_alert_rule
  resource_group_name = var.resource_group_name
  severity            = "Sev0"
  scope_resource_ids  = [var.application_insights_id]
  frequency           = "PT1M"
  detector_type       = "FailureAnomaliesDetector"

  action_group {
    ids = [var.monitor_action_group_id]
  }
}