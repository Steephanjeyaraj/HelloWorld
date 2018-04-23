#network variables 

location_name = "southindia"
vnet="pt-network"
resource_grp="pt-net-rg"
subnet="pt-subnet"
nsg_name="pt-nsg"
backend_name="pt-rdp-back"
lb_name="pt-lb"
resource_group_name = "pt-net-rg" 

network_interface_name="pt-nic-slave" 
srvr_vm_name = "pttest0002" 
srvr_vm_size = "Standard_D2s_v3" 
srvr_publish = "MicrosoftWindowsServer" 
srvr_offer = "WindowsServer" 
srvr_sku = "2012-R2-Datacenter" 
srvr_admin_username = "ptcoeadmin" 
ps_file_uris = ["https://raw.githubusercontent.com/Steephanjeyaraj/HelloWorld/Build01/src/main/powerShellScripts/fireWallSetup.ps1"]
