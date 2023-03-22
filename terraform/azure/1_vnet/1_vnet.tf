locals {
  
}

data "terraform_remote_state" "rg_terraform_output" {
  backend = "local"

  config = {
     path = "../0_resources_groups/terraform.tfstate"
  }
}

module "vnet" {
  source = "../modules/vnet/"
  vnet_name = var.vnet_name
  vnet_location = var.vnet_location
  vnet_rg_name = data.terraform_remote_state.rg_terraform_output.outputs.rg_names[0]["first"].rg_name
  vnet_all_subnets = var.vnet_all_subnets
  vnet_address_space = var.vnet_address_space
}
