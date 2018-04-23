provider "azurerm" { 
	subscription_id = "${var.subscription_id}" 
	client_id = "${var.client_id}" 
	client_secret = "${var.client_secret}" 
	tenant_id = "${var.tenant_id}" 
} 
resource "azurerm_network_interface" "azurenic" {   
	name                      = "${var.network_interface_name}" 
	location                  = "${var.location_name}" 
	resource_group_name       = "${var.resource_group_name}" 
	network_security_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/networkSecurityGroups/${var.nsg_name}" 
  ip_configuration { 
	   name                          = "${var.network_interface_name}" 
	   subnet_id	="/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.vnet}/subnets/${var.subnet}" 
	   private_ip_address_allocation = "dynamic" 
  } 
} 

resource "azurerm_virtual_machine" "azurevm" {   
  name                  = "${var.srvr_vm_name}" 
  location              = "${var.location_name}" 
  resource_group_name   = "${var.resource_group_name}"   
  network_interface_ids = ["${azurerm_network_interface.azurenic.id}"] 
  vm_size               = "${var.srvr_vm_size}" 

  storage_image_reference { 
    publisher = "${var.srvr_publish}" 
    offer     = "${var.srvr_offer}" 
    sku       = "${var.srvr_sku}" 
    version   = "latest" 
  }

  storage_os_disk { 
    name              = "${var.srvr_vm_name}-OSdisk" 
    caching           = "ReadWrite" 
    create_option     = "FromImage" 
    managed_disk_type = "Standard_LRS" 
  }
  delete_os_disk_on_termination = "true" 
  os_profile { 
    computer_name  = "${var.srvr_vm_name}" 
    admin_username = "${var.srvr_admin_username}" 
    admin_password = "${var.srvr_admin_password}" 
  } 
  os_profile_windows_config { 
    provision_vm_agent = true 
  } 
} 

resource "azurerm_virtual_machine_extension" "azurevm_ps" {
name = "pttest0002ps1"
location = "${var.location_name}"
resource_group_name = "${var.resource_group_name}"
virtual_machine_name = "${var.srvr_vm_name }"
publisher = "Microsoft.Compute"
type = "CustomScriptExtension"
type_handler_version = "1.8"
depends_on = ["azurerm_virtual_machine.azurevm"]
settings = <<SETTINGS
{
"fileUris":["${join("\",\"", var.ps_file_uris)}"]
}
SETTINGS
protected_settings = <<PROTECTED_SETTINGS
    {
"commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File fireWallSetup.ps1"
    }
    PROTECTED_SETTINGS
 
}


output "ip" {
	value = "${azurerm_network_interface.azurenic.private_ip_address}"
}
	

