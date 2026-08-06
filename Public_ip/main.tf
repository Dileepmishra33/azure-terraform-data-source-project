data "azurerm_resource_group" "pip" {
  name="rg_data"
}
resource "azurerm_public_ip" "example" {
  name                = "my_pip"
  resource_group_name = data.azurerm_resource_group.pip.name
  location            = data.azurerm_resource_group.pip.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}