variable "bastion_pip_config" {
    type = object({
      pip_name = string
      location = string
      rg_name = string
    })
  
}

variable "bastion_config" {
  
  type = object({
    bastion_name = string
    rg_name = string
    location = string
   subnet_id = string
  })
}