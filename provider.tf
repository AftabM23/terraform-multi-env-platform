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
  }
}

provider "azurerm" {
 features {
   
 }
 use_oidc = true
}