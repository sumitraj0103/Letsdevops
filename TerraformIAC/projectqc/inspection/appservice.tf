module "appservice" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/appservices/appservice"
    for_each = var.appservice
    app_service_name            = each.value.app_service_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    app_service_plan_id             = each.value.app_service_plan_id

    depends_on = [module.asev3]
}