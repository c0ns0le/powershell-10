# powershell profile

# setup profile
# Test-path $profile
# New-item –type file –force $profile
# ise $profile
# reload profile . $profile

# Set-ExecutionPolicy RemoteSigned

# DarkMagenta powershell default
$host.UI.RawUI.BackgroundColor="white"
$host.UI.RawUI.ForegroundColor="black"

$host.PrivateData.ErrorBackgroundColor = "white"

# output pane 
$psISE.Options.OutputPaneBackgroundColor = 'white' 
$psISE.Options.OutputPaneTextBackgroundColor = 'white' 
$psISE.Options.OutputPaneForegroundColor = 'black' 

# command pane 
$psISE.Options.CommandPaneBackgroundColor = 'white' 
$psise.Options.CommandPaneForegroundColor = 'black'

# copy script panel token colors to console panel token colors (only in ISE)
if ($host.name -ne 'ConsoleHost')
{
    foreach ($pair in $psISE.Options.TokenColors)
    {
       $psISE.Options.ConsoleTokenColors.Item($pair.Key) = `
           $psISE.Options.TokenColors.Item($pair.Key) 
    }
}

# remove path from prompt
function Prompt
{
    Write-Host "PS>" -NoNewline
    return " "
}

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
$env:Path = $env:Path + ";C:\Program Files\Git\cmd"
$env:Path = $env:Path + ";C:\Program Files\MongoDB 2.6 Standard\bin"
# $env:Path = $env:Path + ";C:\Program Files\nodejs"
$env:Path = $env:Path + ";C:\Users\Eric\AppData\Roaming\npm"
# $env:Path = $env:Path + ";C:\Program Files\Sublime Text 2"
$env:Path = $env:Path + ";C:\sysinternals"
$env:Path = $env:Path + ";C:\Program Files\Sublime Text 3"
$env:Path = $env:Path + ";" + $env:NODE_PATH

#Set environment variables for Visual Studio Command Prompt (VS2013) 
#Need to update the version (12.0) when new versions of VS arrive
pushd 'c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC'
cmd /c "vcvarsall.bat&set" |
foreach {
  if ($_ -match "=") {
    $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
  }
}
popd

Set-Alias path Get-PathPerLine
#Set-Alias sublime sublime_text.exe
#Set-Alias npp notepad++.exe

#Set-Alias ss select-string
#Set-Alias gh set-help
#Set-Alias no New-Object

clear
