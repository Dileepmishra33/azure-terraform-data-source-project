data "azurerm_virtual_network" "vnet" {
  for_each = var.subnet
  name     = each.value.vnet_name

  resource_group_name = each.value.vnet_resource_group_name
}

resource "azurerm_subnet" "Subnet" {
  for_each             = var.subnet
  name                 = each.value.name
  resource_group_name  = each.value.vnet_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = each.value.vnet_address_prefixes

}