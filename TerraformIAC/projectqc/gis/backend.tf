terraform {
    backend "azurerm" {
        key                  = "gis/terraform.tfstate" 
    }
}
