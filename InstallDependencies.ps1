function getProperty($prop){
$props_file = Get-Content "$PWD\Dependencies.properties"
$props = @{}
$props_file | % {
    $s = $_ -split "="
    $props.Add($s[0],$s[1])
}
$the_dir = $props.$prop
return $the_dir
}

function downloadFile(){
$url="$JMeterSourceUrl$JMeterVersion"+".zip"
$url=$url.Replace('"','')

$WebClient=New-Object System.Net.WebClient
Write-Host "Downloading" $Path -ForegroundColor Green 
    $WebClient.DownloadFile($url,$JMeterZipFile)

}

function unzip(){
 #[System.IO.Compression.ZipFile]::ExtractToDirectory($JMeterZipFile,$destinationPath)
 Add-Type -A 'System.IO.Compression.FileSystem'; 
[IO.Compression.ZipFile]::ExtractToDirectory($JMeterZipFile,$destinationPath);
}

function setEnvironmentalVariable(){
Write-host "Set environmental variable" $Path -ForegroundColor Green
[Environment]::SetEnvironmentVariable("PATH", $env:Path + ";C:\Program Files\apache-jmeter-4.0\bin\;C:\Program Files\Java\jdk1.8.0_161\bin\;", 'Machine')
[Environment]::SetEnvironmentVariable("JMETER_HOME", "C:\Program Files\apache-jmeter-4.0", 'Machine')
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_161", 'Machine')

[Environment]::SetEnvironmentVariable("PATH", $env:Path + ";C:\Program Files\apache-jmeter-4.0\bin\;C:\Program Files\Java\jdk1.8.0_161\bin\;", 'User')
[Environment]::SetEnvironmentVariable("JMETER_HOME", "C:\Program Files\apache-jmeter-4.0", 'User')
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_161", 'User')
}



function installJava(){

Write-Host "Java Installtion" $Path -ForegroundColor Green 
    Start-Process $JavaFile -ArgumentList 'INSTALL_SILENT=Enable REBOOT=Disable SPONSORS=Disable' -Wait -PassThru
}

function disableFireWall(){
Write-host "Disable Firewall" $Path -ForegroundColor Green
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
}

function setFireWallRule(){
Write-host "Set Firewall Rule" $Path -ForegroundColor Green
    New-NetFirewallRule -DisplayName "Master File Sharing (SMB-In)" -Description "Allows inbound traffic from Client to Access Files" -Group "File and Printer Sharing" -Action Allow -Direction Inbound -InterfaceType Any -Profile Any -LocalAddress Any -LocalPort 445 -RemoteAddress Any -RemotePort Any -Protocol TCP  
}


$JMeterSetupPath=getProperty("JMeterSetupPath").Replace('"','')
$JMeterVersion=getProperty("JMeterVersion")
$destinationPath=getProperty("DestinationPath")
$JMeterZipFile="$JMeterSetupPath$JMeterVersion"+".zip"
$JMeterZipFile=$JMeterZipFile.Replace('"','')

$JavaSetupPath=getProperty("JavaSetupPath")
$JavaSetupFile=getProperty("JavaSetupFile")
$JavaFile="$JavaSetupPath$JavaSetupFile"
$JavaFile=$JavaFile.Replace('"','')




unzip("")
setFireWallRule("")
installJava("")
setEnvironmentalVariable("")
disableFireWall("")
