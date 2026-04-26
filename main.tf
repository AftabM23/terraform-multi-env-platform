module "rg" {
    source = "./modules/resource_group"
    name = "rg1"
    location = "canadacentral"
  
}
module "network" {
    source = "./modules/networking"
    vnet_name= "abvnet1"
    address_space = [ "10.0.0.0/16" ]
    resource_group_name = module.rg.name
    location = module.rg.location
    subnet_name = "webSubnet"
  subnet_address_prefixes = ["10.0.1.0/24"]
  
}