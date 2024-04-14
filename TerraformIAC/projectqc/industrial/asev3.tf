module "asev3" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/appservices/asev3"
    for_each = var.asev3
    asev3_name            = each.value.asev3_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    subnet_id             = each.value.subnet_id
    ase_asp_name          = each.value.ase_asp_name
    os_type               = each.value.os_type
    sku_name              = each.value.sku_name
    
}