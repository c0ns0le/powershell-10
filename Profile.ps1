# powershell profile

# setup profile
# Test-path $profile
# New-item –type file –force $profile
# ise $profile
# reload profile . $profile

# Set-ExecutionPolicy RemoteSigned

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

# DarkMagenta powershell default
function Set-ColorBlue 
{
    if ($host.name -eq 'ConsoleHost')
    {
        $host.UI.RawUI.BackgroundColor="DarkMagenta"
        $host.UI.RawUI.ForegroundColor="White"
        $host.PrivateData.ErrorBackgroundColor="DarkMagenta"
        $host.PrivateData.WarningBackgroundColor="DarkMagenta"
    }
}

# git and npm insist on black
function Set-ColorBlack 
{
    if ($host.name -eq 'ConsoleHost')
    {
        $host.UI.RawUI.BackgroundColor="Black"
        $host.UI.RawUI.ForegroundColor="White"
        $host.PrivateData.ErrorBackgroundColor="Black"
        $host.PrivateData.WarningBackgroundColor="Black"
    }
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

function Out-Browser
{
    $p = Join-Path -Path $env:TEMP -ChildPath (([guid]::NewGuid()).ToString()+ ".html")
    $input|ConvertTo-Html|Out-File $p
    ii $p
}

# add paths to environment variable
# $env:NODE_PATH = "C:\Users\Eric\AppData\Roaming\npm\node_modules"
$env:NODE_PATH = $env:APPDATA + "\npm\node_modules"
# $env:Path = $env:Path + ";C:\Program Files\nodejs"
$env:Path = $env:Path + ";" + $env:NODE_PATH
# $env:Path = $env:Path + ";C:\Program Files (x86)\Notepad++"
# $env:Path = $env:Path + ";C:\Program Files (x86)\WinMerge"
# $env:Path = $env:Path + ";C:\Program Files\MongoDB 2.6 Standard\bin"
$env:Path = $env:Path + ";C:\Users\Eric\AppData\Roaming\npm"
$env:Path = $env:Path + ";C:\sysinternals"
$env:Path = $env:Path + ";C:\Program Files\ConEmu"

#####################################################################################
# Github
. (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")
#$env:Path = $env:Path + ";C:\Program Files (x86)\Git\bin"
#$env:Path = $env:Path + ";C:\Program Files\Git\cmd"
#####################################################################################
# Vim
$env:Path = $env:Path + ";" + "C:\Program Files (x86)\Vim\vim74"
#####################################################################################
# Sublime settings
$env:SUBLIME = "C:\Program Files\Sublime Text 3"
$env:Path = $env:Path + ";" + $env:SUBLIME
#####################################################################################
# Set environment variables for Visual Studio Command Prompt (VS2013) 
# Need to update the version (12.0) when new versions of VS arrive
# pushd 'c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC'
# cmd /c "vcvarsall.bat&set" |
pushd 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools'
cmd /c "vsvars32.bat&set" |
foreach {
  if ($_ -match "=") {
    $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
  }
}
popd
#####################################################################################
# Azure SDK tools
pushd 'C:\Program Files\Microsoft SDKs\Azure\.NET SDK\v2.7\bin'
cmd /c "setenv.cmd&set" |
foreach {
  if ($_ -match "=") {
    $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
  }
}
popd
#####################################################################################

#Set-Alias sublime subl.exe
#Set-Alias npp notepad++.exe
#Set-Alias vi sublime_text.exe
New-Alias which get-command

Set-ColorBlue

clear
