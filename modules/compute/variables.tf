variable "vmss_meta_config" {
    type = object({
      vmss_name = string
      location =string
      rg_name = string
      vmss_sku = string
      computer_prefix = string
    })
  
}
variable "vmss_instances"{
  type =number
}
variable "vmss_credential" {
    type = object({
      vmss_admin_username = string
      vmss_public_ssh_key = string 
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
  default =false
  description = "vmss accelerated networking"
  
}

variable "nic_ip_config" {
  type = object({
    subnet_id = string
   application_gateway_backend_address_pool_ids = optional(list(string),[])

  })
  
}

variable "source_image_reference" {
 type=object({
   publisher = string
   offer = string
   sku = string
   version = string 
 })  
}
variable "rules" {
  type = map(object({
    metric_name = string
    metric_namespace= string
    time_grain = string
    time_window = string
    statistic = string
    time_aggregation= string
    operator = string
    threshold= number
    scale_action_direction= string
    scale_action_type = string
    scale_action_value = number
    scale_action_cooldown = string
  }))
}

variable "vmss_autoscale_metaconfig" {
  type = object({
    name =string
    location = string
    rg_name = string 
  })
  
}
variable "vmss_autoscale_profile" {

  
  type = object({
    capacity_maximum =number
    
    capacity_minimum =number 
    default = number
  })
  
}