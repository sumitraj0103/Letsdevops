terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.63.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.2"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.9.0"
    }
  }
}
