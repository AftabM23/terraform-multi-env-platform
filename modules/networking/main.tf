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

locals {
  nsg_rules_flat=flatten([
    for subnet_name, subnet in var.subnets:[
      for rule in subnet.nsg_rule :{
        subnet_name = subnet_name
        key ="${subnet_name}-${rule.name}"
        name = rule.name
        priority = rule.priority
        protocol = rule.protocol
        source_address_prefix = rule.source_address_prefix
        source_port_range = rule.source_port_range
        destination_address_prefix = rule.destination_address_prefix
        destination_port_range = rule.destination_port_range
        access = rule.access
        direction = rule.direction

      }
    ]
  
   ])
   nsg_rule_map ={
    for item in local.nsg_rules_flat : item.key => item
   }
}
resource "azurerm_network_security_rule" "this" {
  for_each                    = local.nsg_rule_map
  name                        = each.value.name
  access                      = each.value.access
  resource_group_name         = var.resource_group_name
  protocol                    = each.value.protocol
  direction                   = each.value.direction
  priority                    = each.value.priority
  source_address_prefix       = each.value.source_address_prefix
  source_port_range           = each.value.source_port_range
  destination_address_prefix  = each.value.destination_address_prefix
  destination_port_range      = each.value.destination_port_range
  network_security_group_name = azurerm_network_security_group.this[each.value.subnet_name].name
}