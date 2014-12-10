# powershell profile
# ii $profile
# ise $profile

# Set-ExecutionPolicy RemoteSigned

# node and git use black
$host.UI.RawUI.BackgroundColor="Black"

# set the error background to decency
# $host.PrivateData.ErrorBackgroundColor = "Black"

# colored prompt
function Prompt
{
    $promptString =  "$pwd`nPS >"
    Write-Host $promptString -nonewline -ForegroundColor DarkCyan
    return " "
}

# display path environment variable per line
function Get-PathPerLine()
{
    $env:Path.Split(";")
}

$env:NODE_PATH = "C:\Users\Eric\AppData\Roaming\npm\node_modules"

# add path to environment variable
$env:Path = $env:Path + ";C:\Program Files (x86)\Notepad++"
$env:Path = $env:Path + ";C:\Program Files\Sublime Text 2"
$env:Path = $env:Path + ";C:\Program Files (x86)\WinMerge"
$env:Path = $env:Path + ";C:\Program Files (x86)\Git\bin"
$env:Path = $env:Path + ";C:\Program Files\MongoDB 2.6 Standard\bin"
$env:Path = $env:Path + ";C:\Program Files\nodejs"
$env:Path = $env:Path + ";C:\Users\Eric\AppData\Roaming\npm"
$env:Path = $env:Path + ";" + $env:NODE_PATH

Set-Alias path Get-PathPerLine
Set-Alias sub sublime_text.exe
Set-Alias npp notepad++.exe
