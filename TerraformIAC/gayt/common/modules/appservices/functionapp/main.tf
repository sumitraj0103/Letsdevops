
data "azurerm_storage_account" "stfunctionapp" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_windows_function_app" "funapp" {
  name                = var.fn_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id =     var.service_plan_id
  storage_account_name       = data.azurerm_storage_account.stfunctionapp.name
  storage_account_access_key = data.azurerm_storage_account.stfunctionapp.primary_access_key
  site_config {}
}

