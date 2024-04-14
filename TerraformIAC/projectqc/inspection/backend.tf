terraform {
    backend "azurerm" {
        key                  = "inspection/terraform.tfstate" 
    }
}
