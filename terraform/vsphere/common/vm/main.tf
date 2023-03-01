
data "vsphere_datacenter" "dc" {
  name = var.vs_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vs_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vs_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name = var.vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vs_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "rpool" {
  name              = "/${var.vs_datacenter}/host/${var.vs_cluster}/Resources/${var.vs_resourcepool}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name = "${var.vm_prefix}-${var.vm_site}-${var.vm_suffix}-${var.vm_name}"
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.rpool.id
  #resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  folder = var.vm_folder
  firmware = "efi"
  num_cpus = var.vm_cpu_map["${var.vm_cpu}"]
  memory = var.vm_memory_map["${var.vm_memory}"]
  guest_id = data.vsphere_virtual_machine.template.guest_id
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0
  wait_for_guest_net_routable = false
  migrate_wait_timeout = 90
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  scsi_controller_count = 1
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  disk {
     label = "disk0"
     size = data.vsphere_virtual_machine.template.disks.0.size
     eagerly_scrub = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
     thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
     unit_number = 0
  }
  
  dynamic "disk" {
    for_each = var.vm_datadsk != "" ? [1] : []
    content {
      label = "disk1"
      size = var.vm_vm_datadsk_map["${var.vm_datadsk}"]
      eagerly_scrub = false
      thin_provisioned = true
      unit_number = 14
    }
  }

  clone {
     template_uuid = data.vsphere_virtual_machine.template.id
     customize {
         timeout = 0

         dynamic "windows_options" {
            for_each = var.vm_is_windows == true ? [1] : []
            content {
                      #computer_name = "${var.vm_prefix}-${var.vm_site}-${var.vm_suffix}-${var.vm_number}"
                      computer_name = "${var.vm_prefix}-${var.vm_suffix}-${var.vm_name}"
            }
          }

         dynamic "linux_options" {
            for_each = var.vm_is_windows == false ? [1] : [] 
            content {
                       #host_name = "${var.vm_prefix}-${var.vm_site}-${var.vm_suffix}-${var.vm_number}"
                       host_name = "${var.vm_prefix}-${var.vm_suffix}-${var.vm_name}"
                       domain = var.vm_dns_search
            }
          }

         network_interface {
               ipv4_address = var.vm_ipaddress != "" ? var.vm_ipaddress : null
               ipv4_netmask = var.vm_netmask != "" ? var.vm_netmask : null
               dns_domain   = var.vm_ipaddress != "" ? var.vm_dns_search : null
               dns_server_list =  var.vm_ipaddress != "" ? [var.vm_dns_list] : null

          }
      ipv4_gateway = var.vm_gateway != "" ? var.vm_gateway : null
     }
  }
}
