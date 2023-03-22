output "subnet_ids" {
    value = azurerm_virtual_network.network.subnet.*.id
}