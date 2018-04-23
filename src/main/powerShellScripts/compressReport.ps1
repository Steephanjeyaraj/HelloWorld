 Add-Type -Assembly 'System.IO.Compression.FileSystem'; 
 $source=$args[0]+"\\"+$args[1]
 $source=$source.Replace('"','')
 $destination=$args[0]+"\\"+$args[1]+".zip"
 $destination=$destination.Replace('"','')
 [System.IO.Compression.ZipFile]::CreateFromDirectory($source,$destination);