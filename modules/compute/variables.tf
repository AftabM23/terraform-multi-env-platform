variable "vmss_meta_config" {
    type = object({
      vmss_name = string
      location =string
      rg_name = string
      vmss_sku = string
    })
  
}
variable "vmss_redential" {
    type = object({
      vmss_admin_username = string
      vmss_admin_password = string 
    })
  
}
variable "os_disk_config" {
    type = object({
      caching = string
      storage_account_type =  string
    })
  
}
variable "vmss_accelerated_networking" {
  type = bool
  default = true
  description = "vmss accelerated networking"
  
}

variable "nic_ip_config" {
  type = object({
    subnet_id = string
   application_gateway_backend_address_pool_ids = optional(list(string),[])

  })
  
}