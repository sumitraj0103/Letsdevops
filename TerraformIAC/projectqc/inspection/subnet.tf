module "subnet" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/networking/subnet"
    for_each = var.subnets
    sn_name                  = each.value.sn_name
    resource_group_name      = each.value.resource_group_name
    virtual_network_name     = each.value.virtual_network_name
    address_prefixes         = each.value.address_prefixes
    delegation         =       try(each.value.delegations,null)

   depends_on = [module.vnet.azvnet]
    
}

