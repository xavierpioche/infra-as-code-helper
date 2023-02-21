// Installation Operating System Metadata
vm_inst_os_language                 = "fr-FR"
vm_inst_os_keyboard                 = "fr-FR"
vm_inst_os_image_standard_core      = "Windows Server 2019 SERVERSTANDARDCORE"
vm_inst_os_image_standard_desktop   = "Windows Server 2019 SERVERSTANDARD"
vm_inst_os_kms_key_standard         = "4893F-RNKV3-8XD6D-YJ327-VVCH3"
vm_inst_os_image_datacenter_core    = "Windows Server 2019 SERVERDATACENTERCORE"
vm_inst_os_image_datacenter_desktop = "Windows Server 2019 SERVERDATACENTER"
vm_inst_os_kms_key_datacenter       = "3W2NV-GC77Q-WMM6J-8KM77-GCR77"
vm_inst_ip                          = "192.168.1.191"
vm_inst_ip_mask                     = "192.168.1.191/24"
vm_inst_ip_gw                       = "192.168.1.254"
vm_inst_ip_dns1                     = "192.168.1.1"
vm_inst_ip_dns2                     = "192.168.1.5"
vm_inst_ip_domain                   = "home.local"

// Guest Operating System Metadata
vm_guest_os_language           = "fr-FR"
vm_guest_os_keyboard           = "fr-FR"
vm_guest_os_timezone           = "UTC-4"
vm_guest_os_family             = "windows"
vm_guest_os_name               = "server"
vm_guest_os_version            = "2019"
vm_guest_os_edition_standard   = "standard"
vm_guest_os_edition_datacenter = "datacenter"
vm_guest_os_experience_core    = "core"
vm_guest_os_experience_desktop = "dexp"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "windows2019srvNext_64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
vm_cdrom_type            = "ide"
vm_cpu_count             = 1
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 4096
vm_mem_hot_add           = false
vm_disk_size             = 102400
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_path           = "ISO/windows/"
iso_file           = "SW_DVD9_Win_Server_STD_CORE_2019__64Bit_French_DC_STD_MLF_X22-31945.ISO"

// Boot Settings
vm_boot_order       = "disk,cdrom"
vm_boot_wait        = "2s"
vm_boot_command     = ["<spacebar>"]
vm_shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Shutdown by Packer\""

// Communicator Settings
communicator_port    = 5985
communicator_timeout = "12h"

// Provisioner Settings
scripts = ["scripts/windows-prepare.ps1"]
inline = [
  "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))",
  "choco feature enable -n allowGlobalConfirmation",
  "Get-EventLog -LogName * | ForEach { Clear-EventLog -LogName $_.Log }",
   "netsh winhttp set proxy 192.168.1.229:8080"
]
