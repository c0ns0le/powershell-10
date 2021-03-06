# script blocks

# assign script blocks to variables

$myscriptblock = { ls; "hello"; } # doesnt run yet  
& $myscriptblock  # execute the script block

& myscriptfile.ps1
# & tells powershell to run in isolation mode
# the script runs in its own scope and all variables and functions defined in the script will be discarded when the script is done
# use this to run a script to perform some task and not pollute the environment

. myscriptfile.ps1 
# dot-sourcing runs in global scope
# functions and variables remain in global scope after script is done
# use this to import a function library into your global scope

$value = {12+23}
1 + (&$value)  # must wrap in parenthesis to use value

# pass arguments into script blocks

$qa = {
    $arg[0]
    $arg[1]
    $arg.Count # returns number of arguments
}
& $qa "one" "two"

# For fixed number of parameters, use param to explicitly name parameters

$qa = {
    # assigns first param to $one, second to $two, $three specifies default value
    param($one, $two, $three="default") 
    $one # use the variable for whatever
    if (!$two) { $two = "default" } # check if empty value, assign a default 
}

param ([int]$i) # explicit typing will throw error if wrong type is passed

# access command line switches

param([switch]$verbose, [switch]$debug, [switch]$mycustom) 

# you can add param() to pass variables to scripts

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

# To make variable global

$global:var = 7
{$global = 8} 
$global # now 8

# To make private variable

$private:unmentionables = 7
{$private} # cant see it. its null

# Functions

# powershell has predefined functions. to list them:
ls function:
# prompt is a function that prints out your command prompt

# Functions are script blocks with a name

function get-fullname([ref]$hi)  # ref turns into object and refers to original
{
    write-host ($hi.Value)
}

get-fullname("hey")

# Filters - similar to a function

filter Show-PS1Files
{
}

# This default array is available in the variable $args

function hello { "Hello there $args, how are you?" }

function square($x) {$x*$x}

square(5)  or square 5   # can invoke with or without parens

# Create a help page for functions
# Get-Help My-Function  basic help information
# Get-Help My-Function -Examples
# Get-Help My-Function -Parameter *

<#
.SYNOPSIS
.DESCRIPTION
.PARAMETER
.EXAMPLE
#>

# enable the command to accept input values from pipeline
function My-Function 
{
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [int]
        $myint
    )
    $myint * 2
}
1..10 | My-Function  
# this will only process the last element.  you need to use process {} block in your function see below

function MyFunction 
{

## PowerShell runs your "begin" script block before it passes you any of the items in the pipeline.
begin
{
}
## PowerShell runs your "process" script block for each item it passes down
## the pipeline. In this block, the "$_" variable represents the current pipeline object
process
{
}
## PowerShell runs your "end" script block once it completes passing all objects down the pipeline.
end
{
}

}


















