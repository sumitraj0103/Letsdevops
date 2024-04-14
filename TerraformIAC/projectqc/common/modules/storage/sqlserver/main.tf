resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlserver_name
  location            = var.location
  resource_group_name = var.resource_group_name
  version                      = "12.0"
  administrator_login          = "insadmin"
  administrator_login_password = random_password.password.result

 azuread_administrator {
    login_username = "sqladmin"
    object_id      = "a9a817f1-ebf4-440a-9e7f-042a064967c8"
    azuread_authentication_only = true
  }
}

resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}