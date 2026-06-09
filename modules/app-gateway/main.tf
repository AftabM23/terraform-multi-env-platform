resource "azurerm_public_ip" "this" {
  name = var.pip-name
  location = var.location
  resource_group_name = var.rg-name
  allocation_method = var.pip-allocationMethod
  
  
}