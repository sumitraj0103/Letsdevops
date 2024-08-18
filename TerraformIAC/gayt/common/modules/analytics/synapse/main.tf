

resource "azurerm_storage_account" "st" {
  name                     = var.st_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "fsgen2" {
  name               = var.filesystem_name
  storage_account_id = azurerm_storage_account.st.id
}

resource "azurerm_synapse_workspace" "synapse" {
  name                                 = var.synapse_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.fsgen2.id
  sql_administrator_login              = "sqladminuser"
  sql_administrator_login_password     = "H@Sh1CoR3!"

  aad_admin {
    login     = "AzureAD Admin"
     object_id      = "a9a817f1-ebf4-440a-9e7f-042a064967c8"
    tenant_id = "035694e9-d37a-4068-87ca-24fce088b110"
  }

  identity {
    type = "SystemAssigned"
  }

}