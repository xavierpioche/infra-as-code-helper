module "resources_groups" {
  source="../modules/resources_groups"
  for_each = {
     for key, rsrc in var.all_rgs : 
       key => rsrc # if rsrc.is_created == "true"
  }
  rg_location = each.value.location
  rg_prefix = each.value.prefix
}

output "rg_names" {
 value = module.resources_groups[*]
}
