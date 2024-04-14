module "virtualmachine" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/compute/virtualmachine"
    for_each = var.windowsvms
    vm_name               = each.value.vm_name
    vmnic_name            = each.value.vmnic_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    vmsize            = each.value.vmsize
    subnet_id   = each.value.subnet_id
    os_disk_st_type              = each.value.os_disk_st_type
    image_SKU            = each.value.image_SKU
    offer                = each.value.offer
    publisher            = each.value.publisher
    data_disk_size = each.value.data_disk_size
    data_disk_st_type = each.value.data_disk_st_type
    datadisk_name= each.value.datadisk_name
depends_on = [module.vnet.azvnet,module.subnet.azure_sn]
} 

