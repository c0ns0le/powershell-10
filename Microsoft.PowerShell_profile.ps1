# powershell profile

# setup profile
# Test-path $profile
# New-item –type file –force $profile
# ise $profile
# reload profile . $profile

# Set-ExecutionPolicy RemoteSigned

# DarkMagenta powershell default
# $host.UI.RawUI.BackgroundColor="white"
# $host.UI.RawUI.ForegroundColor="black"

# $host.PrivateData.ErrorBackgroundColor = ""

# output pane 
# $psISE.Options.OutputPaneBackgroundColor = 'white' 
# $psISE.Options.OutputPaneTextBackgroundColor = 'white' 
# $psISE.Options.OutputPaneForegroundColor = 'black' 

# command pane 
# $psISE.Options.CommandPaneBackgroundColor = 'white' 
# $psise.Options.CommandPaneForegroundColor = 'black'

# copy script panel token colors to console panel token colors (only in ISE)
<# 
if ($host.name -ne 'ConsoleHost')
{
    foreach ($pair in $psISE.Options.TokenColors)
    {
       $psISE.Options.ConsoleTokenColors.Item($pair.Key) = `
           $psISE.Options.TokenColors.Item($pair.Key) 
    }
}
#>

# Reset colors if they get messed up
$OrigBgColor = $host.ui.rawui.BackgroundColor
$OrigFgColor = $host.ui.rawui.ForegroundColor 

function Reset-Colors {
    $host.ui.rawui.BackgroundColor = $OrigBgColor
    $host.ui.rawui.ForegroundColor = $OrigFgColor
}

function Set-BlackWhiteColors {
    $host.ui.rawui.BackgroundColor = "Black"
    $host.ui.rawui.ForegroundColor = "White"
}

# Print out colors
function Show-Colors()
{
    [enum]::GetValues([System.ConsoleColor]) | Foreach-Object {Write-Host $_ -ForegroundColor $_} 
}

# remove path from prompt
function Prompt
{
    Write-Host "PS>" -NoNewline
    return " "
}

# display path environment variable per line
function Get-PathPerLine()
{
    $env:Path.Split(";")
}
Set-Alias path Get-PathPerLine

# alias reverse lookup
function Lookup-Alias($cmd)
{
    Get-Command $cmd | % {Get-Alias -Definition $_.name -ea 0}
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

function Load-Assembly($namespace)
{
    [Reflection.Assembly]::LoadWithPartialName($namespace)
}

# add paths to environment variable
# $env:NODE_PATH = "C:\Users\Eric\AppData\Roaming\npm\node_modules"
$env:NODE_PATH = $env:APPDATA + "\npm\node_modules"
# $env:Path = $env:Path + ";C:\Program Files\nodejs"
$env:Path = $env:Path + ";" + $env:NODE_PATH
# $env:Path = $env:Path + ";C:\Program Files (x86)\Notepad++"
# $env:Path = $env:Path + ";C:\Program Files (x86)\WinMerge"
$env:Path = $env:Path + ";C:\Program Files (x86)\Git\bin"
$env:Path = $env:Path + ";C:\Program Files\Git\cmd"
# $env:Path = $env:Path + ";C:\Program Files\MongoDB 2.6 Standard\bin"
$env:Path = $env:Path + ";C:\Users\Eric\AppData\Roaming\npm"
$env:Path = $env:Path + ";C:\sysinternals"
$env:Path = $env:Path + ";C:\Program Files\Sublime Text 2"
$env:Path = $env:Path + ";C:\Program Files\Sublime Text 3"

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

#Set-Alias sublime sublime_text.exe
#Set-Alias npp notepad++.exe
#Set-Alias vi sublime_text.exe

clear
