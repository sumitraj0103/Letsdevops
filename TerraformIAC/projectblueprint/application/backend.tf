terraform {
    backend "azurerm" {
        key                  = "avd/terraform.tfstate" 
    }
}