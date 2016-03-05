# Events

Register-ObjectEvent 
Get-Event 
Set-Event 
Wait-Event 
Remove-Event 
Get-EventSubscriber

# System commands

# system processes 
get-process # ps alias 
get-process chrome # get by name 
ps | sort cpu -desc | select -first 10 # top 10 cpu processes 
stop-process # kill alias kill a process 
(ps|where name -eq chrome).kill() # kill a set of processes 
get-process chrome | stop-process # much better way to kill set of processes

# get all powershell processes on the system 
get-process | Where-Object {$_.ProcessName -eq "powershell"} ps | where name -eq powershell

# WMI

# Call wmi objects for system information. Get the 3 disks with most freespace: 
get-wmiobject win32_logicaldisk | sort -desc freespace | select -first 3 | format-table -autosize deviceid, freespace

Get-WmiObject win32_bios -computername (get-content c:\mylistofcomputernames.txt)

# transform text output from a program into first-class objects basic idea is to turn the text into a csv file 
# and then convert the csv into objects 
myprogramwithtextoutput | foreach {$_ -replace "\s+",','} | ConvertFrom-Csv -Header Col1,Col2

invoke command on remote machine invoke-command -cn computername icm -cn computername





