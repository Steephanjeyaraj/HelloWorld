provider "azurerm" { 
	subscription_id = "${var.subscription_id}" 
	client_id = "${var.client_id}" 
	client_secret = "${var.client_secret}" 
	tenant_id = "${var.tenant_id}" 
} 



resource "azurerm_virtual_machine_extension" "azurevm_ps" {
name = "pttest0002ps"
location = "${var.location_name}"
resource_group_name = "${var.resource_group_name}"
virtual_machine_name = "${var.srvr_vm_name }"
publisher = "Microsoft.Compute"
type = "CustomScriptExtension"
type_handler_version = "1.8"
#depends_on = ["azurerm_virtual_machine.azurevm"]
settings = <<SETTINGS
{

"fileUris":["${join("\",\"", var.ps_file_uris)}"]
}
SETTINGS
protected_settings = <<PROTECTED_SETTINGS
    {
"commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File InstallDependencies.ps1 -User ptcoeadmin"
    }
    PROTECTED_SETTINGS
 
}
