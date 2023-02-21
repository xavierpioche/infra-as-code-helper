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
  build_by          = "Built by: HashiCorp Packer ${packer.version}"
  build_date        = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_date_fmt    = formatdate("YYYYMMDDhhmm", timestamp())
  iso_paths         = ["[${var.common_iso_datastore}] ${var.iso_path}/${var.iso_file}"]
  vm_name             = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-socle"
  //vm_name             = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${local.build_date_fmt}"

 data_source_content = {
   "ks.cfg" = templatefile("data/ks.cfg.pkrtpl.hcl", {
      vm_inst_os_language = var.vm_inst_os_language
      vm_inst_os_keyboard = var.vm_inst_os_keyboard
      vm_inst_ip_device = var.vm_inst_ip_device
      vm_inst_ip_addr = var.vm_inst_ip_addr
      vm_inst_ip_mask = var.vm_inst_ip_mask
      vm_inst_ip_gw = var.vm_inst_ip_gw
      vm_inst_ip_dns1 = var.vm_inst_ip_dns1
      vm_inst_ip_dns2 = var.vm_inst_ip_dns2
      vm_name = var.vm_name
      ansible_password = var.ansible_password
      ansible_username = var.ansible_username
      ansible_key = var.ansible_key
      vm_inst_os_timezone = var.vm_inst_os_timezone
      vm_inst_ip_ntp1 = var.vm_inst_ip_ntp1
      authcommand = var.rh_authcommand
    })
  }

 data_source_command = var.common_data_source == "http" ? "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg" : "inst.ks=cdrom:/ks.cfg"
}

source "vsphere-iso" "linux-rhel" {

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
  vm_name              = local.vm_name
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
  http_content = var.common_data_source == "http" ? local.data_source_content : null
  cd_content   = var.common_data_source == "disk" ? local.data_source_content : null
  cd_label = "OEMDRV"
  cd_files = ["data/"]

  // Boot and Provisioning Settings
  http_ip       = var.common_data_source == "http" ? var.common_http_ip : null
  http_port_min = var.common_data_source == "http" ? var.common_http_port_min : null
  http_port_max = var.common_data_source == "http" ? var.common_http_port_max : null
  boot_order    = var.vm_boot_order
  boot_wait     = var.vm_boot_wait
  boot_command  = var.vm_boot_command

  ip_wait_timeout  = var.common_ip_wait_timeout
  shutdown_command = "echo '${var.build_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = var.common_shutdown_timeout

  // Communicator Settings and Credentials
  communicator       = "ssh"
  ssh_proxy_host     = var.communicator_proxy_host
  ssh_proxy_port     = var.communicator_proxy_port
  ssh_proxy_username = var.communicator_proxy_username
  ssh_proxy_password = var.communicator_proxy_password
  ssh_private_key_file = "~/.ssh/id_rsa"
  ssh_username       = var.build_username
  ssh_password       = var.build_password
  ssh_port           = var.communicator_port
  ssh_timeout        = var.communicator_timeout

  // Template and Content Library Settings
  convert_to_template = var.common_template_conversion
}

build {
  sources = ["source.vsphere-iso.linux-rhel"]

  provisioner "ansible" {
    user          = var.build_username
    playbook_file = "ansible/main.yml"
    roles_path    = "ansible/roles"
    ansible_env_vars = [
      "ANSIBLE_CONFIG=${path.cwd}/ansible/ansible.cfg"
    ]
    extra_arguments = [
      "--extra-vars", "display_skipped_hosts=false",
      "--extra-vars", "rhel_repository=${var.rhel_repository}",
      "--extra-vars", "rhel_username=${var.rhsm_username}",
      "--extra-vars", "rhel_password=${var.rhsm_password}"
    ]
  }
}
