param(
[string]$subnetIP
)
(Get-Content .\test\taurus\configurations\SlaveTemplate.yml) | 
Foreach-Object {$_ -replace 'XX.XX.XX.XX',$subnetIP }  | Set-Content .\test\taurus\configurations\Slave.yml