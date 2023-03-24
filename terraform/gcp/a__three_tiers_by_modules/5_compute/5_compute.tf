locals {
  all_computes = { for s in var.all_subnet_name: index(var.all_subnet_name, s) => s }
}

module "gcp_engine_1" {
  for_each          = local.all_computes
  source     =   "../modules/compute"
  vm_name    =   var.all_computes_1["${each.value}"]["name"]
  vm_type    =   var.all_computes_1["${each.value}"]["type"]
  vm_zone    =   var.all_subnet_param["${each.value}"]["region"]
  vm_image   =   var.all_computes_1["${each.value}"]["image"]
  vm_network =   var.all_subnet_param["${each.value}"]["name"]
  vm_ips     =   var.all_computes_1["${each.value}"]["ips"]
  vm_env     =   var.all_computes_1["${each.value}"]["env"]
  vm_cidr    =   var.all_subnet_param["${each.value}"]["cidr"]
  vm_project    =   var.project_id
  vpc_name   =   var.vpc_name
}
