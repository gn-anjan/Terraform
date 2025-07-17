resource "azurerm_linux_virtual_machine" "Virtual_Machine" {
  for_each                        = var.Virtual_Machine_Details
  name                            = each.value.name
  resource_group_name             = azurerm_resource_group.Resource_Group.name
  location                        = azurerm_resource_group.Resource_Group.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.Network_Interface[each.value.network_interface_ids].id
  ]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}
