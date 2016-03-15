# To prompt user, read from console:
read-host -prompt "Enter something"
out-host
write-host

# more command
out-more

# Formatting should only be used at the end of a pipeline
# Formatting output: format-wide -column 4 # 4 columns. fw
Format-Table -autosize -wrap
Format-List # property:value format (shows only default properties)
Format-List *  # shows all properties

ls | Out-GridView # ogv. pops up a grid view dialog box

# select items on the output grid view and save them in a variable
$selectedProcesses = Get-Process | Out-GridView -PassThru 
$selectedProcesses


# select single item on output grid view
$selectedProcesses = Get-Process | Out-GridView -OutputMode Single
$selectedProcesses

# Powershell equivalent to String.Format
"{0}, your balance is {1}. (Status {2})" -f $name, $balance, $status





