module "rg" {
  source   = "./modules/resource_group"
  name     = "rg1-terra"
  location = "canadacentral"

}
module "network" {
  source                  = "./modules/networking"
  vnet_name               = "abvnet1"
  address_space           = ["10.0.0.0/16"]
  resource_group_name     = module.rg.name
  location                = module.rg.location
 
  subnets = {
    webSubnet ={
      address_prefixes = ["10.0.1.0/24"]
    },
    appSubnet = {
      address_prefixes = ["10.0.2.0/24"]
    }
    dbSubnet ={
      address_prefixes = ["10.0.3.0/24"]
    }
  }

}