all_rgs = {
  "first" = {
      "location" = "eastus"
      "prefix"   = "rgxp"
      }
  "second" = {
      "location"  = "westus"
      "prefix"   = "rgmc"
      }
} 

vnet_name = "mon_reseau"
vnet_location = "eastus"
vnet_address_space = "10.0.0.0/16"

vnet_all_subnets = {
  "front" = {
      "name" = "front"
      "prefix" = "10.0.0.0/24"
   }
   "back" = {
      "name" = "back"
      "prefix" = "10.0.1.0/24"
   }
   "data" = {
      "name" = "data"
      "prefix" = "10.0.2.0/24"
   }
}

nsg_name = "mon_nsg"
nsg_location = "eastus"

all_computes_1 = {
  "front" = {
    env  = "pr"
    name = "wb"
    ips  = "1" #public ip or not
    type = "small"
    image = "debian"
  },
  "back" = {
    env  = "pr"
    name = "as"
    ips  = "0" 
    type = "small"
    image = "debian"
  },
  "data" = {
    env  = "pr"
    name = "db",
    ips  = "0"
    type = "small"
    image = "debian"
  }
}