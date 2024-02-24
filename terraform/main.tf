terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

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
