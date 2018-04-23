function disableFireWall(){
Write-host "Disable Firewall" $Path -ForegroundColor Green
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
}

function setFireWallRule(){
Write-host "Set Firewall Rule" $Path -ForegroundColor Green
    New-NetFirewallRule -DisplayName "Master File Sharing (SMB-In)" -Description "Allows inbound traffic from Client to Access Files" -Group "File and Printer Sharing" -Action Allow -Direction Inbound -InterfaceType Any -Profile Any -LocalAddress Any -LocalPort 445 -RemoteAddress Any -RemotePort Any -Protocol TCP  
}

setFireWallRule("")
disableFireWall("")
