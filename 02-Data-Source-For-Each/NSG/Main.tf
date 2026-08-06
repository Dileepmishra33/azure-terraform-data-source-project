data "azurerm_resource_group" "rg" {
  for_each = var.NSG
  name     = each.value.resource_group_name

}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.NSG
  name                = each.value.name
  location            = each.value.location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name

  security_rule {
    name                       = each.value.rule_name
    priority                   = each.value.priority
    direction                  = each.value.direction
    access                     = each.value.access
    protocol                   = each.value.protocol
    source_port_range          = each.value.source_port_range
    destination_port_range     = each.value.destination_port_range
    source_address_prefix      = each.value.source_address_prefix
    destination_address_prefix = each.value.destination_address_prefix
  }


}