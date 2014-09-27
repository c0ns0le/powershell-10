get-command
get-command -verb "get"
get-command -noun "service"

get-help
get-help get-command
get-command -?   # gets help

set-location c:\windows  # aka  cd c:\windows
Get-ChildItem # aka   ls

get-childitem | 
    where-object {$_.Length -gt 100kb} | 
    Sort-Object Length |
    Format-Table -Property Name, Length -AutoSize

Get-ChildItem | Select-Object Name, Length


# -----------------------------------------
# Providers - things we can navigate and get data from
Get-PSProvider  # shows list of providers available 
                # filesystem drives, registry, certificates, environment vars, sql server object tree)
Get-PSDrive

Set-Location env:  # changes the provider to environment variables
Get-ChildItem  # list the environment variables

Set-Location alias:  # changes the provider to aliases
Get-ChildItem  # list the available aliases

# Add new providers via snap-ins
Get-PSSnapin
Get-PSSnapin -Registered


# -----------------------------------------
# variables 

[int]$i = 7  # static type a variable
$i = "hello"  # produces an error

get-variable i  
get-variable  # gets list of all variables
remove-variable i  # deletes the variable

"double quotes works"
'single quotes work'
"o'malley works"
'this "works"'

# escape sequences start with back tick
" one line`n anotherline"

$heretext = @"
this is some multi line
text across multiple lines
and more here 
"@  # this must be on a line by itself

$heretext

# expressions inside strings
"there are $((Get-ChildItem).Count) items in folder $(get-location)"

"here is a calculation $(15*17)"

$x = 7
$y = 8
[string]::Format("There are {0}, {1} items", $x, $y);

# regular expressions
"888-8764" -match "[0-9]{3}-[0-9]{4}"   # returns true

# arrays
$array = "bill", "george"
$array[0] = "jill"
$array

$array = @()  # empty array
$array.Count

$array = 1..9
$array -contains 42  # false

# hash
$hash = @{"key" = "value"; "anotherkey" = "anothervalue"}
$hash["key"]
$mykey = "anotherkey"
$hash.$mykey
$hash.Remove("key")
$hash.Contains("something")
$hash.ContainsValue("else")

# special built-in variables
$true
$false
$null
$HOME
$Host   # version of powershell currently running
$pid
$PSVersionTable # version of powershell currently running
$_  # used to iterate through collection


# set the error background to decency
$pd = (Get-Host).PrivateData
$pd.ErrorBackgroundColor = "darkblue"

# display the path to the user-specific profile that powershell ATTEMPTS to load
# you need to create the file yourself
$profile
# C:\Users\Eric\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
$user
$home 


# force delete a subtree
Remove-Item -Recurse -Force some_dir

# ls -al    show all files plus hidden files
Get-ChildItem -Force

# curl alias  make web request
$r = Invoke-WebRequest http://www.google.com
$r.Content
Invoke-RestMethod http://website.com/service.aspx













