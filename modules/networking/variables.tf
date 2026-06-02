variable "vnet_name" {
    type = string
    description = "name of the vnet"
  
}

variable "address_space" {
  type = list(string)
  description = "address space of the vnet"
}
variable "location" {
  type = string
  description = "location of the vnet"
}

variable "resource_group_name" {
  type = string
  description = "name of the resource group"
}


variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    nsg_name =string
    nsg_rule=optional( list(object({
      name = string
      priority = number
      protocol = string
      source_address_prefix = string
      source_port_range = string
      destination_address_prefix  = string
      destination_port_range = string
      access = string
      direction= string

    })),[])

  }))
}


