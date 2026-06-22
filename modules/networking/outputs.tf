output "vnet_id" {
value = azurerm_virtual_network.this.id
  
}
output "appGateway_subnet_id" {
    value = azurerm_subnet.this["appGateway-subnet"].id
  
}