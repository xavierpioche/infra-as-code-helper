resource "azurerm_virtual_network" "network" {
   name                = var.vnet_name
   location            = var.vnet_location
   resource_group_name = var.vnet_rg_name
   address_space       = [ "${var.vnet_address_space}" ]

  dynamic "subnet" {
      for_each = [
         for s in var.vnet_all_subnets : {
             name = s.name
             prefix = s.prefix
        }
      ]
     content {
        name = subnet.value.name
        address_prefix = subnet.value.prefix
     }
  }
}
