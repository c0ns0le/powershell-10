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

function Add-EnvironmentPath($path)
{
    if (Test-Path $path) 
    {
        $env:Path = $env:Path + ";" + $path
    }
}

# more doesnt work in ise
function Out-More
{
    param
    (
        $Lines = 50,
        
        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )
    
    begin
    {
        $counter = 0
    }
    
    process
    {
        $counter++
        if ($counter -ge $Lines)
        {
            $counter = 0
            Write-Host 'Press ENTER to continue' -ForegroundColor Yellow
            Read-Host  
        }
        $InputObject
    }
} 

#####################################################################################
# add paths to environment variable

Add-EnvironmentPath("C:\Program Files (x86)\Vim\vim74")
Add-EnvironmentPath("C:\Program Files (x86)\Notepad++")
Add-EnvironmentPath("C:\Program Files (x86)\WinMerge")
Add-EnvironmentPath("C:\Program Files\MongoDB 2.6 Standard\bin")
Add-EnvironmentPath("C:\sysinternals")
Add-EnvironmentPath("C:\Program Files\Sublime Text 3")

$sublimeInstallPath = "C:\Program Files\Sublime Text 3"
if (Test-Path $sublimeInstallPath) 
{
    $env:SUBLIME = $sublimeInstallPath
}
Remove-Variable sublimeInstallPath

#####################################################################################
# Node

$nodeInstallPath = Join-Path $HOME "\AppData\Roaming\npm"
if (Test-Path $nodeInstallPath) 
{
    # $env:NODE_PATH = join-path $env:HOME "\AppData\Roaming\npm\node_modules"
    $env:NODE_PATH = $env:APPDATA + "\npm\node_modules"
    # $env:Path = $env:Path + ";C:\Program Files\nodejs"
    $env:Path = $env:Path + ";" + $env:NODE_PATH
    $env:Path = $env:Path + ";" + $nodeInstallPath
}
Remove-Variable nodeInstallPath

#####################################################################################
# Github for windows shell environment

$gitInstallPath = "$env:LOCALAPPDATA\GitHub\shell.ps1"
if (Test-Path $gitInstallPath) 
{
    . (Resolve-Path $gitInstallPath)
    #$env:Path = $env:Path + ";C:\Program Files (x86)\Git\bin"
    #$env:Path = $env:Path + ";C:\Program Files\Git\cmd"
}
Remove-Variable gitInstallPath

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
Remove-Variable vsInstallPath

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
Remove-Variable azureInstallPath

#####################################################################################
if ($host.name -eq 'ConsoleHost')
{
    [console]::WindowWidth=224
    [console]::WindowHeight=68
}
