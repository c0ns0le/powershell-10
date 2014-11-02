#---------------------------------------------------------------------------------
# powershell general info

<#

powershell.exe

powershell ISE - integrated scripting environment for development
F5 - run entire script
F8 - run highlighted snippet of code 
CTRL D - go to console pane
CTRL I - go to script pane

window key > “power” 
from any explorer window:   alt D > “powershell” 
F7 displays a window with command history
copy to clipboard:   highlight text and hit enter or right click 
copy from clipboard:  right mouse button

#>

<#
In PowerShell, there are four different categories of commands: 

cmdlets - 
    A cmdlet is implemented by a .NET class that derives from the Cmdlet base class in the PowerShell Software Developers Kit (SDK).
    This category of command is compiled into a DLL and loaded into the PowerShell process
    always have names of the form Verb-Noun,
    cmdlets -  Use Verb-Noun form.

shell function commands
    function Do-Something { }

script commands 
    code in a file with ps1 extension

native win32 Windows commands.
    group sha -ashashtable -asstring
#>

# aliases
# unix commands ls, cat, mv, cp, man, pwd, ps, grep

#---------------------------------------------------------------------------------
# environment

# set the error background to decency
$pd = (Get-Host).PrivateData
$pd.ErrorBackgroundColor = "darkblue"

# Modify path variable
$env:Path += ";C:\users\enelson\bin"

# list environment vars:   
ls env:
cd env:
ls

ls env: | where Name -eq "path" | select -expand Value

# list paths on separate lines
($env:Path).Replace(';',"`n")

# path to the user-specific profile that powershell ATTEMPTS to load
# you need to create the file yourself
$profile
# C:\Users\Eric\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# Powershell ISE uses a different profile filename
# C:\Users\Eric\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1

# list all 4 profile scripts
$profile | select * 

$user
$home

# To run scripts, need to set execution policy
get-executionpolicy
set-executionpolicy remotesigned  # run all local scripts and only remote scripts signed by a trusted source

Get-Location # pwd   current location
Push-Location # temporarily change directories and back.  alias pushd and popd
Pop-Location

$PSVersionTable # version of powershell currently running


#---------------------------------------------------------------------------------
# Help

get-command
get-command -verb "get"
get-command -noun "service"

get-help
get-help get-command
get-command -?   # gets help

get-help (help, man alias)  # gets help page for get-content
get-help get-content -examples  # examples parameter shows examples of a command

# get-member will tell you what properties and methods are on an object
Get-Process | Get-Member  # tells you what props and methods are on the object returned by get-process

# help topics documented
About_Execution_Policies
About_Operators
About_Common_Parameters
About_Pipelines
About_Scripts
About_*
Get-Help About* # lists help topics

#---------------------------------------------------------------------------------
# variables 

$x.gettype()  # shows type information about a variable

[int]$i = 7  # static type a variable
$i = "hello"  # produces an error

get-variable i  
get-variable  # gets list of all variables
remove-variable i  # deletes the variable

