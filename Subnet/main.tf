data "azurerm_resource_group" "subdata" {
  name="rg_data"
}
data "azurerm_virtual_network" "subvnet" {

     name="example-network"
    resource_group_name=data.azurerm_resource_group.subdata.name
}
data "azurerm_network_security_group" "subnsg" {
  name="example-security-group"
  resource_group_name = data.azurerm_resource_group.subdata.name
}
resource "azurerm_subnet" "subnet" {
  name                 = "App_subnet"
  resource_group_name  = data.azurerm_resource_group.subdata.name
  virtual_network_name = data.azurerm_virtual_network.subvnet.name
  address_prefixes     = ["10.0.1.0/24"]

  
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = data.azurerm_network_security_group.subnsg.id
}