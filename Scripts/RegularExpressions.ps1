# regular expressions
"888-8764" -match "[0-9]{3}-[0-9]{4}" # returns true


# use powershell parser to tokenize a powershell command
$tokens = [System.Management.Automation.PsParser]::Tokenize("get-process | format-table", [ref] $null)




