# use backquote ` to quote a single character
cd “c:\program files”
cd c:\program` files

# In double quotes, variables are expanded. 
$v = "files"
cd "c:\program $v"

# Single quotes can be used for strings, but variables are NOT expanded.

# Backquotes are used for escape sequences.  Backslash will NOT work.
`n   # newline
`t    # tab

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


#---------------------------------------------------------------------------------
# arrays

$array = "bill", "george"
$array[0] = "jill"
$array

$array = @()  # empty array
$array.Count

$array = 1..9
$array -contains 42  # false

$a = @()  # empty array
$a = 1,2,3,4
$a = 1..10  # creates an array of 1 to 10
$a   # prints out the array nicely

#---------------------------------------------------------------------------------
# hash (associative array)

$hash = @{"key" = "value"; "anotherkey" = "anothervalue"}
$hash["key"]
$mykey = "anotherkey"
$hash.$mykey
$hash.Remove("key")
$hash.Contains("something")
$hash.ContainsValue("else")

$h = @{}  # empty hash
$h = @{a=1; b=2}
$h   # prints table
$h.a  # or
$h["a"]  # access value of a

#---------------------------------------------------------------------------------
# built-in variables
$true
$false
$null
$HOME
$Host   # version of powershell currently running
$pid
$PSVersionTable # version of powershell currently running
$_  # used to iterate through collection

$_ # variable is the current value of a variable in a pipeline
$list = 1..4
$list | foreach{square $_ }

#---------------------------------------------------------------------------------
# flow control statements (if, switch, loops)

$var = 32
switch ($var)
{
  12 {"no"}   
  32 {"yes" : break}  # powershell will continue evaluating subsequent conditions unless you specify :break 
  "32" {"without break above this would match too"}
  default {"def"}
}

switch -Wildcard ("hello") { }

$i=0
while ($i++ -lt 10) { if ($i % 2) {"$i is odd"}}

# do {} while ()
# do {} until ()
# for () {}

$array = 11,12,13
foreach ($item in $array)
{
    $item
}

# Foreach-Object (foreach alias)
foreach ($file in get-childitem)
{
    $file.Name
}


#---------------------------------------------------------------------------------
# error handling and debugging

# trap statement
function myfunc
{
    # func code here
    
    trap { # a catch statement. catches .net error types
        write-host "oh no an error!"
        continue # continue to the next line of code after the error if you want
        break # stops function from running and return to caller instead
    }
}

write-debug # writes debug info 

# whatif parameter can be used to find out what a command will do before actually running it

#---------------------------------------------------------------------------------
# Working with filesystem / files

get-content (cat alias) c:/file.txt  # gets the contents of a file

Set-Location c:\windows  # cd c:\windows
Get-ChildItem # ls

get-childitem | 
    where-object {$_.Length -gt 100kb} | 
    Sort-Object Length |
    Format-Table -Property Name, Length -AutoSize

Get-ChildItem | Select-Object Name, Length

# force delete a subtree
Remove-Item -Recurse -Force some_dir

# ls -al    show all files plus hidden files
Get-ChildItem -Force

# output data to html or excel
get-process | convertto-html -property processname, cpu, id > c:\users\eric\proc.html    
get-process | export-csv c:\service.csv

# To strip out all blank lines, including those with spaces and tabs, from a text file, we can use:
( Get-Content $FilePath ) | Where { $_.Trim(" `t" } | Set-Content $FilePath 
# Or
(GC $FP)|?{$_.Trim(" `t")}|SC $FP 
# The initial cmd needs parenthesis because we need to finish reading from the file before writing back to it.

# use get-content to assign contents of a file to a variable
$a = get-content "a.txt"
# note $a is actually an array
# if you want one entire string, use join to combine
$separator = [System.Environment]::NewLine
$all = [string]::Join($seperator, $a)

# use set-content to write to file on disk
# use add-content to append to file on disk

# import/export csv files
get-process | export-csv "myfile.csv"

$header = "ColumnOne", "ColumnTwo"
$mycsv = import-csv "my.csv" -header $header
$mycsv.Count

# load xml from file   out-file command
$myxml | out-file "c:\myfile.xml"

$xml = new-object xml
$xml.Load("c:\myfile.xml")

# store a variable in a file:
${D:\Temp\CoolVariable.txt} = "very blue"
# read it out of a file:
$Full = "The sky is " + ${D:\Temp\CoolVariable.txt} + " today."
# you can store arrays and hashes, etc

# Save functions in a file.  Then add to current context by:
. .\MyFunctions.ps1
# The first dot means "run this in the current context instead of a child context."

# Create fully qualified path from filename only
$path = $file | Resolve-Path

#---------------------------------------------------------------------------------
# Providers - things we can navigate and get data from
Get-PSProvider  # shows list of providers available 
                # filesystem drives, registry, certificates, environment vars, sql server object tree)
Get-PSDrive  # lists drives available on system

Set-Location env:  # changes the provider to environment variables
Get-ChildItem  # list the environment variables

Set-Location alias:  # changes the provider to aliases
Get-ChildItem  # list the available aliases

# Add new providers via snap-ins
Get-PSSnapin
Get-PSSnapin -Registered

#---------------------------------------------------------------------------------
# .NET Framework access (aka perl module syntax)

[Math]::pow(2,3)  # access Math.Pow()    the :: signifies a static method on the object

# create and use .net objects
$t = New-Object -typename System.Timers.Timer `
    -ArgumentList 500  # pass arguments

$t = New-Object -typename System.Timers.Timer `
    -Property @{   # property argument accepts a hash table of property values
        Interval=900;
        AutoReset=$false
    }

$t = null # destroys object (set for garbage collection)

