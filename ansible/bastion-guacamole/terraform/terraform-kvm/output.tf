output "domain_name" {
       value = var.vms_domain[0]
}

output "dns_server" {
	value = module.vm[0].vm_address[0] != 0 ? element(concat(module.vm[0].vm_address[0],tolist(["none"])),0) : ""
}
