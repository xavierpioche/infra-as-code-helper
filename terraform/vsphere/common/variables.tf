variable "vsphere_endpoint" {}
variable "vsphere_username" {}
variable "vsphere_password" {}

variable "vms_name" { 
    type = list 
}

variable "vms_ip_ad" {
    type = list 
}

variable "vms_ip_mk" {
    type = list 
}

variable "vms_ip_gw" {
    type = list 
}

variable "vms_template" {
    type = list
}

variable "vms_folder" {
    type = list 
}

variable "vms_resource_pool" {
    type = list
}

variable "vms_datastore" {
    type = list
}

variable "vms_datacenter" {
    type = list
}

variable "vms_cluster" {
    type = list
}

variable "vms_network" {
    type = list 
}

variable "vms_memory" {
    type = list
}

variable "vms_cpu" {
    type = list
}

variable "vms_suffix" {
    type = list 
}

variable "vms_prefix" {
    type = list 
}

variable "vms_site" {
   type = list 
}

variable "vms_is_windows" {
   type = list (bool)
}

variable "vm_dns_list" {}

variable "vm_dns_search" {}
