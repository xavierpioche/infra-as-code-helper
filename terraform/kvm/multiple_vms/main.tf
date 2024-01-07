terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

terraform {
  required_version = ">= 1.6.6"
}

provider "libvirt" {
  # Configuration du fournisseur libvirt
  uri = "qemu:///system"
  alias = "alternate"
}


variable "vms_name" { type = list }
variable "vms_domain" { type = list }
variable "vms_ip_type" { type = list }
variable "vms_memoryMB" { type = list }
variable "vms_cpu" { type = list }

#variable "dns_server" {}
#variable "common_vm_envx" {}
#variable "common_vm_subenvx" {}
#variable "common_vm_tld" {}



locals {
	vms_creation = {for s in var.vms_name: index(var.vms_name, s) => s}
}

module "vm" {
	source = "./vm"
	providers = {
		 libvirt = libvirt.alternate
	}
	for_each = local.vms_creation
	hostname = var.vms_name["${each.key}"]
	domain = var.vms_domain["${each.key}"]
	ip_type = var.vms_ip_type["${each.key}"]
	memoryMB = var.vms_memoryMB["${each.key}"]
	cpu = var.vms_cpu["${each.key}"]
}

output "information" {
	value = module.vm[*]
}

#output "vm_names" {
#	value = values(module.vm)[*].vm_name[0]
#}

#output "vm_addresses" {
#	value = values(module.vm)[*].vm_address[0]
#}



