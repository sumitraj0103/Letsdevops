module "functionapp" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/appservices/functionapp"
    for_each = var.functionapps
    fn_app_name                = each.value.fn_app_name
    storage_account_name       = each.value.storage_account_name
    resource_group_name             = each.value.resource_group_name
    location                        = each.value.location
    service_plan_id             = each.value.service_plan_id
  depends_on = [module.storageaccount,module.asev3]
}