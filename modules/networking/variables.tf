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
variable "subnet_name" {
  type = string
  description = "Name of the subnet"
  
}

variable "subnet_address_prefixes" {
  type = list(string)
  description = "subnet address prefix"
  
}