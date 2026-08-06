data "azurerm_resource_group" "rg" {
  for_each = var.ns
  name     = each.value.rg_name

}

data "azurerm_virtual_network" "vnet" {
  for_each            = var.ns
  name                = each.value.vnet_name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
}

data "azurerm_subnet" "subnet" {
  for_each             = var.ns
  name                 = each.value.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg[each.key].name
  virtual_network_name = data.azurerm_virtual_network.vnet[each.key].name
}

data "azurerm_network_security_group" "nsg" {
  for_each            = var.ns
  name                = each.value.nsg_name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name


}

resource "azurerm_subnet_network_security_group_association" "association" {
  for_each                  = var.ns
  subnet_id                 = data.azurerm_subnet.subnet[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg[each.key].id
}