# reference .net types and access static members
[System.Environment]::MachineName #static member
[System.Environment]::GetLogicalDrives() # call static function
[System.Environment] | Get-Member


# reference instance members (dot)
[AppDomain]:: CurrentDomain.GetAssemblies() # instance method

# you can assign a type reference to a variable and use it to reference later
$s = [System.Security.Cryptography.SHA1]


# load an assembly into powershell session
Add-Type -AssemblyName System.Drawing # need to load the system.drawing assembly before using it
Add-Type -Path ./CustomTypes.dll # load your own custom assemblies before using user-defined types

# use import-module for assemblies that contain powershell cmdlets or providers
Import-Module ./MyCustomtTypes.dll


#---------------------------------------------------------------------------------
# Working with the web

# curl alias  make web request
$r = Invoke-WebRequest http://www.google.com
$r.Content
Invoke-RestMethod http://website.com/service.aspx

# restart iis
get-service
start-service w3svc # name of the iis service
stop-service w3svc 
restart-service w3svc

new-webserviceproxy  # use to talk to web services


#---------------------------------------------------------------------------------
# Working with sql server

# To use Invoke-SqlCmd do this first:
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100

# Red Gate sqlcompare has command line utility


#---------------------------------------------------------------------------------
# script blocks

# assign script blocks to variables
$myscriptblock = { get-childitem; "hello" } # doesnt run yet
& $myscriptblock  # execute the script block

$value = {12+23}
1 + (&$value)  # must wrap in parenthesis to use value

# pass arguments into script blocks
$qa = {
    $arg[0]
    $arg[1]
    $arg.Count # returns number of arguments
}
& $qa "one" "two"

# for fixed number of parameters, use param to explicitly name parameters
$qa = {
    # assigns first param to $one, second to $two, $three specifies default value
    param($one, $two, $three="default") 
    $one # use the variable for whatever
    if (!$two) { $two = "default" } # check if empty value, assign a default 
}

param ([int] $i) # can use explicit typing. will throw error if wrong type is passed

# access command line switches
param([switch]$verbose, [switch]$debug, [switch]$mycustom) # verbose and debug are built-in, you can create your own custom too

# use process command to pipeline enable a block
$myblock =
{ 
    begin {} # this code runs before the pipeline runs (optional)
    process {  # this is the pipeline code
        if ($_ -eq 7) { return "yes"}
    }
    end {} # this code runs after the pipeline runs (optional)
}
7 | &$myblock  # 7 is pipelined into script block, returns yes

# variables defined external to script block are copied inside script block
$x = 7
{$x = 8} 
$x # still 7

# to make variable global
$global:var = 7
{$global = 8} 
$global # now 8

# to make private variable
$private:unmentionables = 7
{$private} # cant see it. its null

#---------------------------------------------------------------------------------
# functions - script blocks with a name

function get-fullname([ref] $hi)  # ref turns into object and refers to original
{
    write-host ($hi.Value)
}
get-fullname("hey")

# filters - kind of like a function
filter Show-PS1Files
{
   
}

# This default array is available in the variable $args.
function hello { "Hello there $args, how are you?" }

function square($x) {$x*$x}
square(5)  or square 5   # can invoke with or without parens

#---------------------------------------------------------------------------------
# create help page for functions

<#
 .SYNOPSIS
 .DESCRIPTION
 .PARAMETER ... etc
#>


#---------------------------------------------------------------------------------
# Manage events inside powershell
Register-ObjectEvent 
Get-Event
Set-Event
Wait-Event
Remove-Event
Get-EventSubscriber

#---------------------------------------------------------------------------------
# modules - the CPAN for powershell

# microsoft technet script repository




#---------------------------------------------------------------------------------

read-host -prompt

# import-module

# powershell building code better than msbuild



# Powershell accelerators
[xml] # takes an xml file and creates an XmlDocument().   must be well formed
([xml](get-content c:/my.xml))



#---------------------------------------------------------------------------------
# system commands
control    # control panel

get-process # ps alias
get-process | sort cpu -desc | select -first 10   # top 10 cpu processes
stop-process # kill alias  kill a process

output data table:
get-command | group verb | out-gridview  # pops up a grid view dialog box

# get all powershell processes on the system
get-process | Where-Object {$_.ProcessName -eq "powershell"}


the $OFS variable stores default separator  



