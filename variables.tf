variable "Resource_Group_Name" {
  type        = string
  description = "Name of the resource group to create"
}

variable "Resource_Group_Location" {
  type        = string
  description = "Location for the resource group"
}

variable "Virtual_Network" {
  description = "values for the virtual network"
  type = map(object({
    name          = string
    address_space = list(string)
  }))

}

variable "Subnet_Details" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
    vnet_key         = string
  }))
}

variable "Public_IP_Name" {
  type = map(object({
    name              = string
    allocation_method = string
    sku               = string
  }))
}

variable "Network_Interface" {
  description = "Map of network interfaces to create"
  type = map(object({
    name = string
    ip_configuration = object({
      name                          = string
      subnet_key                    = string
      private_ip_address_allocation = string
      public_ip_address_id_key      = string
    })
  }))
}

variable "Network_Security_Group" {
  description = "values for the network security group"
  type = map(object({
    name = string
    security_rule = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "NIC_NSG_Association" {
  description = "Map of network interface to network security group associations"
  type = map(object({
    network_interface_id      = string
    network_security_group_id = string
  }))
}

variable "Virtual_Machine_Details" {
  description = "values for the virtual machine"
  type = map(object({
    name                  = string
    size                  = string
    admin_username        = string
    admin_password        = string
    network_interface_ids = string
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}
