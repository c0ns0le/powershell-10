# to prompt user, read from console:

Read-Host -prompt "Enter something"
Out-Host
Write-Host

# more command

Get-Process | Out-More 

# formatting should only be used at the end of a pipeline

Get-Process | Format-Table -autosize -wrap 
Get-Process | Format-Table ProcessName, Handles

# print output in list format  property:value 

Get-Process | Format-List     # show only default properties
Get-Process | Format-List *   # show all properties

# format into separate columns

Get-Process | Format-Wide -column 4 

# expand long strings

ls env:Path | select -expand value

# pops up a grid view dialog box

ls | Out-GridView 

# select items on the output grid view and save them in a variable

$selectedProcesses = Get-Process | Out-GridView -PassThru 
$selectedProcesses

# select single item on output grid view

$selectedProcesses = Get-Process | Out-GridView -OutputMode Single
$selectedProcesses

# powershell equivalent to String.Format

"{0}, your balance is {1}. (Status {2})" -f $name, $balance, $status

# grep 

ipconfig | Select-String "Default Gateway" | Select -First 1

# get and select columns/properties

Get-Process | Get-Member -MemberType Properties
Get-Process | select -First 1
Get-Process | % ProcessName  # select only particular column
Get-Process | % ProcessName | % ToUpper

Get-Process -Name chrome
Get-Process chrome

$processes = Get-Process chrome
$processes[0].Id
$processes.Id


