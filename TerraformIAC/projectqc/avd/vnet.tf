module "vnet" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/networking/vnet"
    for_each = var.vnets
    vnet_name             = each.value.vnet_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    address_space         = each.value.address_space
    
}
