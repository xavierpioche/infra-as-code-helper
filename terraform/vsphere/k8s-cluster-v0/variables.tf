variable "vsphere_endpoint" {}
variable "vsphere_username" {}
variable "vsphere_password" {}

variable "dns_server" {}

variable "lbs_vms_name" { 
    type = list 
}

variable "lbs_vms_ip_ad" {
    type = list 
}

variable "lbs_vms_ip_mk" {
    type = list 
}

variable "lbs_vms_ip_gw" {
    type = list 
}

variable "lbs_vms_template" {
    type = list
}

variable "lbs_vms_folder" {
    type = list 
}

variable "lbs_vms_resource_pool" {
    type = list
}

variable "lbs_vms_datastore" {
    type = list
}

variable "lbs_vms_datacenter" {
    type = list
}

variable "lbs_vms_cluster" {
    type = list
}

variable "lbs_vms_network" {
    type = list 
}

variable "lbs_vms_memory" {
    type = list
}

variable "lbs_vms_cpu" {
    type = list
}

variable "lbs_vms_suffix" {
    type = list 
}

variable "lbs_vms_prefix" {
    type = list 
}

variable "lbs_vms_site" {
   type = list 
}

variable "lbs_vms_is_windows" {
   type = list (bool)
}

variable "lbs_vms_datadsk" {
  type = list
}


variable "masters_vms_name" { 
    type = list 
}

variable "masters_vms_ip_ad" {
    type = list 
}

variable "masters_vms_ip_mk" {
    type = list 
}

variable "masters_vms_ip_gw" {
    type = list 
}

variable "masters_vms_template" {
    type = list
}

variable "masters_vms_folder" {
    type = list 
}

variable "masters_vms_resource_pool" {
    type = list
}

variable "masters_vms_datastore" {
    type = list
}

variable "masters_vms_datacenter" {
    type = list
}

variable "masters_vms_cluster" {
    type = list
}

variable "masters_vms_network" {
    type = list 
}

variable "masters_vms_memory" {
    type = list
}

variable "masters_vms_cpu" {
    type = list
}

variable "masters_vms_suffix" {
    type = list 
}

variable "masters_vms_prefix" {
    type = list 
}

variable "masters_vms_site" {
   type = list 
}

variable "masters_vms_is_windows" {
   type = list (bool)
}

variable "masters_vms_datadsk" {
  type = list
}


variable "workers_vms_name" { 
    type = list 
}

variable "workers_vms_ip_ad" {
    type = list 
}

variable "workers_vms_ip_mk" {
    type = list 
}

variable "workers_vms_ip_gw" {
    type = list 
}

variable "workers_vms_template" {
    type = list
}

variable "workers_vms_folder" {
    type = list 
}

variable "workers_vms_resource_pool" {
    type = list
}

variable "workers_vms_datastore" {
    type = list
}

variable "workers_vms_datacenter" {
    type = list
}

variable "workers_vms_cluster" {
    type = list
}

variable "workers_vms_network" {
    type = list 
}

variable "workers_vms_memory" {
    type = list
}

variable "workers_vms_cpu" {
    type = list
}

variable "workers_vms_suffix" {
    type = list 
}

variable "workers_vms_prefix" {
    type = list 
}

variable "workers_vms_site" {
   type = list 
}

variable "workers_vms_is_windows" {
   type = list (bool)
}

variable "workers_vms_datadsk" {
  type = list
}



variable "common_vm_dns_list" {}

variable "common_vm_dns_search" {}

variable "common_vm_envx" {}
