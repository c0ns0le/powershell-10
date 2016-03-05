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
.SYNOPSIS
.DESCRIPTION
.PARAMETER ... etc

# Then you can type: help My-Function and it will display this information

