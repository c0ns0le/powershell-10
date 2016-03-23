# Programmatically load a certificate from a file and install it in a specific location inside the certificate store

$pfxpath = 'C:\temp\test.pfx'
$password = 'test'
[System.Security.Cryptography.X509Certificates.StoreLocation]$Store = 'CurrentUser'
$StoreName = 'root'

Add-Type -AssemblyName System.Security
$certificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$certificate.Import($pfxpath, $password, 'Exportable')
$Store = New-Object system.security.cryptography.X509Certificates.x509Store($StoreName, $StoreLocation)
$Store.Open('ReadWrite')
$Store.Add($certificate)
$Store.Close()

# When you use Get-PfxCertificate, you can read in PFX certificate files and use the certificate to sign scripts. 
# However, the cmdlet will always interactively ask for the certificate password. 
# Here is some logic that enables you to submit the password by script

$PathToPfxFile = 'C:\temp\test.pfx' 
$PFXPassword = 'test'

Add-Type -AssemblyName System.Security
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import($PathToPfxFile, $PFXPassword, 'Exportable')
$cert


# System.Security.SecureString
# Security.Cryptography.SHA1
# System.Security.Principal.WindowsPrincipal














