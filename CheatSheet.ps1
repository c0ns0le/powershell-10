#---------------------------------------------------------------------------------
# powershell

<#
powershell.exe
window key > “power” 
from any explorer window:   alt D > “powershell” 
F7 displays a window with command history
copy to clipboard:   highlight text and hit enter or right click 
copy from clipboard:  right mouse button
use backtick on command line to span multiple lines, enter on empty line executes command

to run powershell in administrator mode:
powershell   ctrl+shft+enter

to pass command to cmd.exe
cmd /c dir

powershell_ise.exe - integrated scripting environment for development
F5 - run entire script
F8 - run highlighted snippet of code 
CTRL D - go to console pane
CTRL I - go to script pane

#>
#---------------------------------------------------------------------------------
<#
Four categories of commands: 

cmdlets - 
    A cmdlet is implemented by a .NET class that derives from the Cmdlet base class in the PowerShell SDK.
    This category of command is compiled into a DLL and loaded into the PowerShell process.
    Always have names of the form Verb-Noun,

shell function commands
    function Do-Something { }

script commands 
    code in a file with ps1 extension

native win32 Windows commands.
    group sha -ashashtable -asstring
#>
#---------------------------------------------------------------------------------

# aliases
# unix commands ls, cat, mv, cp, man, pwd, ps, grep

#---------------------------------------------------------------------------------
# powershell environment

# To run scripts, need to set execution policy
get-executionpolicy
set-executionpolicy remotesigned  # run all local scripts and only remote scripts signed by a trusted source

# path to user-specific profile
# you need to create the file yourself
# C:\Users\Eric\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# Powershell ISE uses a different profile filename
# C:\Users\Eric\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1

$profile
ise $profile  # edit profile
. $profile  # reload profile in current session

# list all 4 profile scripts
$profile | select * 

# powershell version 
$PSVersionTable # display powershell version

# be sure to use powershell 4
Get-Service | Where { $_.Status -eq "Running" } | ForEach { $_.DisplayName }  # powershell 2
(Get-Service | Where Status -eq "Running").DisplayName # powershell 4

# display colors
[enum]::GetValues([System.ConsoleColor]) | Foreach-Object {Write-Host $_ -ForegroundColor $_}

# set the error background color
$host.privatedata.ErrorBackgroundColor = "black"

# list environment vars:   
ls env:
cd env:
ls

# show contents of path variable
ls env: | where Name -eq "path" | select -expand Value

# Modify path variable
$env:Path += ";C:\users\enelson\bin"

# list paths on separate lines
($env:Path).Replace(';',"`n")

# invoke-item is the same thing as clicking on an object.  alias ii
ii myfile.txt  # same thing as clicking on myfile.txt
ii .  # opens the current directory in windows explorer
# scott hanselman has "powershell prompt here" to get from explorer back to powershell

# expand a cutoff string in ui
select -expand xyz  

# to output results to the clipboard, pipe results to clip 
ps | clip

# output grid view  out-gridview ogv
ls | ogv  # pops up a grid view dialog box

#---------------------------------------------------------------------------------
# Help

get-command # gcm
gcm -verb "get"
gcm -noun "service"

get-help  # alias gh
gh get-command
get-command -?   # gets help
gh get-command -online # help in browser

get-help (help, man alias)  # gets help page for get-content
gh get-content -examples  # examples parameter shows examples of a command

# get-member shows what properties and methods are on an object
Get-Process | Get-Member  # shows what props and methods are on the object returned by get-process
ps|gm

# To see the signature(s) of a method, omit the parenthesis:
[math]::abs

# help topics documented
About_Execution_Policies
About_Operators
About_Common_Parameters
About_Pipelines
About_Scripts
About_*
Get-Help About* # lists help topics
get-help services # seach help system for articles on services

#---------------------------------------------------------------------------------
# variables 

$x.gettype()  # shows type information about a variable

[int]$i = 7  # static type a variable
$i = "hello"  # produces an error

get-variable i  
get-variable  # gv - gets list of all variables
remove-variable i  # rv - deletes the variable

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

$multilinetext = @"
this is some multi line
text across multiple lines
and more here 
"@  # this must be on a line by itself

# expressions inside strings
"there are $((Get-ChildItem).Count) items in folder $(get-location)"
"here is a calculation $(15*17)"

$x = 7
$y = 8
[string]::Format("There are {0}, {1} items", $x, $y);

# regular expressions
"888-8764" -match "[0-9]{3}-[0-9]{4}"   # returns true

