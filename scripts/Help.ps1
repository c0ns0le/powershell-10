Get-Command
Get-Command -verb "get"
Get-Command -noun "service"
get-command -noun csv # get all commands for csv files
Get-Command -ListImported
Get-Command -Module  # get all commands in a module



Get-Help
Get-Command -? # get help
Get-Help Get-Command -online # help in browser
Get-Help Get-Content -examples # examples of a command

Get-Member # shows what properties and methods are on an object
Get-Process | Get-Member # shows what props and methods are on the object returned by get-process
Get-Process | Get-Member -MemberType Property  # get only properties of object


# To see the signature(s) of a method, omit the parenthesis
[math]::abs
"hello".StartsWith

<#
help topics documented
About_Execution_Policies
About_Operators
About_Common_Parameters
About_Pipelines
About_Scripts
About_*
#>

Get-Help About* # lists help topics
Get-Help services # search help system for articles on services











