resource "google_compute_network" "vpc" {
  project                 = var.project_name
  name                    = var.vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

