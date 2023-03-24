variable "vnet_name" {}
variable "vnet_location" {}
variable "vnet_rg_name" {}
variable "vnet_address_space" {}
variable "vnet_all_subnets" {
  type = map(map(any))
}
