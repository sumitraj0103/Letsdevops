module "appserviceplan" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/appservices/appserviceplan"
    for_each = var.appserviceplans
    app_service_plan_name            = each.value.app_service_plan_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    sku_name             = each.value.sku_name
    os_type             = each.value.os_type

}
