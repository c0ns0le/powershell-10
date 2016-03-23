# Basic commands:

get-module   # alias gmo - see what modules are loaded  
get-module -listavailable   # show what modules are available  
import-module pscx  
remove-module  
Get-Command -module name

# List the commands exported by a given module

get-module psget | select -expandproperty exportedcommands   

# With PsGet you can:

Get-PsGetModuleInfo Posh*   # browse the available modules  
Install-Module PsUrl        # install them  

# Beginning in Windows PowerShell 3.0, 
# modules are imported automatically when any cmdlet or function in the module is used in a command. 
# In Powershell 3.0 all available modules are activated automatically in the session 
# and you don’t have to load them with the Import-Module.

# To install a module manually create a directory under documents/windowspowershell/modules/
# create a file in the folder named .psm1
# paste module code into the file
# verify it is installed using get-module -listavailable

psreadline - command-line syntax highlighting,etc. import-module psreadline
posh-npm # dont bother using these
posh-git # dont bother using these

# builds:
psake - SAH-kee

# can wrap msbuild with psake (similar to makefiles)

properties { $config = 'debug' # debug or release }

task -name Build -description "builds outdated artifacts" -action { exec { msbuild ./myproject/myproject.sln /t:Build } }

task -name Clean -description "cleans" -action { exec { msbuild ./myproject/myproject.sln /t:Clean } }

task -name Rebuild -depends Clean,Build -description "rebuild"
task -name default -depends Build

# Snapins - Obsolete powershell 1.0 method. Use modules now.

# script modules (.psm1 files)
# binary modules (.dlls commandlets)
# manifest modules (.psd1 files describe content of module)

export-modulemember -function Show-Calendar

$env:PSModulePath

posh-npm tab expansion


