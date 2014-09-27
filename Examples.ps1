get-command
get-command -verb "get"
get-command -noun "service"

get-help
get-help get-command
get-command -?   # gets help

set-location c:\windows  # aka  cd c:\windows
Get-ChildItem # aka   ls

get-childitem | 
    where-object {$_.Length -gt 100kb} | 
    Sort-Object Length |
    Format-Table -Property Name, Length -AutoSize

Get-ChildItem | Select-Object Name, Length


# -----------------------------------------
# Providers - things we can navigate and get data from
Get-PSProvider  # shows list of providers available 
                # filesystem drives, registry, certificates, environment vars, sql server object tree)
Get-PSDrive

Set-Location env:  # changes the provider to environment variables
Get-ChildItem  # list the environment variables

Set-Location alias:  # changes the provider to aliases
Get-ChildItem  # list the available aliases

# Add new providers via snap-ins
Get-PSSnapin
Get-PSSnapin -Registered


# -----------------------------------------
# variables 

[int]$i = 7  # static type a variable
$i = "hello"  # produces an error

get-variable i  
get-variable  # gets list of all variables
remove-variable i  # deletes the variable

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

# arrays
$array = "bill", "george"
$array[0] = "jill"
$array

$array = @()  # empty array
$array.Count

$array = 1..9
$array -contains 42  # false

# hash
$hash = @{"key" = "value"; "anotherkey" = "anothervalue"}
$hash["key"]
$mykey = "anotherkey"
$hash.$mykey
$hash.Remove("key")
$hash.Contains("something")
$hash.ContainsValue("else")

# special built-in variables
$true
$false
$null
$HOME
$Host   # version of powershell currently running
$pid
$PSVersionTable # version of powershell currently running
$_  # used to iterate through collection


# set the error background to decency
$pd = (Get-Host).PrivateData
$pd.ErrorBackgroundColor = "darkblue"

# display the path to the user-specific profile that powershell ATTEMPTS to load
# you need to create the file yourself
$profile
# C:\Users\Eric\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
$user
$home 


# force delete a subtree
Remove-Item -Recurse -Force some_dir

# ls -al    show all files plus hidden files
Get-ChildItem -Force

# curl alias  make web request
$r = Invoke-WebRequest http://www.google.com
$r.Content
Invoke-RestMethod http://website.com/service.aspx


system commands
control    // control panel
get-process (ps alias)
get-process | sort cpu -desc | select -first 10   // top 10 cpu processes
stop-process (kill alias) 1234   // kill a process

output data to html or excel
get-process | convertto-html -property processname, cpu, id > c:\users\eric\proc.html    
get-process | export-csv c:\service.csv


