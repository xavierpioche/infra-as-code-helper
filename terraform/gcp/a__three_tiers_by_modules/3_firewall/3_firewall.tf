########---- FIREWALL ----########
locals {
  all_rules = {for s in var.all_firewall_rules: index(var.all_firewall_rules,
 s) => s}
}

module "firewall_rules" {
  for_each     = local.all_rules
  source       = "../modules/firewall-rules"
  project_id   = var.project_id
  vpc_name     = var.vpc_name
  firewall_rule_name = var.all_firewall_rules["${each.key}"]["name"]
  firewall_rule_desc = var.all_firewall_rules["${each.key}"]["desc"]
  firewall_rule_protocol = var.all_firewall_rules["${each.key}"]["protocol"]
  firewall_rule_ports = var.all_firewall_rules["${each.key}"]["ports"]
  firewall_rule_source_ranges = var.all_firewall_rules["${each.key}"]["source"]
  firewall_rule_source_tags = var.all_firewall_rules["${each.key}"]["sourcetags"]
  firewall_rule_target_tags = var.all_firewall_rules["${each.key}"]["targettags"]
}

