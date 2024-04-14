resource "azurerm_network_interface" "nic" {
  name                = var.vmnic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vmsize
  admin_username      = "adminuser"
  admin_password        = random_password.password.result
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_st_type
  }

  source_image_reference {
    publisher = var.publisher #"MicrosoftWindowsServer"
    offer     = var.offer#"WindowsServer"
    sku       = var.image_SKU  #"2016-Datacenter"
    version   = "latest"
  }
}

resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

resource "azurerm_managed_disk" "datadisk" {
  name                 = var.datadisk_name
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_type = var.data_disk_st_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "dataattach" {
  managed_disk_id    = azurerm_managed_disk.datadisk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = "10"
  caching            = "ReadWrite"
}

