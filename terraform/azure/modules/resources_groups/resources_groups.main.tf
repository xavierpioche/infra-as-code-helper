resource "random_pet" "rg_name" {
  prefix = var.rg_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.rg_location
  name     = random_pet.rg_name.id
}
