module "servicebus" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/messaging/servicebus"
    for_each = var.servicebuses
    servicebus_nms            = each.value.servicebus_nms
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    sku              = each.value.sku
}