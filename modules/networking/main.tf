resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name =var.resource_group_name
  location            =var.location
  address_space       = var.address_space
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets
  name = each.key
  address_prefixes =  each.value.address_prefixes
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  
}

resource "azurerm_network_security_group" "this" {
  for_each = var.subnets
  location = var.location
  resource_group_name = var.resource_group_name
  name = each.value.nsg_name 
 
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.subnets
  network_security_group_id = azurerm_network_security_group.this[each.key].id
  subnet_id = azurerm_subnet.this[each.key].id
  
}