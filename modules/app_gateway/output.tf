output "appgateway_pip" {
    value = azurerm_public_ip.this.ip_address
}
output "gateway_id" {
    value = azurerm_application_gateway.this.id
  
}

output "gateway_name" {
    value = azurerm_application_gateway.this.name
  
}
output "backend_pool_ids" {
  value = {
    for pool in azurerm_application_gateway.this.backend_address_pool :
    pool.name => pool.id
  }
}