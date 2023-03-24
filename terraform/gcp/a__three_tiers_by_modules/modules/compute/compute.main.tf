data "google_compute_network" "main-default-vpc" {
  name    = var.vpc_name
  project = var.vm_project
}

data "google_compute_subnetwork" "subnet-for-vms" {
  name    = var.vm_network
  project = var.vm_project
  region  = var.vm_zone
}

resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.all_types["${var.vm_type}"]
  zone         = "${var.vm_zone}-b"
  project      = var.vm_project

  boot_disk {
    initialize_params {
      image = var.all_images["${var.vm_image}"]
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet-for-vms.self_link

    dynamic "access_config" {
    for_each = var.vm_ips == "0" ? [] : [1]
       content {
          // Ephemeral public IP
       }
    }
  }
}

