terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "5370b509-fed5-401b-a28f-6a8aa7263ccd"
  features {}
}