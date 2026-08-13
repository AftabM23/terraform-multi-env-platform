resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion_pip_config.pip_name
  location            = var.bastion_pip_config.location
  resource_group_name = var.bastion_pip_config.rg_name

  allocation_method = "Static"
  sku               = "Standard"
}


resource "azurerm_bastion_host" "this" {
    name = var.bastion_config.bastion_name
    resource_group_name = var.bastion_config.rg_name
    location = var.bastion_config.location
      sku = "Standard"

    ip_configuration {
      name = "bastion-ip-config"
      subnet_id =var.bastion_config.subnet_id
      public_ip_address_id = azurerm_public_ip.bastion_pip.id
    }
  
}