# store variables in files
${D:\Temp\CoolVariable.txt} = "very blue"
$Full = "The sky is " + ${D:\Temp\CoolVariable.txt} + " today."

#---------------------------------------------------------------------------------
# built-in variables

get-variable # gv returns all variables
$true
$false
$null
$home
$host   # version of powershell currently running
$pid
$PSVersionTable # version of powershell currently running

$_  # used to iterate through collection
$_  # the current value of a variable in a pipeline
1..4 | foreach{$_ * $_ }

#---------------------------------------------------------------------------------
# arrays

$array = "bill", "george"
$array[0] = "jill"
$array  # display array

$array = @()  # empty array
$array.Count

$array = 1..10
$array = 10..1  # backwards
$array = 1..($count)  # use variable 
$array -contains 42  # false
$array = 1,2,3,4

#---------------------------------------------------------------------------------
# hash (associative array)

$hash = @{"key" = "value"; "anotherkey" = "anothervalue"}
$hash["key"]
$mykey = "anotherkey"
$hash.$mykey
$hash.Remove("key")
$hash.Contains("something")
$hash.ContainsValue("else")
$hash = @{}  # empty hash
$hash = @{a=1; b=2}
$hash   # display
$hash.a  # value of a
$hash["a"]  # value of a

#---------------------------------------------------------------------------------
# flow control (if, switch, loops)

$var = 32
switch ($var)
{
  12 {"no"}   
  32 {"yes" : break}  # powershell will continue evaluating subsequent conditions unless you specify :break 
  "32" {"without break above this would match too"}
  default {"default"}
}

switch -Wildcard ("hello") { }

$i=0
while ($i++ -lt 10) { if ($i % 2) {"$i is odd"}}

# do {} while ()
# do {} until ()
# for ($i=0;$i -lt 10; $i++) {}  # use foreach($i in 0..9) instead

$array = 11,12,13
foreach ($item in $array) { $item }

# Foreach-Object (foreach alias)
foreach ($file in get-childitem) { $file.Name }

# percent % is short for foreach
1..5|%{$_*$_}

# great way to do something 10 times
foreach ($i in 1..10) { }
foreach ($i in 10..1) { }
foreach ($i in 0..($Files.Count-1)) { }

# foreach can run parallel tasks (creates separate threads) and you can throttle threadcount if necessary
foreach -parallel -ThrottleLimit 50 ($Report in $Reports) { Process-Report $Report }

#---------------------------------------------------------------------------------
# error handling and debugging

# trap statement
function myfunc
{
    # func code here
    
    trap { 
        # catch statement catches .net error types
        write-host "oh no an error!"
        continue # continue to the next line of code after the error
        break # stops function and returns to caller instead
    }
}

write-debug # writes debug info 

# whatif parameter can be used to find out what a command will do before actually running it

#---------------------------------------------------------------------------------
# filesystem and file io

get-content  # alias gc or cat
cat c:/file.txt  # gets the contents of a file

# use set-content (alias sc) to write to file on disk
# use add-content (alias ac) to append to file on disk

get-location  # alias gl or pwd
set-location  # alias cd
cd ~  # go home

Push-Location # temporarily change directories and back.  alias pushd and popd
Pop-Location

get-childitem # alias ls
ls | where length -gt 100kb | sort length | ft name, length -AutoSize
ls | select name, length

# force delete a subtree
remove-item  # alias rm
rm -Recurse -Force some_dir

# ls -al equivalent - show all files plus hidden files
ls -Force

