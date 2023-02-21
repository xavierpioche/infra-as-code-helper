packer {
  required_version = ">= 1.8.5"
  required_plugins {
    vsphere = {
      version = ">= v1.1.1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

locals {
  build_by                   = "Built by: HashiCorp Packer ${packer.version}"
  build_date                 = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_date_fmt    = formatdate("YYYYMMDDhhmm", timestamp())
  iso_paths                  = ["[${var.common_iso_datastore}] ${var.iso_path}/${var.iso_file}", "[] /vmimages/tools-isoimages/${var.vm_guest_os_family}.iso"]
  vm_name_standard_desktop   = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}-socle"
}


source "vsphere-iso" "windows-server-standard-dexp" {

  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = var.vsphere_endpoint
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection

  // vSphere Settings
  datacenter = var.vsphere_datacenter
  cluster    = var.vsphere_cluster
  datastore  = var.vsphere_datastore
  folder     = var.vsphere_folder

  // Virtual Machine Settings
  vm_name              = local.vm_name_standard_desktop
  guest_os_type        = var.vm_guest_os_type
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_count
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = var.vm_cpu_hot_add
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = var.vm_mem_hot_add
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = var.vm_disk_thin_provisioned
  }
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vm_network_card
  }
  vm_version           = var.common_vm_version
  remove_cdrom         = var.common_remove_cdrom
  tools_upgrade_policy = var.common_tools_upgrade_policy

  // Removable Media Settings
  iso_paths    = local.iso_paths
  cd_files = [
    "scripts/"
  ]
  cd_content = {
    "autounattend.xml" = templatefile("data/autounattend.pkrtpl.hcl", {
      build_username       = var.build_username
      build_password       = var.build_password
      vm_inst_os_language  = var.vm_inst_os_language
      vm_inst_os_keyboard  = var.vm_inst_os_keyboard
      vm_inst_os_image     = var.vm_inst_os_image_standard_desktop
      vm_inst_os_kms_key   = var.vm_inst_os_kms_key_standard
      vm_guest_os_language = var.vm_guest_os_language
      vm_guest_os_keyboard = var.vm_guest_os_keyboard
      vm_guest_os_timezone = var.vm_guest_os_timezone
      vm_inst_ip_mask      = var.vm_inst_ip_mask
      vm_inst_ip_gw        = var.vm_inst_ip_gw
      vm_inst_ip_dns1      = var.vm_inst_ip_dns1
      vm_inst_ip_dns2      = var.vm_inst_ip_dns2
      vm_inst_ip_domain    = var.vm_inst_ip_domain
    }),
    "windows-init.ps1" = templatefile("data/windows-init.pkrtpl.hcl", {
      vm_inst_ip           = var.vm_inst_ip
      vm_inst_ip_gw        = var.vm_inst_ip_gw
      vm_inst_ip_dns1      = var.vm_inst_ip_dns1
      vm_inst_ip_dns2      = var.vm_inst_ip_dns2
      vm_inst_ip_domain    = var.vm_inst_ip_domain
      vm_inst_ip_prefix    = var.vm_inst_ip_prefix
      vm_inst_proxy_onoff   = var.vm_inst_proxy_onoff
      vm_inst_proxy_ip     = var.vm_inst_proxy_ip
      vm_inst_proxy_port   = var.vm_inst_proxy_port
    }),
    "windows-prepare.ps1" = templatefile("data/windows-prepare.pkrtpl.hcl", {
      build_key    = var.build_key
    })
  }

  // Boot and Provisioning Settings
  boot_order       = var.vm_boot_order
  boot_wait        = var.vm_boot_wait
  boot_command     = var.vm_boot_command
  ip_wait_timeout  = var.common_ip_wait_timeout
  shutdown_command = var.vm_shutdown_command
  shutdown_timeout = var.common_shutdown_timeout

  // Communicator Settings and Credentials
  communicator   = "winrm"
  winrm_username = var.build_username
  winrm_password = var.build_password
  winrm_port     = var.communicator_port
  winrm_timeout  = var.communicator_timeout

  // Template and Content Library Settings
  convert_to_template = var.common_template_conversion
} 


build {
  sources = [
    "source.vsphere-iso.windows-server-standard-dexp"
  ]

  //provisioner "powershell" {
  //  environment_vars = [
  //    "BUILD_USERNAME=${var.build_username}"
  //  ]
  //  elevated_user     = var.build_username
  //  elevated_password = var.build_password
  //  scripts           = formatlist("%s", var.scripts)
  //}

  provisioner "powershell" {
    elevated_user     = var.build_username
    elevated_password = var.build_password
    inline            = var.inline
  }
}
