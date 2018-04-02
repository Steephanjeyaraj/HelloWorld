
powershell.exe -ExecutionPolicy Unrestricted -File InstallDependencies.ps1
cd C:\apache-jmeter-4.0\
jmeter-server -Jserver_port=1099 -Jserver.rmi.ssl.diable=true
