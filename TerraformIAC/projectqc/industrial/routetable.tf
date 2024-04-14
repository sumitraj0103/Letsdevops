module "routetable" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/networking/routetable"
    for_each = var.routetables
    route_table_name           = each.value.route_table_name
    resource_group_name        = each.value.resource_group_name
    location                   = each.value.location
    
}