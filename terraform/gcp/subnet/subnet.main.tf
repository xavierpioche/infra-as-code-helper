resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.subnet_region
  network       = var.subnet_vpc_name
  project       = var.project_id
}

