terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
  backend "azurerm" {
  resource_group_name  = "rg-linux-practice"
  storage_account_name = "abstorage23"
  container_name       = "tf-state-container01"
  key                  = "test/test.terraform.tfstate"
  use_azuread_auth     = true
  use_oidc             = true
}
}

provider "azurerm" {
  features {

  }
  use_cli         = false
  use_oidc        = true
  subscription_id = "b14398ec-6e89-44a6-ad7c-d7dfcf9ffac5"

}