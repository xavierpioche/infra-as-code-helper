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

provider "dns" {
  update {
        server = var.dns_server
 }
}


locals {
  nodes_masters = {for s in var.masters_vms_name: index(var.masters_vms_name, s) => s}
  nodes_workers = {for s in var.workers_vms_name: index(var.workers_vms_name, s) => s}
}

module "masters" {
    for_each = local.nodes_masters 
    source = "./vm"

    vs_datacenter = var.masters_vms_datacenter["${each.key}"]
    vs_cluster = var.masters_vms_cluster["${each.key}"]
    vs_datastore = var.masters_vms_datastore["${each.key}"]

    vm_number = "${each.key}"
    vm_prefix = var.masters_vms_prefix["${each.key}"]
    vm_suffix = var.masters_vms_suffix["${each.key}"]
    vm_cpu = var.masters_vms_cpu["${each.key}"]
    vm_memory = var.masters_vms_memory["${each.key}"]
    vm_name = var.masters_vms_name["${each.key}"]
    vm_ipaddress = var.masters_vms_ip_ad["${each.key}"]
    vm_netmask = var.masters_vms_ip_mk["${each.key}"]
    vm_gateway = var.masters_vms_ip_gw["${each.key}"]
    vm_dns_search = var.common_vm_dns_search
    vm_dns_list = var.common_vm_dns_list
    vs_resourcepool = var.masters_vms_resource_pool["${each.key}"]
    vs_network = var.masters_vms_network["${each.key}"]
    vm_site = var.masters_vms_site["${each.key}"]
    vm_template = var.masters_vms_template["${each.key}"]
    vm_folder = var.masters_vms_folder["${each.key}"]
    vm_is_windows = var.masters_vms_is_windows["${each.key}"]
    vm_datadsk = var.masters_vms_datadsk["${each.key}"]
}

output "masters_address" {
    value = module.masters[*] 
}

module "masters_dns" {
    for_each = local.nodes_masters
    source = "./dns"
    vm_name = values(module.masters)[*].vm_name[0]
    vm_address = values(module.masters)[*].vm_address[0]
    vm_envx = var.common_vm_envx
}

module "workers" {
    for_each = local.nodes_workers
    source = "./vm"

    vs_datacenter = var.workers_vms_datacenter["${each.key}"]
    vs_cluster = var.workers_vms_cluster["${each.key}"]
    vs_datastore = var.workers_vms_datastore["${each.key}"]

    vm_number = "${each.key}"
    vm_prefix = var.workers_vms_prefix["${each.key}"]
    vm_suffix = var.workers_vms_suffix["${each.key}"]
    vm_cpu = var.workers_vms_cpu["${each.key}"]
    vm_memory = var.workers_vms_memory["${each.key}"]
    vm_name = var.workers_vms_name["${each.key}"]
    vm_ipaddress = var.workers_vms_ip_ad["${each.key}"]
    vm_netmask = var.workers_vms_ip_mk["${each.key}"]
    vm_gateway = var.workers_vms_ip_gw["${each.key}"]
    vm_dns_search = var.common_vm_dns_search
    vm_dns_list = var.common_vm_dns_list
    vs_resourcepool = var.workers_vms_resource_pool["${each.key}"]
    vs_network = var.workers_vms_network["${each.key}"]
    vm_site = var.workers_vms_site["${each.key}"]
    vm_template = var.workers_vms_template["${each.key}"]
    vm_folder = var.workers_vms_folder["${each.key}"]
    vm_is_windows = var.workers_vms_is_windows["${each.key}"]
    vm_datadsk = var.workers_vms_datadsk["${each.key}"]
}

output "workers_address" {
    value = module.workers[*] 
}

module "workers_dns" {
    for_each = local.nodes_workers
    source = "./dns"
    vm_name = values(module.workers)[*].vm_name[0]
    vm_address = values(module.workers)[*].vm_address[0]
    vm_envx = var.common_vm_envx
}
