module "routes" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/networking/routes"
    for_each = var.routes
    routename           = each.value.routename
    resource_group_name = each.value.resource_group_name
    route_table_name    = each.value.route_table_name
    address_prefix      = each.value.address_prefix
    next_hop_type       = each.value.next_hop_type
    next_hop_in_ip_address = each.value.next_hop_in_ip_address

depends_on = [module.routetable.routetable]
}


