$output="Password="+$args[1]
$output.Replace('"','') | Out-File c:\creds.txt
$SourceJava = "C:\Setup\Java\Java_V8u161\jdk-8u161-windows-x64.exe"
$DestJava   = "\\"+$args[0]+"\c$\jdk-8u161-windows-x64.exe"
$DestJava=$DestJava.Replace('"','')
$SourceJMeter = "C:\Setup\JMeter\apache-jmeter-4.0.zip"
$DestJMeter   = "\\"+$args[0]+"\c$\apache-jmeter-4.0.zip"
$DestJMeter=$DestJMeter.Replace('"','')
$Username = "\ptcoeadmin"
$Password = $args[1]
$SourceFile ="C:\creds.txt"
$DestFile="\\"+$args[0]+"\c$\creds.txt"
$DestFile=$DestFile.Replace('"','')

$WebClient = New-Object System.Net.WebClient
$WebClient.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
$WebClient.UploadFile($DestJava,$SourceJava)
$WebClient.UploadFile($DestJMeter,$SourceJMeter)
$WebClient.UploadFile($DestFile,$SourceFile)

Remove-Item -Path C:\creds.txt
