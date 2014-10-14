# powershell profile

Set-ExecutionPolicy RemoteSigned

# node and git use black
(Get-Host).UI.RawUI.BackgroundColor=Black

# set the error background to decency
$pd = (Get-Host).PrivateData
$pd.ErrorBackgroundColor = "DarkMagenta" #"darkblue"

# display path environment variable per line
function Get-PathPerLine()
{
    $env:Path.Split(";")
}

# add path to environment variable
$env:Path = $env:Path + ";C:\Program Files (x86)\Notepad++"
$env:Path = $env:Path + ";C:\Program Files\Sublime Text 2"
$env:Path = $env:Path + ";C:\Program Files (x86)\WinMerge"
$env:Path = $env:Path + ";C:\Program Files (x86)\Git\bin"

# colored prompt
function Prompt
{
    $promptString = "PS " + $(Get-Location) + ">"
    Write-Host $promptString -NoNewline -ForegroundColor Yellow
    return " "
}

Set-Alias path Get-PathPerLine
Set-Alias sublime sublime_text.exe
Set-Alias npp notepad++.exe
