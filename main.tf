module "rg" {
  source   = "./modules/resource_group"
  name     = "rg1-terra01"
  location = "canadacentral"

}


module "network" {
  source              = "./modules/networking"
  vnet_name           = "abvnet1"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = module.rg.name
  location            = module.rg.location

  subnets = {
    webSubnet = {
      address_prefixes = ["10.0.1.0/24"]
      nsg_name         = "internet-web-nsg"
      nsg_rule =[{
        name = "Allow-InternetTraffic"
        priority =  110
        protocol = "*"
        access = "Allow"
        source_address_prefix = "Internet"
        source_port_range ="*"
        destination_address_prefix = "10.0.1.0/24"
        destination_port_range= "443"
        direction = "Inbound"
      }]
    },
    appSubnet = {
      address_prefixes = ["10.0.2.0/24"]
      nsg_name         = "web-app-nsg"
      nsg_rule=[{
         name = "Allow-webToApp"
        priority =  110
        protocol = "*"
        access = "Allow"
        source_address_prefix = "10.0.1.0/24"
        source_port_range ="*"
        destination_address_prefix = "10.0.2.0/24"
        destination_port_range= "*"
        direction = "Inbound"
      }]
    }
    dbSubnet = {
      address_prefixes = ["10.0.3.0/24"]
      nsg_name         = "app-db-nsg"
      nsg_rule=[{
         name = "Allow-appToDB"
        priority =  110
        protocol = "*"
        access = "Allow"
        source_address_prefix = "10.0.2.0/24"
        source_port_range ="*"
        destination_address_prefix = "10.0.3.0/24"
        destination_port_range= "*"
        direction = "Inbound"
      }]
    
    }
    appGateway-subnet={
        address_prefixes = ["10.0.4.0/24"]
      }
      AzureBastionSubnet = {
        address_prefixes =["10.0.5.0/26"]
      }
  }

}

module "app_gateway" {
  source = "./modules/app_gateway"
  pip_name = "gateway_pip1"
  location = module.rg.location
  rg_name = module.rg.name
  appGateway_name = "ab_appgateway"
  gateway_sku = {
    name = "Standard_v2"
    tier = "Standard_v2"
    capacity = 2

  }
  gateway_autoscaling_config = {
    max = 10
    min = 2
  }
  frontend_config = {
    frontend_ip_config_name = "abgateway1_frontend_config"
    frontend_port_name = "http-port"
    frontend_port_number = 80
  }
  http_listener_name = "ab_http_listener01"
  listener_protocol_type = "Http"
  routing_rule_config = {
    rule1={
    routing_rule_type ="Basic"
    routing_rule_priority =110
    backend_http_listener_name = "ab_http_listener01"
    backend_address_pool_name="ab_backend"
    backend_http_settings_name = "ab_http_backend_settings"

  }}
  backend_http_settings = {
  
    ab_http_backend_settings={
      cookie_based_affinity = "Enabled"
      protocol= "Http"
      port = 80
      request_timeout = 140
    }
  }
  appGW-subnetID = module.network. appGateway_subnet_id
 backend_pool_config = {
   ab_backend ={}
 }
  
}

module "compute_vmss"{
  source = "./modules/compute"
  vmss_meta_config = {
    rg_name = module.rg.name
    location = module.rg.location
    vmss_name = "abvmss"
    vmss_sku = "Standard_D2as_v5"
  }
  vmss_instances = 1
  vmss_credential = {
    vmss_admin_username = "aftab"
    vmss_admin_password = "Ab@230599"
  }
  os_disk_config = {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }
  source_image_reference = {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  nic_ip_config = {
    subnet_id = module.network.app_subnet_id
  }

  }