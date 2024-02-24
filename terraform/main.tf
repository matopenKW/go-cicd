terraform {
  backend "azurerm" {
    resource_group_name  = "go-cicd-rg"
    storage_account_name = "gocicdstorageaccount"
    container_name       = "tfstate"
    key                  = "gocicdstorageaccount/terraform.tfstate"
  }
}

resource "azurerm_resource_group" "go-cicd-rg" {
  location = "southafricanorth"
  name     = "go-cicd-rg"
}
