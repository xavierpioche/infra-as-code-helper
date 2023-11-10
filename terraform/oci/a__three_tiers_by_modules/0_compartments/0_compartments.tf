module "compartments" {
  source="../modules/compartments"
  compartment_tenancy_id = var.compartment_tenancy_id
  compartment_name = var.compartment_name
}

output "compartments_name" {
	value = module.compartments[*]
}
