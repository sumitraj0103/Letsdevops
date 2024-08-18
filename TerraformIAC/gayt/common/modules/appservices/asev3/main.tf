resource "azurerm_app_service_environment_v3" "asev3" {
  name                = var.asev3_name
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  internal_load_balancing_mode = "Web, Publishing"

  cluster_setting {
    name  = "DisableTls1.0"
    value = "1"
  }

  cluster_setting {
    name  = "InternalEncryption"
    value = "true"
  }

  cluster_setting {
    name  = "FrontEndSSLCipherSuiteOrder"
    value = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
  }

}

resource "azurerm_service_plan" "ase_asp" {
  name                       = var.ase_asp_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  os_type                    = var.os_type
  sku_name                   = var.sku_name
  app_service_environment_id = azurerm_app_service_environment_v3.asev3.id
}