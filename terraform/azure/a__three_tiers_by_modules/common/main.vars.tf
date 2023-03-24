variable "all_rgs" {
 type = map(map(any))
}

variable "vnet_name" {}
variable "vnet_location" {}
variable "vnet_address_space" {}
variable "vnet_all_subnets" {
  type=map(map(any))
}

variable "nsg_name" {}
variable "nsg_location" {}
