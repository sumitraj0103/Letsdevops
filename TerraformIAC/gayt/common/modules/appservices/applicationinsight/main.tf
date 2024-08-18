resource "azurerm_application_insights" "app_insight" {
  name                = var.app_insight_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = var.workspace_id
  application_type    = "web"
}