
data "terraform_remote_state" "rg_terraform_output" {
  backend = "local"

  config = {
     path = "../0_resources_groups/terraform.tfstate"
  }
}

module "nsg" {
    source = "../modules/nsg/"
    nsg_name = var.nsg_name
    nsg_location = var.nsg_location
    nsg_resource_group = data.terraform_remote_state.rg_terraform_output.outputs.rg_names[0]["first"].rg_name
    nsg_rules = local.nsg_all_rules
}


output "nsg_id" {
  value = module.nsg.nsg_id
}