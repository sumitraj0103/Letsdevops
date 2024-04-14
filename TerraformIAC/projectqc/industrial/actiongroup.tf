module "actiongroup" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/monitor/actiongroup"
    for_each = var.actiongroups
    action_group_name                  = each.value.action_group_name
    resource_group_name      = each.value.resource_group_name
    short_name      = each.value.short_name
}
