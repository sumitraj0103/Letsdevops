output "sql_connectivity_update_password" {
  sensitive = true
  value     = azurerm_mssql_virtual_machine.mssqlvm.sql_connectivity_update_password
}
