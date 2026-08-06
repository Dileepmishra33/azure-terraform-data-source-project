data "azurerm_resource_group" "add" {
  name="rg_data"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "example-security-group"
  location            = data.azurerm_resource_group.add.location
  resource_group_name = data.azurerm_resource_group.add.name

security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = data.azurerm_resource_group.add.location
  resource_group_name = data.azurerm_resource_group.add.name
  address_space       = ["10.0.0.0/16"]



}