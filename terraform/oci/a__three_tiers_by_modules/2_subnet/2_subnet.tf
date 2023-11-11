data "terraform_remote_state" "compartment_terraform_output" {
  backend = "local"

  config = {
     path = "../0_compartments/terraform.tfstate"
  }
}


data "terraform_remote_state" "vcn_terraform_output" {
  backend = "local"

  config = {
     path = "../1_vcn/terraform.tfstate"
  }
}

# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet

resource "oci_core_subnet" "vcn-private-subnet"{

  # Required
  compartment_id = data.terraform_remote_state.compartment_terraform_output.outputs.compartments_name[0].compartment_id
  vcn_id = data.terraform_remote_state.vcn_terraform_output.outputs.vcn_id
  #vcn_id = module.vcn.vcn_id
  cidr_block = var.my_subnet_private_cidr
 
  # Optional
  # Caution: For the route table id, use module.vcn.nat_route_id.
  # Do not use module.vcn.nat_gateway_id, because it is the OCID for the gateway and not the route table.

  #route_table_id = data.terraform_remote_state.vcn_terraform_output.outputs.route_table_id
  #security_list_ids = [oci_core_security_list.private-security-list.id]
  display_name = var.my_subnet_private_name
}
