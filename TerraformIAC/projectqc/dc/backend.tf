terraform {
    backend "azurerm" {
        key                  = "dc/terraform.tfstate" 
    }
}
