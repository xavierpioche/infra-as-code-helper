########---- SUBNETS ----########
locals {
  all_subnets = {for s in var.all_subnet_name: index(var.all_subnet_name, s)=> s}
}

module "gcp_subnet" {
  for_each = local.all_subnets
  source = "../modules/subnet"

  #subnet_name = var.all_subnet_name["${each.key}"]
  subnet_name=var.all_subnet_param["${each.value}"]["name"]

  #subnet_cidr = var.all_subnet_cidr["${each.key}"]
  subnet_cidr=var.all_subnet_param["${each.value}"]["cidr"]

  #subnet_region = var.all_subnet_region["${each.key}"]
  subnet_region=var.all_subnet_param["${each.value}"]["region"]

  subnet_vpc_name = var.vpc_name
  project_id = var.project_id
}

