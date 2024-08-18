
data "azurerm_storage_account" "stfunctionapp" {
  name                = var.st_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_logic_app_standard" "logicapp" {
  name                       = var.logic_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = data.azurerm_storage_account.stfunctionapp.name
  storage_account_access_key = data.azurerm_storage_account.stfunctionapp.primary_access_key

  app_settings = {

  }
}