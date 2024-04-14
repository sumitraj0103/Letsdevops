module "nsg" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/networking/nsg"
    for_each = var.nsgs
    nsg            = each.value.nsg
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
 
} 
