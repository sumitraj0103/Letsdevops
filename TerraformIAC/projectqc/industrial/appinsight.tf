module "applicationinsight" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/appservices/applicationinsight"
    for_each = var.appinsights
    app_insight_name            = each.value.app_insight_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    workspace_id          = each.value.workspace_id
}