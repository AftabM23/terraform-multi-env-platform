terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
  backend "azurerm" {
  resource_group_name  = "ab-terrastorage"
  storage_account_name = "abstorageterra"
  container_name       = "tf-state-container01"
  key                  = "tfstate"
  use_azuread_auth     = true
  use_oidc             = true
}
}

provider "azurerm" {
  features {

  }
 

}