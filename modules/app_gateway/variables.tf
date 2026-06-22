variable "pip_name" {
    type = string
    description = "name of the public IP"
  
}

variable "location" {
    type = string
    description = "location"
}

variable "rg_name" {
  type = string
  description = "name of the resource group"
}



variable "appGateway_name" {
  type = string
  description = "name of the gateway"
  
}

variable "gateway_sku" {
  type = object({
    name = string
    tier= string
    
    capacity= optional(number,2) 
  })
  validation {
    condition = contains(["Standard_v2","WAF_v2"],var.gateway_sku.name) && var.gateway_sku.name == var.gateway_sku.tier
    error_message = "gateway name and tier must be either 'Standard_v2' or 'WAF_v2' and both should be equal"
  }
  
}
variable "gateway_autoscaling_config" {
  type = object({
    max = optional(number, 10)
    min= number
  })
  default =null
  validation {
    condition =var.gateway_autoscaling_config == null || (var.gateway_autoscaling_config.min >0 &&  var.gateway_autoscaling_config.max >= var.gateway_autoscaling_config.min) 
    error_message = "minimum instance count must be more than 0"
  }
  
}
variable "frontend_config"{
  type = object({
    frontend_ip_config_name = string
    frontend_port_name = string
    frontend_port_number  = number
  })
}



variable "http_listener_name" {
  type = string
  description = "http-listener name"
}

variable "listener_protocol_type" {
  type = string
  description = "listener protocol type"
  validation {
    condition = contains (["http","https"], lower(var.listener_protocol_type))
    error_message = "listener_protocol_type must be either 'Http' or 'Https'"
  }
}

variable "routing_rule_config" {
  type = map(object({
    routing_rule_type= string
    routing_rule_priority = number 
    backend_http_listener_name = string
    backend_address_pool_name = string
    backend_http_settings_name = string
  }))
  
}


variable "backend_pool_config" {
  type = map(object({
    ip_addresses = optional(list(string), [])
    fqdns        = optional(list(string), [])

  }))
  
}

variable "backend_http_settings" {
  type = map(object({
    cookie_based_affinity = string
    protocol = string
    port= number
    request_timeout = number
  }))
  validation {
    condition =(
       alltrue([for  setting in values(var.backend_http_settings): setting.port >=1 && setting.port<=65535 ])
       ) && (
        alltrue([for setting in values(var.backend_http_settings):contains(["enabled","disabled"],lower(setting.cookie_based_affinity))]))
    error_message = "port number must be between 1 and 65535 and cookie based affinity must be enabled or disabled"
  }
}

variable "appGW-subnetID" {
  type = string
  description = "app gateway address subnet ID"
  
}



# tags for all the resources
variable "tags" {
  type = map(string)
  default =  {}
  
}