
locals {
   nsg_all_rules = {
   rdp = {
      name                       = "rdp"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range    = "3389"
      source_address_prefix      = var.vnet_all_subnets.front.prefix
      destination_address_prefix = var.vnet_all_subnets.front.prefix
    }
 
    sql = {
      name                       = "sql"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = var.vnet_all_subnets.front.prefix
      destination_address_prefix = var.vnet_all_subnets.back.prefix
    }
 
    http = {
      name                       = "http"
      priority                   = 201
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = var.vnet_all_subnets.front.prefix
    }
   }
}

