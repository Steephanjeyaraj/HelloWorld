Param(
[string]$User,
[string]$Password,
[string]$To,
[string]$Subject,
[string]$Body,
[string]$Dir,
[string]$File
)



$smtpServer = "smtp.office365.com"
$source=$Dir+"\"+$File+".zip"
echo $source
$source=$source.Replace('"','')
$att = new-object Net.Mail.Attachment($source)
$msg = new-object Net.Mail.MailMessage
$smtp = new-object Net.Mail.SmtpClient($smtpServer, 587)
$smtp.EnableSsl = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($User,$Password);
$msg.From = $User
$msg.To.Add($To)
$msg.Subject = $Subject
$msg.Body = $Body
$msg.Attachments.Add($att)
$smtp.Send($msg)
$att.Dispose()