Group-Object  (group by statement)
get-command | group verb | select -expandproperty group  # expands the group column
group verb -noelement  # suppress the group in the output


set-alias myalias get-childitems
export / import aliases from/to a csv file



get-childItem # ls, dir alias

$files = dir
$files[1]   # prints second entry in the directory, 0 relative

dir | sort -descending   # sorts directory by filename by default
dir | sort -property length  # sort by any property you want

select-object  # select alias
This cmdlet allows you to select some of the objects piped into it or select some properties of each object piped into it.
$a = dir | sort -property length -descending | select-object -first 1 -property directory   # this is basically a select top 1 directory from dir order by length desc


$a = dir | sort -property length -descending | select-object -first 1 | foreach-object { $_.DirectoryName }

$total = 0
dir | foreach-object {$total += $_.length }   # sums up the lengths of the files in the directory
$total
308

get-process | sort -desc cpu | select -first 3  # get top 3 cpu processes

Can call WMI objects for system information.  Get the 3 disks with most freespace:
get-wmiobject win32_logicaldisk | sort -desc freespace | select -first 3 | format-table -autosize deviceid, freespace



# invoke item is the same thing as clicking on an object.   alias ii
invoke-item myfile.txt  # same thing as clicking on myfile.txt
Invoke-Item .  # this opens the current directory in windows explorer   ii .
# scott hanselman has "powershell prompt here" to get from explorer back to powershell


select -expand xyz  # expands a cutoff string in ui


# to output results to the clipboard, pipe results to clip 
ps | clip


# transform text output from a program into first-class objects
# basic idea is to turn the text into a csv file and then convert the csv into objects
myprogramwithtextoutput | foreach {$_ -replace "\s+",','} | ConvertFrom-Csv -Header Col1,Col2


#modules
module repositories:
ms technet scriptcenter
poshcode
codeplex
github
nuget
psget

pscx - most popular 3rd party module -  grab bag of useful functions
show-ui - creat wpf user interfaces
sql psx - sql server and powershell  
reflection 
pester - BDD testing
PSake - build scripting
studioshell - visual studio automation

get-module # see what modules are loaded
get-module -listavailable # show what modules are available
import-module pscx
remove-module

to install a module (important to use exact modulename)!
create a directory under documents/windowspowershell/modules/<modulename>
create a file in the folder named <modulename>.psm1
paste module code into the file
verify it is installed using get-module -listavailable

#builds
psake  - SAH-kee
can wrap msbuild with psake (similar to makefiles)

properties {
	$config = 'debug'  # debug or release
}

task -name Build -description "builds outdated artifacts" -action {
	exec {
		msbuild ./myproject/myproject.sln /t:Build
	}
}

task -name Clean -description "cleans" -action {
	exec {
		msbuild ./myproject/myproject.sln /t:Clean
	}
}

task -name Rebuild -depends Clean,Build -description "rebuild"

task -name default -depends Build;

studioshell - powershell inside visual studio window
you can traverse visual studio ide object tree like a drive in powershell
myproject.psm1 project solution module file.  lives next to myproject.sln file
when visual studio opens a solution file, it automatically runs the psm1 file.
add entries to visual studio menus



# powershell background jobs
# uses .net remoting.  parent/child relationship
# use start-job or use -AsJob parameter, supported by many commands
$procjob = start-job {get-process}
$procjob # displays state of job
get-job # lists all jobs, by id, name, state, time
wait-job
stop-job
remove-job
receive-job $myresults -Keep # get results back from job

# powershell scheduled tasks
PSScheduledJob module
#Scheduled job definition is stored to disk in:
C:\users\eric\appdata\local\microsoft\powershell\scheduledjobs\<jobname>
#Results are also written to disk in the same location
#Define job trigger - frequency and time
#Define job action - script block or file
#Register job
$trigger = new-jobtrigger -daily -at "6:00 am"
$action = {code here}
$option = new-scheduledjob 
	-name "event" 
	-scriptblock $action 
	-trigger $trigger
	-scheduledjoboption $option

disable-scheduledjob
enable-scheduledjob
unregister-scheduledjob myjob



#formatting output 
out-host 
format-wide -column 4  # 4 columns.  alias fw
format-table -autosize -wrap
format-list # alias fl


new-pssession

# display colors
[enum]::GetValues([System.ConsoleColor]) | Foreach-Object {Write-Host $_ -ForegroundColor $_}

