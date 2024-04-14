module "avd" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/compute/avd"
    for_each = var.avds
    workspace_name            = each.value.workspace_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    hostpoollocation      = each.value.hostpoollocation
    hostpool_name         = each.value.hostpool_name
    desktop_app_group_name = each.value.desktop_app_group_name
    depends_on = [module.vnet,module.subnet,module.routetable]
}