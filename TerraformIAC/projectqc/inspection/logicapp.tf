module "logicapp" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/appservices/logicapp"
    for_each = var.logicapps
    logic_app_name                = each.value.logic_app_name
    st_account_name               = each.value.st_account_name
    resource_group_name             = each.value.resource_group_name
    location                        = each.value.location
    app_service_plan_id             = each.value.app_service_plan_id
depends_on = [module.storageaccount]
}
