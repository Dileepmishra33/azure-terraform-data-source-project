resource "azurerm_resource_group" "resource" {
  for_each = var.group
  name     = each.value.name
  location = each.value.location
}
