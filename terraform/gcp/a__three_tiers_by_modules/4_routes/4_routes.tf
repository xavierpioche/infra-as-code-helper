########---- ROUTES ----########
locals {
  all_routes = {for s in var.all_route_rules: index(var.all_route_rules, s) => s}
}

module "gcp_route" {
  source            = "../modules/route"
  project_id        = var.project_id
  vpc_name          = var.vpc_name
  routes            = var.all_route_rules
}

