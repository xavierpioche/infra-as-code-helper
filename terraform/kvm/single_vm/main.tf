##
# KVM terraform test file
##
#resource "libvirt_network" "kvm_network" {
#  name = "terrabridge"
#  mode = "bridge"
#  bridge = "br0"
#  autostart = "true"
#}

# Defining VM Volume
resource "libvirt_volume" "centos7-qcow2" {
  name = "dnsvmw.qcow2"
  pool = "kvmpool01" # List storage pools using virsh pool-list
  #source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  source = "/home/xavier/Downloads/ISO/CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

# Define KVM domain to create
resource "libvirt_domain" "centos7" {
  name   = var.vm_name
  memory = "1024"
  vcpu   = 1

  network_interface {
    network_name = "default" # List networks with virsh net-list
  }

  disk {
    volume_id = "${libvirt_volume.centos7-qcow2.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

# Output Server IP
#output "ip" {
#  value = "${libvirt_domain.centos7.network_interface.0.addresses.0}"
#}
