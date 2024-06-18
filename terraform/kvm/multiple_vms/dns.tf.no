provider "dns" {
  update {
        server = var.dns_server
 }
}

variable "dns_server" {}
variable "common_vm_envx" {}
variable "common_vm_subenvx" {}
variable "common_vm_tld" {}

module "vm_dns" {
    for_each = local.vms_creation
    source = "./dns"
    vm_name = values(module.vm)["${each.key}"].vm_name[0]
    vm_address = values(module.vm)["${each.key}"].vm_address[0]
    vm_subenvx = var.common_vm_subenvx
    vm_envx = var.common_vm_envx
    vm_tld = var.common_vm_tld
}

