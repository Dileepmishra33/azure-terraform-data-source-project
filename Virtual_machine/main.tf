
data "azurerm_resource_group" "vmrg" {
  name = "rg_data"
}

data "azurerm_virtual_network" "vmvnet" {
  name = "example-network"
  resource_group_name = data.azurerm_resource_group.vmrg.name
}
data "azurerm_subnet" "vmsubnet" {
    name="App_subnet"
    virtual_network_name = data.azurerm_virtual_network.vmvnet.name
    resource_group_name = data.azurerm_resource_group.vmrg.name
  
}
data "azurerm_network_interface" "vmnic" {
  name="nic1"
  resource_group_name = data.azurerm_resource_group.vmrg.name
}
data "azurerm_public_ip" "vmip" {
  name = "my_pip"
  resource_group_name = data.azurerm_resource_group.vmrg.name
}

resource "azurerm_virtual_machine" "main" {
  name                  = "vm"
  location              = data.azurerm_resource_group.vmrg.location
  resource_group_name   = data.azurerm_resource_group.vmrg.name
  network_interface_ids = [data.azurerm_network_interface.vmnic.id]
  vm_size               = "Standard_D2s_v3"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}