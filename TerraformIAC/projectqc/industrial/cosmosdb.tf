module "cosmosdb" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/storage/cosmosdb"
    for_each = var.cosmosdbs
    cosmosdb_name            = each.value.cosmosdb_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
 
} 