get-content # (gc,cat) to read file from disk
set-content # (sc) to write to file on disk
add-content # (ac) to append to file on disk

set-content hello.txt -value "this is a test"
get-content hello.txt

get-location # gl,pwd
set-location # cd
cd ~ # go home

# Temporarily change directories and back. pushd and popd
Push-Location
Pop-Location

get-childitem # (ls)
ls | where length -gt 100kb | sort length | ft name, length -AutoSize
ls | select name, length
ls -Force # ls -al equivalent, show all files plus hidden files

new-item myfile.txt # same as touch command

remove-item (rm)
rm -Recurse -Force some_dir # delete subtree

# To strip out all blank lines, including those with spaces and tabs, from a text file:
(cat $FilePath) | where { $_.Trim(" `t" } | Set-Content $FilePath
# The initial cmd needs parenthesis because we need to finish reading from the file before writing back to it.

$a = cat "a.txt" # cat contents of a file into a variable
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

# Save functions in a file. Then add to current context by:
. .\MyFunctions.ps1
# The first dot means run this in the current context instead of a child context.

# Create fully qualified path from filename only
$path = $file | Resolve-Path
(get-item 'myfile.txt').FullName

# Display file in hex get-content myfile.txt | fhex

# Read a textfile line by line 
try { 
    $inputFile = New-Object IO.StreamReader((Get-Item $InputPath).FullName, [text.encoding]::GetEncoding(1252)) 
    $outputFile = New-Object IO.StreamWriter([io.path]::Combine($pwd.Path, $CsvPath), $false, [text.encoding]::GetEncoding(1252)) 
    $line = $inputFile.ReadLine() 
    while($line -ne $null) { 
        $outputFile.WriteLine($line) 
        $line = $inputFile.ReadLine() 
    } 
} 
finally { 
    if($inputFile.BaseStream.CanRead){
        $inputFile.Close()
    } 
    if($outputFile.BaseStream.CanWrite){
        $outputFile.Close()
    } 
}