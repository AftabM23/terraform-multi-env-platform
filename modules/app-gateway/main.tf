resource "azurerm_public_ip" "this" {
  name = var.pip-name
  location = var.location
  resource_group_name = var.rg-name
  allocation_method = var.pip-allocationMethod
  
  
}

# resource "azurerm_application_gateway" "this" {
#   name = var.appGateway-name
#   location = var.location
#   resource_group_name= var.rg-name 

#   frontend_ip_configuration {
    
#   }
#   frontend_port {
    
#   }
# }

# resource "azurerm_application_gateway" "ab_appGateway1" {
#   name                = "ab_appgateway1"
#   resource_group_name = azurerm_resource_group.rg1.name
#   location            = azurerm_resource_group.rg1.location
#   sku {
#     name     = "Standard_v2"
#     tier     = "Standard_v2"
#     capacity = 2
#   }
#   frontend_port {
#     name = "HTTP-port"
#     port = "80"
#   }
#   frontend_ip_configuration {
#     name                 = "frontend_IPConfig"
#     public_ip_address_id = azurerm_public_ip.appGateway_ip.id
#   }
#   backend_address_pool {
#     name = "backend_addressPool"


#   }
#   gateway_ip_configuration {
#     name      = "AppGateway_IPConfig"
#     subnet_id = azurerm_subnet.webSubnet.id
#   }
#   backend_http_settings {
#     name                  = "http-setting"
#     cookie_based_affinity = "Disabled"
#     port                  = 80
#     protocol              = "Http"
#     request_timeout       = 30
#     probe_name            = "health-probe"
#   }
#   http_listener {
#     name                           = "http-listener"
#     frontend_ip_configuration_name = "frontend_IPConfig"
#     frontend_port_name             = "HTTP-port"
#     protocol                       = "Http"
#   }

#   request_routing_rule {
#     name                       = "rule1"
#     rule_type                  = "Basic"
#     http_listener_name         = "http-listener"
#     backend_address_pool_name  = "backend_addressPool"
#     backend_http_settings_name = "http-setting"
#     priority                   = 100
#   }
#   probe {
#     name                = "health-probe"
#     protocol            = "Http"
#     host                = "localhost"
#     path                = "/"
#     interval            = 60
#     timeout             = 60
#     unhealthy_threshold = 2
#     match {
#       status_code = ["200-399"]
#     }
#   }

# }