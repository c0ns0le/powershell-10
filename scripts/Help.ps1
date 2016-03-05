get-command gcm
gcm -verb "get"
gcm -noun "service"
get-command -noun csv # get all commands for csv files

get-help gh
gh get-command
get-command -? # gets help
gh get-command -online # help in browser

get-help (help, man alias) # gets help page for get-content
gh get-content -examples # examples parameter shows examples of a command

get-member # shows what properties and methods are on an object
Get-Process | Get-Member # shows what props and methods are on the object returned by get-process
ps|gm

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
get-help services # search help system for articles on services





