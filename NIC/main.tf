data "azurerm_resource_group" "nicrg" {
  name="rg_data"
}
data "azurerm_virtual_network" "nicvnet" {
  name="example-network"
  resource_group_name = data.azurerm_resource_group.nicrg.name
}

data "azurerm_subnet" "nicsubnet" {
  name="App_subnet"
  virtual_network_name = data.azurerm_virtual_network.nicvnet.name
  resource_group_name = data.azurerm_resource_group.nicrg.name
}
data "azurerm_public_ip" "nicpip" {
  name="my_pip"
  resource_group_name = data.azurerm_resource_group.nicrg.name
}

resource "azurerm_network_interface" "nic" {
  name                = "nic1"
  location            = data.azurerm_resource_group.nicrg.location
  resource_group_name = data.azurerm_resource_group.nicrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.nicsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.nicpip.id
    
  }
}