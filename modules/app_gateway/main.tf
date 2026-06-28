resource "azurerm_public_ip" "this" {
  name = var.pip_name
  location = var.location
  resource_group_name = var.rg_name
  allocation_method ="Static"
  sku = "Standard"
  
}


resource "azurerm_application_gateway" "this" {
  name = var.appGateway_name
  location = var.location
  resource_group_name= var.rg_name 

  sku {
    name =var.gateway_sku.name
    tier = var.gateway_sku.tier
    capacity = var.gateway_autoscaling_config == null ? var.gateway_sku.capacity : null
  }

dynamic "autoscale_configuration" {
  for_each = var.gateway_autoscaling_config == null ? [] : [var.gateway_autoscaling_config]
  content {
    max_capacity = autoscale_configuration.value.max
    min_capacity =   autoscale_configuration.value.min
  }
  
}


  frontend_ip_configuration {
    name = var.frontend_config.frontend_ip_config_name
    public_ip_address_id = azurerm_public_ip.this.id
  }
  frontend_port {
    name = var.frontend_config.frontend_port_name
    port = var.frontend_config.frontend_port_number
  }
  http_listener {
    name = var.http_listener_name
    frontend_port_name = var.frontend_config.frontend_port_name
    frontend_ip_configuration_name = var.frontend_config.frontend_ip_config_name
    protocol = var.listener_protocol_type
  }

  dynamic "request_routing_rule" {
    for_each = var.routing_rule_config
    content {
      name = request_routing_rule.key
      rule_type = request_routing_rule.value.routing_rule_type
      priority = request_routing_rule.value.routing_rule_priority
      backend_address_pool_name = request_routing_rule.value.backend_address_pool_name
      http_listener_name = request_routing_rule.value.backend_http_listener_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
    }
     
  }
  dynamic "backend_address_pool" {
    for_each = var.backend_pool_config
    content {
      name = backend_address_pool.key
      ip_addresses = backend_address_pool.value.ip_addresses
      fqdns = backend_address_pool.value.fqdns
    }
    
  }
 
  gateway_ip_configuration {
    name = "gatewayIP-config"
    subnet_id = var.appGW-subnetID
  }
  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name = backend_http_settings.key
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      protocol = backend_http_settings.value.protocol
      request_timeout = backend_http_settings.value.request_timeout
      port = backend_http_settings.value.port
      probe_name = "nginx-backend-healthcheck-probe"
      pick_host_name_from_backend_address = true
    }
    
  }
  probe {
    name = "nginx-backend-healthcheck-probe"
    protocol = "Http"
    timeout = 40
    unhealthy_threshold = 3
    interval = 40
    path = "/"
    pick_host_name_from_backend_http_settings = true

  }
  tags = var.tags
}
