resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name =var.resource_group_name
  location            =var.location
  address_space       = var.address_space
}

resource "azurerm_subnet" "this" {
  name = var.subnet_name
  address_prefixes =  var.subnet_address_prefixes
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  
}