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
 [System.IO.Compression.ZipFile]::ExtractToDirectory($JMeterZipFile, '.')
}

function setEnvironmentalVariable(){
[Environment]::SetEnvironmentVariable("PATH", $env:Path + ";$JMeterPath", 'Machine')
}
}


$JMeterSourceUrl=getProperty("JMeterSourceURL").Replace('"','')
$JMeterVersion=getProperty("JMeterVersion")
$destinationPath=getProperty("DestinationPath")
$JMeterZipFile="$destinationPath$JMeterVersion"+".zip"
$JMeterZipFile=$JMeterZipFile.Replace('"','')
$JMeterPath=""


downloadFile("")
unzip("")
setEnvironmentalVariable("")



