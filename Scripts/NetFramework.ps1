# Create and use .net objects

# Pass arguments:
$t = New-Object -typename System.Timers.Timer -ArgumentList 500

# Property argument accepts a hash table of property values:
$t = New-Object -typename System.Timers.Timer `
-Property @{Interval=900, AutoReset=$false}

$t = null # destroys object (set for garbage collection)

# Type accelerators

# Type accelerators are short names for .net class names.

[math] refers to System.Math class
[math]::pow(2,3) # access Math.Pow() the :: signifies a static method on the class
[math].getmethods() | select name -Unique # get list of methods on math class
[math]::e
[math]::pi
[guid]::newguid()

[xml] System.Xml.XmlDocument
[string] System.String
[datetime] System.DateTime
[wmi] System.Management.ManagementObject
[regex] System.Text.RegularExpressions.Regex

# Reference .net types and access static members. Uses perl module syntax.

[System.Environment]::MachineName # static property
[System.Environment]::GetLogicalDrives() # call static method
[System.Environment] | Get-Member

# Reference instance members (dot):
[AppDomain]::CurrentDomain.GetAssemblies() # instance method

# Assign a type reference to a variable and use it to reference later:
$s = [System.Security.Cryptography.SHA1]

# Load an assembly into powershell session:
Add-Type -AssemblyName System.Drawing # need to load the system.drawing assembly before using it
Add-Type -Path ./CustomTypes.dll # load your own custom assemblies before using user-defined types

# Use import-module for assemblies that contain powershell cmdlets or providers:
Import-Module ./MyCustomtTypes.dll