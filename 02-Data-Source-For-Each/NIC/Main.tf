data "azurerm_resource_group" "rg" {
  for_each = var.nics
  name     = each.value.rg_name

}

data "azurerm_virtual_network" "vnet" {
  for_each            = var.nics
  name                = each.value.vnet_name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
}

data "azurerm_subnet" "subnet" {
  for_each             = var.nics
  name                 = each.value.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg[each.key].name
  virtual_network_name = data.azurerm_virtual_network.vnet[each.key].name
}

data "azurerm_public_ip" "public" {

  for_each = var.nics
  name= each.value.public_name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name

  ip_configuration {

    name                          = each.value.ipcon_name
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
     public_ip_address_id = data.azurerm_public_ip.public[each.key].id
  }
}