resource "google_compute_firewall" "rules" {
  project     = var.project_id 
  name        = var.firewall_rule_name
  network     = var.vpc_name
  description = var.firewall_rule_desc

  allow {
    protocol = var.firewall_rule_protocol 
    ports    = var.firewall_rule_ports != "" ? [ var.firewall_rule_ports ] : null
  }

  source_ranges = [ var.firewall_rule_source_ranges ]
  target_tags = var.firewall_rule_target_tags != "" ? [ var.firewall_rule_target_tags ] : null
  source_tags = var.firewall_rule_source_tags != "" ? [ var.firewall_rule_source_tags ] : null
}
