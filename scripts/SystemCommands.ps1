# To run a command

program.exe   # run normal if program is in your path
"c:\program files\program.exe"  # paths with spaces require quotes, but this just prints a string
& "c:\program files\program.exe" arguments # use ampersand invoke operator to execute it
.\program.exe arguments  # if program in current directory

# Events

Register-ObjectEvent 
Get-Event 
Set-Event 
Wait-Event 
Remove-Event 
Get-EventSubscriber

# Processes 

get-process # ps alias 
get-process chrome # get by name 
ps | sort cpu -desc | select -first 10 # top 10 cpu processes 
stop-process # kill alias kill a process 
(ps|where name -eq chrome).kill() # kill a set of processes 
get-process chrome | stop-process # much better way to kill set of processes

# get all powershell processes on the system 
get-process | where {$_.ProcessName -eq "powershell"} 
ps powershell

# get a process and kill it
$p = get-process notepad
$p.kill()

# Services
get-service



# WMI

# call wmi for system information

# wmi class documentation
start "https://msdn.microsoft.com/en-us/library/aa394084(VS.85).aspx"

# get top 3 disks with most freespace
Get-WmiObject win32_logicaldisk | sort -desc freespace | select -first 3 | format-table -autosize deviceid, freespace

# call wmi on a list of computers
Get-WmiObject win32_bios -computername (get-content c:\mylistofcomputernames.txt)

# invoke command on remote machine 
invoke-command -cn computername icm -cn computername

# get class members (properties and methods) of a wmi object
Get-WmiObject win32_bios | Get-Member

Get-WmiObject win32_logicaldisk | % { $_ }

# get full list of wmi objects (super long)
Get-WmiObject -List
Get-WMIObject -List| Where {$_.name -match "^Win32_"} | Sort Name | Format-Table Name


Get-WmiObject win32_keyboard
Get-WmiObject win32_networkadapter
Get-WmiObject win32_battery | select -ExpandProperty EstimatedChargeRemaining

Get-WmiObject win32_desktop
Get-WmiObject win32_diskpartition
Get-WmiObject win32_logicaldisk
Get-WmiObject win32_networkprotocol
Get-WmiObject win32_operatingsystem
Get-WmiObject win32_process   # list of processes
Get-WmiObject win32_service   # list of services
Get-WmiObject win32_useraccount
Get-WmiObject win32_processor

Get-CimInstance win32_processor


Get-History


















