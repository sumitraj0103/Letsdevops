resource "azurerm_virtual_network_peering" "vnethub" {
  name                      = var.peer_name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.source_vnet_name
  remote_virtual_network_id = var.target_vnet_id
}