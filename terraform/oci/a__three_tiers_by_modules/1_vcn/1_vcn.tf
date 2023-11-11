data "terraform_remote_state" "compartment_terraform_output" {
  backend = "local"

  config = {
     path = "../0_compartments/terraform.tfstate"
  }
}

# Source from https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/
module "vcn"{
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.1.0"
  # insert the 5 required variables here

  # Required Inputs
  compartment_id = data.terraform_remote_state.compartment_terraform_output.outputs.compartments_name[0].compartment_id
  region = var.my_region

  internet_gateway_route_rules = null
  local_peering_gateways = null
  nat_gateway_route_rules = null

  # Optional Inputs
  vcn_name = var.vcn_name
  vcn_dns_label = var.vcn_dns_label
  vcn_cidrs = var.vcn_cidrs
  
  create_internet_gateway = true
  create_nat_gateway = false
  create_service_gateway = false
}

output vcn_id {
	value = module.vcn.vcn_id
}

output route_table_id {
	value = module.vcn.nat_route_id
}
