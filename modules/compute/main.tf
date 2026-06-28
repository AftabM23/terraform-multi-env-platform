resource "azurerm_linux_virtual_machine_scale_set" "this" {
    name = var.vmss_meta_config.vmss_name
    location = var.vmss_meta_config.location
    resource_group_name = var.vmss_meta_config.rg_name
    sku = var.vmss_meta_config.vmss_sku
    computer_name_prefix = car.vmss_meta_config.computer_prefix
    admin_username = var.vmss_credential.vmss_admin_username
    disable_password_authentication= true
    admin_ssh_key {
      username = var.vmss_credential.vmss_admin_username
      public_key = var.vmss_credential.vmss_public_ssh_key
    }
   
    instances = var.vmss_instances
    os_disk {
        caching = var.os_disk_config.caching
        storage_account_type = var.os_disk_config.storage_account_type
      
    }
    network_interface {
    
      name ="primary_nic"
      primary = true
      enable_accelerated_networking = var.vmss_accelerated_networking
      ip_configuration {
        name = "primary_nic_ipconfig"
        primary = true
        subnet_id = var.nic_ip_config.subnet_id
        application_gateway_backend_address_pool_ids = var.nic_ip_config.application_gateway_backend_address_pool_ids
      }
    }
    source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }


  
}