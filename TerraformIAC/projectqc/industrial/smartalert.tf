module "smartalert" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/monitor/smartalert"
    for_each = var.smartalerts
    resource_group_name   = each.value.resource_group_name
    smart_detector_alert_rule            = each.value.smart_detector_alert_rule
    application_insights_id   = each.value.application_insights_id
    monitor_action_group_id              = each.value.monitor_action_group_id
}
