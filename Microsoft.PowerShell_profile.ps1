# powershell profile
# location $profile
# ii $profile
# ise $profile
# to reload profile . $profile

# Set-ExecutionPolicy RemoteSigned

# node and git use black background
# $host.UI.RawUI.BackgroundColor="Black"

# DarkMagenta is the powershell default
$host.UI.RawUI.BackgroundColor="DarkMagenta"

# change error background from black to default ps
$host.PrivateData.ErrorBackgroundColor = "DarkMagenta"

# remove path from prompt
function Prompt
{
    Write-Host "PS>" -NoNewline
    return " "
}

# preserve colors
$OrigBgColor = $host.ui.rawui.BackgroundColor
$OrigFgColor = $host.ui.rawui.ForegroundColor

function Reset-Colors {
    $host.ui.rawui.BackgroundColor = $OrigBgColor
    $host.ui.rawui.ForegroundColor = $OrigFgColor
}

# display path environment variable per line
function Get-PathPerLine()
{
    $env:Path.Split(";")
}

# alias reverse lookup
function Lookup-Alias($cmd)
{
    gcm $cmd | % {gal -Definition $_.name -ea 0}
}

function show-colors()
{
    [enum]::GetValues([System.ConsoleColor]) | Foreach-Object {Write-Host $_ -ForegroundColor $_} 
}

function kill-all($name)
{
    ps|where{$_.name -like "*$name*"}|foreach{$_.kill()}
}

# replace with type accelerator module
[System.Type]$typeAcceleratorsType =
[System.Management.Automation.PSObject].Assembly.GetType(
'System.Management.Automation.TypeAccelerators',
$true,
$true
)

# replace with type accelerator module
function get-typeaccelerators()
{
    $typeAcceleratorsType::get
}

function load-assembly($namespace)
{
    [Reflection.Assembly]::LoadWithPartialName($namespace)
}

$env:NODE_PATH = "C:\Users\Eric\AppData\Roaming\npm\node_modules"

# add path to environment variable
$env:Path = $env:Path + ";C:\Program Files (x86)\Notepad++"
$env:Path = $env:Path + ";C:\Program Files (x86)\WinMerge"
$env:Path = $env:Path + ";C:\Program Files (x86)\Git\bin"
$env:Path = $env:Path + ";C:\Program Files\MongoDB 2.6 Standard\bin"
$env:Path = $env:Path + ";C:\Program Files\nodejs"
$env:Path = $env:Path + ";C:\Users\Eric\AppData\Roaming\npm"
# $env:Path = $env:Path + ";C:\Program Files\Sublime Text 2"
$env:Path = $env:Path + ";C:\Program Files\Sublime Text 3"
$env:Path = $env:Path + ";" + $env:NODE_PATH

Set-Alias path Get-PathPerLine
Set-Alias sublime sublime_text.exe
Set-Alias npp notepad++.exe

Set-Alias ss select-string
Set-Alias gh set-help
Set-Alias no New-Object

clear
