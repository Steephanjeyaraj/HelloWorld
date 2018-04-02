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
[IO.Compression.ZipFile]::ExtractToDirectory($JMeterZipFile, "C:\Users\ptadmin\");
}

function setEnvironmentalVariable(){
Write-host "Set environmental variable" $Path -ForegroundColor Green
[Environment]::SetEnvironmentVariable("PATH", $env:Path + ";C:\Users\ptadmin\apache-jmeter-4.0\bin\;C:\Program Files\Java\jdk1.8.0_161\bin\;", 'Machine')
[Environment]::SetEnvironmentVariable("JMETER_HOME", "C:\Users\ptadmin\apache-jmeter-4.0", 'Machine')
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_161", 'Machine')
}

function copySetupFiles(){
Write-Host "Copying Setup files" $Path -ForegroundColor Green 
$WebClient1= New-Object System.Net.WebClient
$WebClient1.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
$WebClient1.DownloadFile($SourceFile,$DestinationFile)
}


function installJava(){

Write-Host "Java Installtion" $Path -ForegroundColor Green 
    Start-Process $DestinationFile -ArgumentList 'INSTALL_SILENT=Enable REBOOT=Disable SPONSORS=Disable' -Wait -PassThru
}


function installPython(){
Write-host "Python Installation" $Path -ForegroundColor Green
    & $DestinationFile /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
}

function disableFireWall(){
Write-host "Disable Firewall" $Path -ForegroundColor Green
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
}

function setFireWallRule(){
Write-host "Set Firewall Rule" $Path -ForegroundColor Green
    New-NetFirewallRule -DisplayName "Master File Sharing (SMB-In)" -Description "Allows inbound traffic from Client to Access Files" -Group "File and Printer Sharing" -Action Allow -Direction Inbound -InterfaceType Any -Profile Any -LocalAddress Any -LocalPort 445 -RemoteAddress Any -RemotePort Any -Protocol TCP  
}


$JMeterSourceUrl=getProperty("JMeterSourceURL").Replace('"','')
$JMeterVersion=getProperty("JMeterVersion")
$destinationPath=getProperty("DestinationPath")
$JMeterZipFile="$destinationPath$JMeterVersion"+".zip"
$JMeterZipFile=$JMeterZipFile.Replace('"','')
$JMeterPath='C:\Users\ptadmin\'+"$JMeterVersion"+"\bin\"
$JMeterPath=$JMeterPath.Replace('"','')

$Source=getProperty("Source")
echo $Source
$Username = "\ptcoeadmin"
$Password = "Pa55w0rd!"

$JavaSetupPath=getProperty("JavaSetupPath")
$JavaSetupFile=getProperty("JavaSetupFile")
$SourceFile = "\\"+"$Source"+"\c$\Users"+"$JavaSetupPath$JavaSetupFile"
$SourceFile = $SourceFile.Replace('"','')
$DestinationFile   = "c:\Users\ptadmin\Downloads\"+"$JavaSetupFile"
$DestinationFile=$DestinationFile.Replace('"','')



downloadFile("")
unzip("")
setFireWallRule("")
copySetupFiles("")
installJava("")
setEnvironmentalVariable("")
disableFireWall("")
