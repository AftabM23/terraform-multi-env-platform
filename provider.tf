terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
  backend "azurerm" {
  resource_group_name  = "storageacc"
  storage_account_name = "abstorage23"
  container_name       = "state-files"
  key                  = "terraform.tfstate"
  use_azuread_auth     = true
  use_oidc             = true
}
}

provider "azurerm" {
  features {

  }
 

}