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

#provider "dns" {
#  update {
#        server = var.dns_server
# }
#}

variable "vms_name" { type = list }
variable "vms_domain" { type = list }
variable "vms_ip_type" { type = list }
variable "vms_memoryMB" { type = list }
variable "vms_cpu" { type = list }
variable "ansible_user" {}
variable "image_path" {}
variable "image_name" {}
variable "vms_pool" { type = list }
variable "vms_disk" { type = list }

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
	vmpool = var.vms_pool["${each.key}"]
	ansible_user = var.ansible_user
	image_path = var.image_path
	image_name = var.image_name
	diskoctsize = var.vms_disk["${each.key}"] * 1024 * 1024 * 1024
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

#module "vm_dns" {
#    for_each = local.vms_creation
#    source = "./dns"
#    vm_name = values(module.vm)["${each.key}"].vm_name[0]
#    vm_address = values(module.vm)["${each.key}"].vm_address[0]
#    vm_subenvx = var.common_vm_subenvx
#    vm_envx = var.common_vm_envx
#    vm_tld = var.common_vm_tld
#}


