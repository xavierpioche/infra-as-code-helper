#-------------------------------------------------------------------------------------------------------#
########---- PROJECT ----########
module "gcp_project" {
  source="./project"
  project_name=var.project_name
  project_id=var.project_id
  billing_account=var.billing_account
}


#-------------------------------------------------------------------------------------------------------#
########---- VPC ----########
module "gcp_vpc" {
  source="./vpc"
  project_name=var.project_name
  vpc_name=var.vpc_name  
}

#-------------------------------------------------------------------------------------------------------#
########---- SUBNETS ----########
locals {
  all_subnets = {for s in var.all_subnet_name: index(var.all_subnet_name, s) => s}
}

module "gcp_subnet" {
  for_each = local.all_subnets
  source = "./subnet"
  subnet_name = var.all_subnet_name["${each.key}"]
  subnet_cidr = var.all_subnet_cidr["${each.key}"]
  subnet_region = var.all_subnet_region["${each.key}"]
  subnet_vpc_name = var.vpc_name
  project_id = var.project_id
}


#-------------------------------------------------------------------------------------------------------#
########---- FIREWALL ----########
locals {
  all_rules = {for s in var.all_firewall_rules: index(var.all_firewall_rules, s) => s}
}

module "firewall_rules" {
  for_each = local.all_rules
  source       = "./firewall-rules"
  project_id   = var.project_id
  vpc_name = var.vpc_name
  firewall_rule_name = var.all_firewall_rules["${each.key}"]["name"]
  firewall_rule_desc = var.all_firewall_rules["${each.key}"]["desc"]
  firewall_rule_protocol = var.all_firewall_rules["${each.key}"]["protocol"]
  firewall_rule_ports = var.all_firewall_rules["${each.key}"]["ports"]
  firewall_rule_source_ranges = var.all_firewall_rules["${each.key}"]["source"]
  firewall_rule_source_tags = var.all_firewall_rules["${each.key}"]["sourcetags"]
  firewall_rule_target_tags = var.all_firewall_rules["${each.key}"]["targettags"]
}

#-------------------------------------------------------------------------------------------------------#
########---- ROUTES ----########
locals {
  all_routes = {for s in var.all_route_rules: index(var.all_route_rules, s) => s}
}

module "gcp_route" {
  source            = "./route"
  project_id        = var.project_id
  vpc_name      = var.vpc_name 
  routes            = var.all_route_rules
}
