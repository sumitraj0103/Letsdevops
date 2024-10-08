resource "azurerm_private_endpoint" "pe" {
  name                = var.pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.sc_name
    private_connection_resource_id = var.resource_id
    subresource_names              = [ var.subresource_name ]
    is_manual_connection           = false
  }
}