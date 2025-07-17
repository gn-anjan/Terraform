resource "azurerm_virtual_network" "Virtual_Network" {
  for_each            = var.Virtual_Network
  name                = each.value.name
  address_space       = each.value.address_space
  location            = azurerm_resource_group.Resource_Group.location
  resource_group_name = azurerm_resource_group.Resource_Group.name
}

resource "azurerm_subnet" "Subnet" {
  for_each             = var.Subnet_Details
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.Resource_Group.name
  virtual_network_name = azurerm_virtual_network.Virtual_Network[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "Public_IP" {
  for_each            = var.Public_IP_Name
  resource_group_name = azurerm_resource_group.Resource_Group.name
  name                = each.value.name
  location            = azurerm_resource_group.Resource_Group.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_network_interface" "Network_Interface" {
  for_each            = var.Network_Interface
  name                = each.value.name
  location            = azurerm_resource_group.Resource_Group.location
  resource_group_name = azurerm_resource_group.Resource_Group.name

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = azurerm_subnet.Subnet[each.value.ip_configuration.subnet_key].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.Public_IP[each.value.ip_configuration.public_ip_address_id_key].id
  }
}

resource "azurerm_network_security_group" "NSG" {
  for_each            = var.Network_Security_Group
  name                = each.value.name
  location            = azurerm_resource_group.Resource_Group.location
  resource_group_name = azurerm_resource_group.Resource_Group.name

  dynamic "security_rule" {
    for_each = each.value.security_rule
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  for_each                  = var.NIC_NSG_Association
  network_interface_id      = azurerm_network_interface.Network_Interface[each.value.network_interface_id].id
  network_security_group_id = azurerm_network_security_group.NSG[each.value.network_security_group_id].id
}
