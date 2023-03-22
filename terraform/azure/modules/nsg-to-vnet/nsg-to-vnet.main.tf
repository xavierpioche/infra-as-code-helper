resource "azurerm_subnet_network_security_group_association" "mgmt-nsg-association" {
    for_each = toset(var.all_vnets)
    subnet_id                 = each.value
    network_security_group_id = var.the_nsg
}