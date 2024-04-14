module "storageaccount" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/storage/storageaccount"
    for_each = var.staccounts
    st_account_name            = each.value.st_account_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    account_tier             = each.value.account_tier
    account_replication_type = each.value.account_replication_type
}