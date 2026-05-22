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
  }))
}