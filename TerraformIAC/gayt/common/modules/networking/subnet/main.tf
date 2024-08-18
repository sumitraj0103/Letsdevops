resource "azurerm_subnet" "azure_sn" {
  name                                           = var.sn_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.virtual_network_name
  address_prefixes                               = var.address_prefixes

  dynamic "delegation" {
    for_each = var.delegation != null ? [var.delegation] : []

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation
        actions = delegation.value.actions
      }
    }
  }
}
/*
resource "azurerm_subnet_network_security_group_association" "azure_sn_nsg" {
  subnet_id                 = azurerm_subnet.azure_sn.id
  network_security_group_id = var.network_security_group_id
}*/
