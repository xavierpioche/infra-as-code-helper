
variable "vm_template" {}
variable "vs_datacenter" {}
variable "vs_cluster" {}

variable "vs_network" {}
variable "vs_resourcepool" {}
variable "vm_suffix" {}
variable "vm_site" {}
variable "vm_prefix" {}

variable "vm_name" {} 

variable "vm_folder" {}


variable "vs_datastore" {}

variable "vm_cpu" {}
variable "vm_memory" {}

variable "vm_netmask" {}

variable "vm_gateway" {}
variable "vm_ipaddress" {}

variable "vm_dns_list" {}
variable "vm_dns_search" {}

variable "vm_number" {}

variable "vm_is_windows" {
 type = bool
}

variable "vm_datadsk" {}


variable "vm_cpu_map" {
  type = map
  default = {
     "small" = "1"
     "medium" = "2"
     "large" = "4"
  }
}

variable "vm_memory_map" {
  type = map
  default = {
    "small" = "2048"
    "medium" = "4096"
    "large" = "8192"
  }
}

variable "vm_datadsk_map" {
  type = map
  default = {
    "small" = "15"
    "medium" = "40"
    "large" = "80"
  }
}
