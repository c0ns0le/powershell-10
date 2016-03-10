# Profile

Test-path $profile
New-item –type file –force $profile
ise $profile

# path to user-specific profile
# you need to create the file yourself
C:\Users\Eric\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# Powershell ISE uses a different profile filename
C:\Users\Eric\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1

$profile 
ise $profile # edit profile 
. $profile # reload profile in current session

# list all 4 profile scripts 
$profile | select *

# Execution policy

Get-ExecutionPolicy
Set-ExecutionPolicy remotesigned # run all local scripts and only remote scripts signed by a trusted source

# Powershell version

$PSVersionTable # display powershell version

# Be sure to use powershell 4
Get-Service | Where { $.Status -eq "Running" } | ForEach { $.DisplayName } # powershell 2
(Get-Service | Where Status -eq "Running").DisplayName # powershell 4

# Colors

[enum]::GetValues([System.ConsoleColor]) | Foreach-Object {Write-Host $_ -ForegroundColor $_}

# Set the error background color
$host.privatedata.ErrorBackgroundColor = "black"

# Environment variables

ls env:

# show contents of path variable 
ls env: | where Name -eq "path" | select -expand Value

# Modify path variable 
$env:Path += ";C:\users\enelson\bin"

# list paths on separate lines 
($env:Path).Replace(';',"`n")

# invoke-item is the same thing as clicking on an object 
alias ii ii myfile.txt # same thing as clicking on myfile.txt 
ii . # opens the current directory in windows explorer 
# scott hanselman has "powershell prompt here" to get from explorer back to powershell

# expand a cutoff string in ui 
select -expand xyz

# to output results to the clipboard, pipe results to clip 
Get-Process | clip

# output grid view 
Get-Process | Out-GridView # pops up a grid view dialog box

Get-History # shows your history

# Providers

# Providers are things we can navigate and get data from

Get-PSProvider # shows list of providers available
# filesystem drives, registry, certificates, environment vars, sql server object tree

Get-PSDrive # lists drives available on system

cd env: # changes the provider to environment variables
ls # list the environment variables

cd alias: # changes the provider to aliases
ls # list the available aliases

# Add new providers via snap-ins
Get-PSSnapin
Get-PSSnapin -Registered


