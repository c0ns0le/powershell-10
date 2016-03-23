# how to create and use .net objects

# pass arguments

$t = New-Object System.Timers.Timer -ArgumentList 500

# property argument accepts a hash table of property values

$t = New-Object System.Timers.Timer `
        -Property @{Interval=900; AutoReset=$false}

$t = null           # destroys object (set for garbage collection)

# access members using perl module syntax

$t.Interval         # use . to access an instance method or property

[System.Math]::PI   # use :: to access static methods or properties

# show static methods on a type

[math] | Get-Member -Static

# show overloads of a method, leave off ()

"hello".ToString

# Assign a type reference to a variable and use it to reference later

$s = [System.Security.Cryptography.SHA1]

# Load an assembly into powershell session:

Add-Type -AssemblyName System.Drawing # need to load the system.drawing assembly before using it
Add-Type -Path ./CustomTypes.dll # load your own custom assemblies before using user-defined types

# Use import-module for assemblies that contain powershell cmdlets or providers:

Import-Module ./MyCustomtTypes.dll

# type accelerators are short names for .net class names

[System.Type]$typeAcceleratorsType =
    [System.Management.Automation.PSObject].Assembly.GetType(
    'System.Management.Automation.TypeAccelerators', $true, $true)

function Get-TypeAccelerators()
{
    $typeAcceleratorsType::get
}

######################################################################

# System.Math class

[math] | Get-Member -Static
[math]::pow(2,3) # access Math.Pow() the :: signifies a static method on the class
[math].getmethods() | select name -Unique # get list of methods on math class
[math]::e
[math]::pi

Get-Random -Minimum 100 -Maximum 200

# System.Guid

[guid]::newguid()

[xml]       # System.Xml.XmlDocument
[string]    # System.String
[datetime]  # System.DateTime
[wmi]       # System.Management.ManagementObject
[regex]     # System.Text.RegularExpressions.Regex

# System.String

[string] | Get-Member -Static
[string]::Join(",",@("one","two","three"))
[string]::Concat("one","two")

# System.Convert

[convert] | Get-Member -Static

# System.Text.Encoding

[text.encoding]::Unicode | Get-Member

# base 64 encoding decoding

$a = [text.encoding]::Unicode.GetBytes("hello")
$x = [convert]::ToBase64String($a)
$a = [convert]::FromBase64String($x)
[text.encoding]::Unicode.GetString($a)


# System.Text.RegularExpressions.Regex

[regex] | Get-Member -Static
[regex]::Match



# System.Environment

[environment] | Get-Member -Static
[environment]::MachineName         # static property
[environment]::GetLogicalDrives()  # call static method








