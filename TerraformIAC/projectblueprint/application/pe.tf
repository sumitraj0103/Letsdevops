module "privateendpoint" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../modules/networking/privateendpoint"
    for_each = var.pes
    pe_name            = each.value.pe_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    resource_id = each.value.resource_id
    subnet_id      = each.value.subnet_id
    service_connection         = each.value.service_connection
    subresource_type = each.value.subresource_type
    dns_zone_group = each.value.dns_zone_group
    private_dns_zone_id =each.value.private_dns_zone_id
   
}
