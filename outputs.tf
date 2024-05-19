
output "prod_vnet_id" {
  value = azurerm_virtual_network.prod_vnet.id
}

output "qa_vnet_id" {
  value = azurerm_virtual_network.qa_vnet.id
}

output "test_vnet_id" {
  value = azurerm_virtual_network.test_vnet.id
}
