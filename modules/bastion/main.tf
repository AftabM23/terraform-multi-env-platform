resource "azurerm_public_ip" "this" {
    name = var.bastion_pip.name
    location = var.bastion_pip.location
    resource_group_name = var.bastion_pip.rg_name
    allocation_method = "Static"
    sku = "Standard"

  
}

resource "azurerm_bastion_host" "this" {
    name = var.bastion_metaconfig.name
    resource_group_name = var.bastion_metaconfig.rg_name
    location = var.bastion_metaconfig.location

    ip_configuration {
      name = var.bastion_ip_config.name
      subnet_id = var.bastion_ip_config.subnet_id
    }
  
}