# To strip out all blank lines, including those with spaces and tabs, from a text file, we can use:
(cat $FilePath) | where { $_.Trim(" `t" } | Set-Content $FilePath 
# The initial cmd needs parenthesis because we need to finish reading from the file before writing back to it.

# cat contents of a file into a variable
$a = cat "a.txt"
# note $a is actually an array
# if you want one entire string, use join to combine
$separator = [System.Environment]::NewLine
$all = [string]::Join($seperator, $a)

# output data to file by redirect or out-file
ps > ps.txt
ps | out-file ps2.txt

# store a variable in a file:
${C:\Temp\CoolVariable.txt} = "very blue"
# read it out of a file:
$full = "The sky is " + ${C:\Temp\CoolVariable.txt} + " today."
# you can store arrays and hashes, etc

# Save functions in a file.  Then add to current context by:
. .\MyFunctions.ps1
# The first dot means "run this in the current context instead of a child context."

# Create fully qualified path from filename only
$path = $file | Resolve-Path

#---------------------------------------------------------------------------------
# working with excel csv

# convert to/from csv
convertfrom-csv
converto-csv

# output data to excel csv file
ps | export-csv services.csv

# import data from excel csv file
$header = "ColumnOne", "ColumnTwo"
$mycsv = import-csv "my.csv" -header $header
$mycsv.Count

#---------------------------------------------------------------------------------
# working with html and xml

# output data to html file
# ps = get-process
ps | convertto-html > ps.html    
ii ps.html

convertto-xml

# load xml from file 
$xml = new-object xml
$xml.Load("myfile.xml")

# write xml to file
$xml | out-file "myfile.xml"

#---------------------------------------------------------------------------------
# Providers - things we can navigate and get data from

get-psprovider  # shows list of providers available 
                # filesystem drives, registry, certificates, environment vars, sql server object tree

get-psdrive  # lists drives available on system

cd env:  # changes the provider to environment variables
ls  # list the environment variables

cd alias:  # changes the provider to aliases
ls  # list the available aliases

# Add new providers via snap-ins
Get-PSSnapin
Get-PSSnapin -Registered

#---------------------------------------------------------------------------------
# .NET framework access (perl module syntax)

<#  type accelerators are short names for .net class names
    http://www.powershellmagazine.com/2012/04/27/a-day-in-the-life-of-a-poshoholic-creating-and-using-type-accelerators-and-namespaces-the-easy-way/

    [math] refers to System.Math class
    [xml] System.Xml.XmlDocument
    [string] System.String
    [datetime] System.DateTime
    [wmi] System.Management.ManagementObject
    [regex] System.Text.RegularExpressions.Regex
#>

[Math]::pow(2,3)  # access Math.Pow()  the :: signifies a static method on the class
[math].getmethods() | select name -Unique  # get list of methods on math class
[math]::e
[math]::pi

[guid]::newguid()

[xml]  # take an xml file and create a System.Xml.XmlDocument
([xml](get-content my.xml))

# create and use .net objects
$t = New-Object -typename System.Timers.Timer `
    -ArgumentList 500  # pass arguments

$t = New-Object -typename System.Timers.Timer `
    -Property @{   # property argument accepts a hash table of property values
        Interval=900;
        AutoReset=$false
    }

$t = null  # destroys object (set for garbage collection)

# reference .net types and access static members
[System.Environment]::MachineName          #static member
[System.Environment]::GetLogicalDrives()   # call static function
[System.Environment] | gm                  # get-member

# reference instance members (dot)
[AppDomain]::CurrentDomain.GetAssemblies() # instance method

# you can assign a type reference to a variable and use it to reference later
$s = [System.Security.Cryptography.SHA1]

# load an assembly into powershell session
Add-Type -AssemblyName System.Drawing       # need to load the system.drawing assembly before using it
Add-Type -Path ./CustomTypes.dll            # load your own custom assemblies before using user-defined types

# use import-module for assemblies that contain powershell cmdlets or providers
Import-Module ./MyCustomtTypes.dll

#---------------------------------------------------------------------------------
# web access and networking

# invoke-webrequest (alias curl or iwr)
$r = Invoke-WebRequest http://www.google.com
$r.Content

# invoke a rest method (alias irm)
Invoke-RestMethod http://website.com/service.aspx

# restart iis
get-service
start-service w3svc # name of the iis service
stop-service w3svc 
restart-service w3svc

new-webserviceproxy  # use to talk to web services

[net.dns]::GetHostByName('www.google.com') # get ip address, but just use ping

#---------------------------------------------------------------------------------
# sql server

# To use Invoke-SqlCmd do this first:
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100

# Red Gate sqlcompare has command line utility


#---------------------------------------------------------------------------------
# script blocks

# assign script blocks to variables
$myscriptblock = { ls; "hello"; } # doesnt run yet
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

param ([int]$i) # explicit typing will throw error if wrong type is passed

# access command line switches
param([switch]$verbose, [switch]$debug, [switch]$mycustom) 
# verbose and debug are built-in, you can create your own custom

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

# variables defined external to script block are copied (by value) inside script block
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

function get-fullname([ref]$hi)  # ref turns into object and refers to original
{
    write-host ($hi.Value)
}
get-fullname("hey")

# filters - similar to a function
filter Show-PS1Files
{
   
}

# This default array is available in the variable $args
function hello { "Hello there $args, how are you?" }

function square($x) {$x*$x}
square(5)  or square 5   # can invoke with or without parens

# create a help page for functions
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
# system commands

# control panel
control

# system processes
get-process # ps alias
ps | sort cpu -desc | select -first 10   # top 10 cpu processes
stop-process # kill alias  kill a process
(ps|where name -eq chrome).kill()  # kill a set of processes

# get all powershell processes on the system
get-process | Where-Object {$_.ProcessName -eq "powershell"}
ps | where name -eq powershell

#---------------------------------------------------------------------------------
# working with sets - select, where, group by, sort, etc

select-object  # select alias
# select some of the objects piped into it or select some properties of each object piped into it.

ls | sort -property length -descending | select -first 1 -property directory   # this is basically a select top 1 directory from ls order by length desc
ls | sort -property length -descending | select -first 1 | foreach { $_.DirectoryName }
ls | sort -descending   # sorts directory by filename by default
ls | sort -property length  # sort by any property you want

group-object  # group alias (group by statement)
get-command | group verb | select -expandproperty group  # expands the group column
group verb -noelement  # suppress the group in the output

set-alias myalias get-childitems
export / import aliases from/to a csv file

$total = 0
ls | foreach {$total += $_.length }   # sums up the lengths of the files in the directory

get-process | sort -desc cpu | select -first 3  # get top 3 cpu processes

ps | where name -match svc  # match all process names with *svc*

#---------------------------------------------------------------------------------
Call wmi objects for system information.  Get the 3 disks with most freespace:
get-wmiobject win32_logicaldisk | sort -desc freespace | select -first 3 | format-table -autosize deviceid, freespace


# transform text output from a program into first-class objects
# basic idea is to turn the text into a csv file and then convert the csv into objects
myprogramwithtextoutput | foreach {$_ -replace "\s+",','} | ConvertFrom-Csv -Header Col1,Col2

# invoke command on remote machine
invoke-command -cn computername
icm -cn computername

#---------------------------------------------------------------------------------
# modules - the CPAN for powershell

<#
module repositories:
microsoft technet script repository, poshcode, codeplex, github, nuget, psget

pscx - most popular 3rd party module -  grab bag of useful functions
show-ui - creat wpf user interfaces
sql psx - sql server and powershell  
reflection 
pester - BDD testing
PSake - build scripting
studioshell - visual studio automation
#>

get-module   # alias gmo - see what modules are loaded
get-module -listavailable   # show what modules are available
import-module pscx
remove-module

<#
to install a module (important to use exact modulename)
create a directory under documents/windowspowershell/modules/<modulename>
create a file in the folder named <modulename>.psm1
paste module code into the file
verify it is installed using get-module -listavailable

builds:
psake  - SAH-kee
can wrap msbuild with psake (similar to makefiles)
#>

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
task -name default -depends Build

#---------------------------------------------------------------------------------
# visual studio and studioshell

<#
studioshell - powershell inside visual studio window
you can traverse visual studio ide object tree like a drive in powershell
myproject.psm1 project solution module file.  lives next to myproject.sln file
when visual studio opens a solution file, it automatically runs the psm1 file.
add entries to visual studio menus
#>

#---------------------------------------------------------------------------------
# background jobs and scheduled tasks

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

new-pssession

#---------------------------------------------------------------------------------
# console input/output 

# to prompt user, read from console
read-host -prompt "Enter something"

# out-host - same as redirecting output with >   ?
out-host 

# formatting output
format-wide -column 4  # 4 columns.  alias fw
format-table -autosize -wrap
format-list # alias fl

# output grid view  out-gridview ogv
ls | ogv  # pops up a grid view dialog box

#---------------------------------------------------------------------------------
# shortcuts

? is short for where
% is short for foreach

#---------------------------------------------------------------------------------
# certificates

# To programmatically load a certificate from a file and install it in a specific location inside the certificate store
$pfxpath = 'C:\temp\test.pfx'
$password = 'test'
[System.Security.Cryptography.X509Certificates.StoreLocation]$Store = 'CurrentUser'
$StoreName = 'root'

Add-Type -AssemblyName System.Security
$certificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$certificate.Import($pfxpath, $password, 'Exportable')

$Store = New-Object system.security.cryptography.X509Certificates.x509Store($StoreName, $StoreLocation)
$Store.Open('ReadWrite')
$Store.Add($certificate)
$Store.Close()

# When you use Get-PfxCertificate, you can read in PFX certificate files and use the certificate to sign scripts. 
# However, the cmdlet will always interactively ask for the certificate password.
# Here is some logic that enables you to submit the password by script:

$PathToPfxFile = 'C:\temp\test.pfx'
$PFXPassword = 'test'

Add-Type -AssemblyName System.Security
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import($PathToPfxFile, $PFXPassword, 'Exportable')

$cert  
