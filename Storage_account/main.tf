data "azurerm_resource_group" "rg" {
    name     = "rg_data"
  
  
}

resource "azurerm_storage_account" "storage" {
  name                     = "mystoragexz"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}