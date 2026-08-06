data "azurerm_resource_group" "rgvm" {
  for_each = var.vm
  name     = each.value.rg_name
}

data "azurerm_virtual_network" "vnet" {
  for_each            = var.vm
  name                = each.value.Vnet_name
  resource_group_name = data.azurerm_resource_group.rgvm[each.key].name
}

data "azurerm_subnet" "subvm" {
  for_each             = var.vm
  name                 = each.value.sub_name
  resource_group_name  = data.azurerm_resource_group.rgvm[each.key].name
  virtual_network_name = data.azurerm_virtual_network.vnet[each.key].name
}

data "azurerm_network_interface" "nicvm" {
  for_each            = var.vm
  name                = each.value.nic_name
  resource_group_name = data.azurerm_resource_group.rgvm[each.key].name
   


}

resource "azurerm_virtual_machine" "vm" {
  for_each              = var.vm
  name                  = each.value.name
  location              = data.azurerm_resource_group.rgvm[each.key].location
  resource_group_name   = data.azurerm_resource_group.rgvm[each.key].name
  network_interface_ids = [data.azurerm_network_interface.nicvm[each.key].id]
  vm_size               = each.value.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
  storage_os_disk {
    name              = each.value.diskname
    caching           = each.value.caching
    create_option     = each.value.create_option
    managed_disk_type = each.value.managed_disk_type
  }
  os_profile {
    computer_name  = each.value.computer_name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = each.value.disable_password_authentication
  }

}