$x.gettype() # shows type information about a variable

[int]$i = 7 # static type a variable
$i = "hello" # produces an error

get-variable i
get-variable # gv - gets list of all variables
remove-variable i # rv - deletes the variable

# use backquote to quote a single character 
cd “c:\program files” 
cd c:\program files

# In double quotes, variables are expanded
$v = "files"
cd "c:\program $v"

# Single quotes can be used for strings, but variables are NOT expanded

# Backquotes are used for escape sequences. Backslash will NOT work.
`n # newline 
`t # tab

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
"@ # this must be on a line by itself

# expressions inside strings
"there are $((Get-ChildItem).Count) items in folder $(get-location)"
"here is a calculation $(15*17)"

$x = 7
$y = 8
[string]::Format("There are {0}, {1} items", $x, $y);

# store variables in files
${D:\Temp\CoolVariable.txt} = "very blue"
$Full = "The sky is " + ${D:\Temp\CoolVariable.txt} + " today."

# Built-in variables

get-variable # gv returns all variables
$true
$false
$null
$home
$host # version of powershell currently running
$pid
$PSVersionTable # version of powershell currently running

$_ # used to iterate through collection
$_ # the current value of a variable in a pipeline
1..4 | foreach{$_ * $_ }

