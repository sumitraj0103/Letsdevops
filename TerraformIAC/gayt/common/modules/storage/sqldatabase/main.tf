resource "azurerm_mssql_database" "db" {
  name      = var.sql_db_name
  server_id = var.sql_server_id

}
