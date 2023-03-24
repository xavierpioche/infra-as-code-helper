data "terraform_remote_state" "vnet_terraform_output" {
  backend = "local"

  config = {
     path = "../2_vnet/terraform.tfstate"
  }
}

data "terraform_remote_state" "nsg_terraform_output" {
  backend = "local"

  config = {
     path = "../1_nsg/terraform.tfstate"
  }
}

module "nsg_to_vnet" {
    source = "../modules/nsg-to-vnet/"
    all_vnets = data.terraform_remote_state.vnet_terraform_output.outputs.vnet_ids
    the_nsg = data.terraform_remote_state.nsg_terraform_output.outputs.nsg_id
}