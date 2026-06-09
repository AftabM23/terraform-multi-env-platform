variable "pip-name" {
    type = string
    description = "name of the public IP"
  
}

variable "location" {
    type = string
    description = "location"
}

variable "rg-name" {
  type = string
  description = "name of the resource group"
}

variable "pip-allocationMethod" {
  type = string
  description = "PIP allocation method"
}