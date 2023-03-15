output "vm_address" {
	value = vsphere_virtual_machine.vm.*.default_ip_address
        //value = vsphere_virtual_machine.vm.*.clone.0.customize.0.network_interface.0.ipv4_address
}

output "vm_name" {
        value = vsphere_virtual_machine.vm.*.name
}