To strip out all blank lines, including those with spaces and tabs, from a text file, we can use:
( Get-Content $FilePath ) | Where { $_.Trim(" `t" } | Set-Content $FilePath 
Or
(GC $FP)|?{$_.Trim(" `t")}|SC $FP 
The initial cmd needs parenthesis because we need to finish reading from the file before writing back to it.

output data table:
get-command | group verb | out-gridview  // pops up a grid view dialog box

store a variable in a file:
${D:\Temp\CoolVariable.txt} = "very blue"
and read it out of a file:
$Full = "The sky is " + ${D:\Temp\CoolVariable.txt} + " today."
you can store arrays and hashes, etc


# Save functions in a file.  Then add to current context by:
. .\MyFunctions.ps1
The first dot means "run this in the current context instead of a child context."

To use Invoke-SqlCmd do this first:
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100

set-alias myalias get-childitems
export / import aliases from/to a csv file

$var = 32
switch ($var)
{
  12 {"no"}   
  32 {"yes" : break}  # powershell will continue evaluating subsequent conditions unless you specify :break 
  "32" {"without break above this would match too"}
  default {"def"}
}

switch -Wildcard ("hello") { }
while() {}
do {} while ()
do {} until ()
for () {}

$array = 11,12,13
foreach ($item in $array)
{
    $item
}

foreach ($file in get-childitem)
{
    $file.Name
}

# script blocks

#you can assign script blocks to variables
$myscriptblock = { get-childitem; "hello" } # doesnt run yet
& $myscriptblock  # execute the script block

$value = {12+23}
1 + (&$value)  # must wrap in parenthesis to use value

# you can pass arguments into script blocks
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

param ([int] $i) # can use explicit typing.  will throw error if wrong type is passed

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

7 | &$myblock  # returns yes

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

# functions - basically script blocks with a name
function get-fullname([ref] $hi)  # ref turns into object and refers to original
{
    write-host ($hi.Value)
}
get-fullname("hey")

# filters - kind of like a function
filter Show-PS1Files
{
    
}


# help
<#
 .SYNOPSIS
 .DESCRIPTION
 .PARAMETER ... etc
#>


# error handling via trap statement
function myfunc
{
    # func code here
    
    trap { # like a catch statement. catches .net error types
        write-host "oh no an error!"
        continue # continue to the next line of code after the error if you want
        break # stops function from running and return to caller instead
    }
}

write-debug # writes debug info 
read-host -prompt

# use get-content to assign contents of a file to a variable
$a = get-content "a.txt"
# note $a is actually an array
# if you want one entire string, use join to combine
$separator = [System.Environment]::NewLine
$all = [string]::Join($seperator, $a)

# use set-content to write to file on disk
# use add-content to append to file on disk


# useful csv functions
get-process | export-csv "myfile.csv"

$header = "ColumnOne", "ColumnTwo"
$mycsv = import-csv "my.csv" -header $header
$mycsv.Count

# xml functions

$myxml | out-file "c:\myfile.xml"

$xml = new-object xml
$xml.Load("c:\myfile.xml")


# import-module

# powershell with sql server


# powershell with iis
get-service
start-service w3svc (the name of the iis service)
stop-service wmi 
restart-service w3svc

# powershell building code better than msbuild

# whatif parameter can be used to find out what a command will do before actually running it




$x.gettype()  // shows type information about a variable

Arrays
$a = @()  // empty array
$a = 1,2,3,4
$a = 1..10  // creates an array of 1 to 10
$a   // prints out the array nicely

Hashes (associative array)
$h = @{}  // empty hash
$h = @{a=1; b=2}
$h   // prints table
$h.a  or $h[a]  // access value of a

Powershell accelerators
[xml] - takes an xml file and creates an XmlDocument().   must be well formed
([xml](get-content c:/my.xml))

Functions
function square($x) {$x*$x}
square(5)  or square 5   // can invoke with or without parens

$_ variable is the current value of a variable in a pipeline
$list = 1..4
$list | foreach{square $_ }

.NET Framework access (aka perl module syntax)
[Math]::pow(2,3)  // access Math.Pow()    the :: signifies a static method on the object

new-webserviceproxy  - use to talk to web services

use backquote ` to quote a single character
cd “c:\program files”
cd c:\program` files

In double quotes, variables are expanded. 
$v = "files"
cd "c:\program $v"

Single quotes can be used for strings, but variables are NOT expanded.

Backquotes are used for escape sequences.  Backslash will NOT work.
`n   // newline
`t    // tab

Scripts
get-executionpolicy
set-executionpolicy remotesigned  // run all local scripts and only remote scripts signed by a trusted source


Functions

This default array is available in the variable $args.
function hello { "Hello there $args, how are you?" }

 the $OFS variable stores default separator  

Group-Object  (group by statement)
get-command | group verb | select -expandproperty group  // expands the group column
group verb -noelement  // suppress the group in the output







powershell exe

powershell ISE - integrated scripting environment for development
F5 - run entire script
F8 - run highlighted snippet of code 
CTRL D - go to console pane
CTRL I - go to script pane

Modify path variable
$env:Path += ";C:\users\enelson\bin"

list environment vars:   ls env:
($env:Path).Replace(';',"`n")

window key > “power” 
from any explorer window:   alt D > “powershell” 
F7 displays a window with command history
copy to clipboard:   highlight text and hit enter.  
copy from clipboard:  right mouse button

do math directly:
PS > (2+2)*6/2

Save in variables:
PS > $n = (2+2)*3
PS > $n / 7

cmdlets -  Use Verb-Noun form.
unix commands ls, cat, mv, cp, man, pwd, ps, grep

get-command invoke* // lists all commands (cmdlets, aliases, functions) starting with “invoke”
get-content (cat alias) c:/file.txt  // gets the contents of a file

get-help (help, man alias)  // gets help page for get-content
get-help get-content -examples  // examples parameter shows examples of a command

get-childItem (ls, dir alias)

PS > $files = dir
PS > $files[1]   // prints second entry in the directory, 0 relative

PS > dir | sort -descending   // sorts directory by filename by default
PS > dir | sort -property length  // sort by any property you want

select-object  (select alias)
This cmdlet allows you to select some of the objects piped into it or select some properties of each object piped into it.
PS > $a = dir | sort -property length -descending | select-object -first 1 -property directory   // this is basically a select top 1 directory from dir order by length desc

Foreach-Object (foreach , % alias)

PS > $a = dir | sort -property length -descending | select-object -first 1 | foreach-object { $_.DirectoryName }

PS > $total = 0
PS > dir | foreach-object {$total += $_.length }   // sums up the lengths of the files in the directory
PS > $total
308

PS > get-process | sort -desc cpu | select -first 3  // get top 3 cpu processes

Can call WMI objects for system information.  Get the 3 disks with most freespace:
PS > get-wmiobject win32_logicaldisk | sort -desc freespace | select -first 3 | format-table -autosize deviceid, freespace

Flow control statement:
PS > $i=0
PS > while ($i++ -lt 10) { if ($i % 2) {"$i is odd"}}

In PowerShell, there are currently four different categories of commands: 
cmdlets - 
A cmdlet is implemented by a .NET class that derives from the Cmdlet base class in the PowerShell Software Developers Kit (SDK).
This category of command is compiled into a DLL and loaded into the PowerShell process
always have names of the form Verb-Noun,
shell function commands
function Do-Something { }
script commands 
code in a file with ps1 extension
native win32 Windows commands.

group sha -ashashtable -asstring

Red Gate sqlcompare. command line utility




