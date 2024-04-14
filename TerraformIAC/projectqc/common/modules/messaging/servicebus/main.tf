resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.servicebus_nms
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku


}