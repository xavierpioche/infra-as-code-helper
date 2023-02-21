/*
    DESCRIPTION:
    Red Hat Enterprise Linux 8 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_language = "fr_FR.UTF-8"
vm_guest_os_keyboard = "fr"
vm_guest_os_timezone = "America/Guadeloupe"
vm_guest_os_family   = "linux"
vm_guest_os_name     = "debian"
vm_guest_os_version  = "11.6"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "other5xLinux64Guest"

// kickstart
vm_inst_os_language = "fr_FR.UTF-8"
vm_inst_os_keyboard = "fr"
vm_inst_ip_device = "ens192"
vm_inst_ip_addr = "192.168.1.190"
vm_inst_ip_mask = "255.255.255.0"
vm_inst_ip_gw = "192.168.1.1"
vm_inst_ip_dns1 = "192.168.1.1"
vm_inst_ip_dns2 = "192.168.1.240"
vm_inst_os_timezone = "America/Guadeloupe"
vm_inst_ip_ntp1 = "172.16.1.98"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
vm_cdrom_type            = "ide"
vm_cpu_count             = 1
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 1024
vm_mem_hot_add           = false
vm_disk_size             = 40960
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_path           = "ISO/debian"
iso_file           = "debian-11.3.0-amd64-netinst.iso"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "5s"
vm_boot_command = [
    "<wait>",
    "<down><down><enter>",
    "<down><down><down><down><down><enter>",
    "<wait30s>",
    "<leftAltOn><f2><leftAltOff>",
    "<enter><wait>",
    "mount /dev/sr1 /media<enter>",
    "<leftAltOn><f1><leftAltOff>",
    "file:///media/ks.cfg",
    "<enter><wait>"
]

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"
