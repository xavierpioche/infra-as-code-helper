// Installation Operating System Metadata
vm_inst_os_language                 = "fr-FR"
vm_inst_os_keyboard                 = "fr-FR"
vm_inst_os_image_standard_core      = "Windows Server 2022 SERVERSTANDARDCORE"
vm_inst_os_image_standard_desktop   = "Windows Server 2022 SERVERSTANDARD"
vm_inst_os_kms_key_standard         = "XXXXX-YYYYY-ZZZZZ-AAAAA-BBBBB"
vm_inst_os_image_datacenter_core    = "Windows Server 2022 SERVERDATACENTERCORE"
vm_inst_os_image_datacenter_desktop = "Windows Server 2022 SERVERDATACENTER"
vm_inst_os_kms_key_datacenter       = "XXXXX-YYYYY-ZZZZZ-AAAAA-BBBBB"
vm_inst_ip                          = "192.168.1.191"
vm_inst_ip_mask                     = "192.168.1.191/24"
vm_inst_ip_prefix                   = "24"
vm_inst_ip_gw                       = "192.168.1.1"
vm_inst_ip_dns1                     = "192.168.1.1"
vm_inst_ip_dns2                     = "192.168.1.2"
vm_inst_ip_domain                   = "home.local"
vm_inst_proxy_onoff                  = "0"
vm_inst_proxy_ip                    = "192.168.1.25"
vm_inst_proxy_port                  = "3128"

// Guest Operating System Metadata
vm_guest_os_language           = "fr-FR"
vm_guest_os_keyboard           = "fr-FR"
vm_guest_os_timezone           = "UTC-4"
vm_guest_os_family             = "windows"
vm_guest_os_name               = "server"
vm_guest_os_version            = "2022"
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
iso_file           = "SW_DVD9_Win_Server_STD_CORE_2022_2108.17_64Bit_French_DC_STD_MLF_X23-35660.ISO"
//iso_file           = "SW_DVD9_Win_Server_STD_CORE_2022__64Bit_French_DC_STD_MLF_X22-74294.ISO"

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
  "f:\\windows-prepare.ps1" 
   //"netsh winhttp set proxy 192.168.1.29:8080"
]
