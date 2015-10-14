# powershell profile

# setup profile
# Test-path $profile
# New-item –type file –force $profile
# ise $profile
# . $profile

# Set-ExecutionPolicy RemoteSigned

#####################################################################################
# Functions

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

Set-ColorBlue

# some programs insist on black
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

# print out colors
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
'System.Management.Automation.TypeAccelerators', $true, $true)

function Get-TypeAccelerators()
{
    $typeAcceleratorsType::get
}

function Load-Assembly($namespace)
{
    [Reflection.Assembly]::LoadWithPartialName($namespace)
}

# send output to a browser
function Out-Browser
{
    $p = Join-Path -Path $env:TEMP -ChildPath (([guid]::NewGuid()).ToString() + ".html")
    $input|ConvertTo-Html|Out-File $p
    ii $p
}

#####################################################################################
# add paths to environment variable

$vimInstallPath = "C:\Program Files (x86)\Vim\vim74"
if (Test-Path $vimInstallPath) 
{
    $env:Path = $env:Path + ";" + $vimInstallPath
}

$notepadppInstallPath = "C:\Program Files (x86)\Notepad++"
if (Test-Path $notepadppInstallPath) 
{
    $env:Path = $env:Path + ";" + $notepadppInstallPath
}

$sublimeInstallPath = "C:\Program Files\Sublime Text 3"
if (Test-Path $sublimeInstallPath) 
{
    $env:SUBLIME = $sublimeInstallPath
    $env:Path = $env:Path + ";" + $env:SUBLIME
    #Set-Alias sublime sublime_text.exe
}

$winmergeInstallPath = "C:\Program Files (x86)\WinMerge"
if (Test-Path $winmergeInstallPath) 
{
    $env:Path = $env:Path + ";" + $winmergeInstallPath
}

$mongoInstallPath = "C:\Program Files\MongoDB 2.6 Standard\bin"
if (Test-Path $mongoInstallPath) 
{
    $env:Path = $env:Path + ";" + $mongoInstallPath
}

$sysinternalsInstallPath = "C:\sysinternals"
if (Test-Path $sysinternalsInstallPath) 
{
    $env:Path = $env:Path + ";" + $sysinternalsInstallPath
}

#####################################################################################
# Node

$nodeInstallPath = Join-Path $env:HOME "\AppData\Roaming\npm"
if (Test-Path $nodeInstallPath) 
{
    # $env:NODE_PATH = join-path $env:HOME "\AppData\Roaming\npm\node_modules"
    $env:NODE_PATH = $env:APPDATA + "\npm\node_modules"
    # $env:Path = $env:Path + ";C:\Program Files\nodejs"
    $env:Path = $env:Path + ";" + $env:NODE_PATH
    $env:Path = $env:Path + ";" + $nodeInstallPath
}

#####################################################################################
# Github for windows shell environment

$gitInstallPath = "$env:LOCALAPPDATA\GitHub\shell.ps1"
if (Test-Path $gitInstallPath) 
{
    . (Resolve-Path $gitInstallPath)
    #$env:Path = $env:Path + ";C:\Program Files (x86)\Git\bin"
    #$env:Path = $env:Path + ";C:\Program Files\Git\cmd"
}

#####################################################################################
# Set environment variables for Visual Studio Command Prompt (VS2013) 
# Need to update the version (12.0) when new versions of VS arrive
# pushd 'c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC'
# cmd /c "vcvarsall.bat&set" |

$vsInstallPath = 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools'
if (Test-Path (Join-Path $vsInstallPath "vsvars32.bat&set"))
{
    pushd $vsInstallPath
    cmd /c "vsvars32.bat&set" |
    foreach {
      if ($_ -match "=") {
        $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
      }
    }
    popd
}

#####################################################################################
# Azure SDK tools

$azureInstallPath = 'C:\Program Files\Microsoft SDKs\Azure\.NET SDK\v2.7\bin'
if (Test-Path $azureInstallPath) 
{
    pushd $azureInstallPath
    cmd /c "setenv.cmd&set" |
    foreach {
      if ($_ -match "=") {
        $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
      }
    }
    popd
}

#####################################################################################

