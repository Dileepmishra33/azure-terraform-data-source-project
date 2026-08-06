terraform {

  backend "azurerm" {
    use_cli              = true
    use_azuread_auth     = false
    resource_group_name  = "dil"
    storage_account_name = "dmystorage2"
    container_name       = "dileep"
    key                  = "Vnet.tf.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}