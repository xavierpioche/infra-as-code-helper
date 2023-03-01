terraform {
  required_providers {
                 vsphere = {
                        source = "hashicorp/vsphere"
                 }
        }
}

provider "vsphere" {
  user           = var.vsphere_username
  password       = var.vsphere_password
  vsphere_server = var.vsphere_endpoint
 
  allow_unverified_ssl = true
}

locals {
  vms_creation = {for s in var.vms_name: index(var.vms_name, s) => s}
}

module "vm" {
    for_each = local.vms_creation 
    source = "./vm"

    vs_datacenter = var.vms_datacenter["${each.key}"]
    vs_cluster = var.vms_cluster["${each.key}"]
    vs_datastore = var.vms_datastore["${each.key}"]

    vm_number = "${each.key}"
    vm_prefix = var.vms_prefix["${each.key}"]
    vm_suffix = var.vms_suffix["${each.key}"]
    vm_cpu = var.vms_cpu["${each.key}"]
    vm_memory = var.vms_memory["${each.key}"]
    vm_name = var.vms_name["${each.key}"]
    vm_ipaddress = var.vms_ip_ad["${each.key}"]
    vm_netmask = var.vms_ip_mk["${each.key}"]
    vm_gateway = var.vms_ip_gw["${each.key}"]
    vm_dns_search = var.vm_dns_search
    vm_dns_list = var.vm_dns_list
    vs_resourcepool = var.vms_resource_pool["${each.key}"]
    vs_network = var.vms_network["${each.key}"]
    vm_site = var.vms_site["${each.key}"]
    vm_template = var.vms_template["${each.key}"]
    vm_folder = var.vms_folder["${each.key}"]
    vm_is_windows = var.vms_is_windows["${each.key}"]
    vm_datadsk = var.vms_datadsk["${each.key}"]
}
