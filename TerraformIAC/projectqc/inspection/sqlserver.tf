module "sqlserver" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/storage/sqlserver"
    for_each = var.sqlservers
    sqlserver_name                  = each.value.sqlserver_name
    resource_group_name      = each.value.resource_group_name
    location      = each.value.location
}