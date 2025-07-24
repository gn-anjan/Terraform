Resource_Group_Name     = "INRSG001"
Resource_Group_Location = "West Europe"
Virtual_Network = {
  "App" = {
    name          = "INAPPDEV001"
    address_space = ["10.0.0.0/16"]
  }
  "web" = {
    name          = "INWEBDEV001"
    address_space = ["10.1.0.0/16"]
  }
}
Subnet_Details = {
  "App" = {
    name             = "AppSubnet"
    address_prefixes = ["10.0.1.0/24"]
    vnet_key         = "App"
  }
  "Web" = {
    name             = "WebSubnet"
    address_prefixes = ["10.1.1.0/24"]
    vnet_key         = "web"
  }
  "DB" = {
    name             = "DBSubnet"
    address_prefixes = ["10.0.3.0/24"]
    vnet_key         = "App"
  }
  "Web2" = {
    name             = "Web2Subnet"
    address_prefixes = ["10.1.2.0/24"]
    vnet_key         = "web"
  }
}
Public_IP_Name = {
  "App" = {
    name              = "INPIP001"
    allocation_method = "Static"
    sku               = "Standard"
  }
  "DB" = {
    name              = "INPIP002"
    allocation_method = "Static"
    sku               = "Standard"
  }
}

Network_Interface = {
  app_nic = {
    name = "INAPPDEV001-NIC"
    ip_configuration = {
      name                          = "appInternal"
      subnet_key                    = "App"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id_key      = "App"
    }
  }
  db_nic = {
    name = "INWEBDEV001-NIC"
    ip_configuration = {
      name                          = "dbInternal"
      subnet_key                    = "DB"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id_key      = "DB"
    }
  }
}

Network_Security_Group = {
  "APP" = {
    name = "INAPPNSG001"
    security_rule = [
      {
        name                       = "AllowSSH"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "AllowHTTP"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

NIC_NSG_Association = {
  "APP" = {
    network_interface_id      = "app_nic"
    network_security_group_id = "APP"
  }
}

Virtual_Machine_Details = {
  "App1" = {
    name                  = "INAPPDEV001"
    size                  = "Standard_DS1_v2"
    admin_username        = "adminuser"
    admin_password        = "P@ssw0rd1234!" #Consider using a secure method for secrets in production.
    network_interface_ids = "app_nic"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }
  "DB1" = {
    name                  = "INDBDEV001"
    size                  = "Standard_DS1_v2"
    admin_username        = "adminuser"
    admin_password        = "P@ssw0rd1234!" #Consider using a secure method for secrets in production.
    network_interface_ids = "db_nic"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }
}
