# powershell profile

# set the error background to decency
$pd = (Get-Host).PrivateData
$pd.ErrorBackgroundColor = "darkblue"

# display path environment variable per line
function Get-PathPerLine()
{
    $env:Path.Split(";")
}
Set-Alias path Get-PathPerLine

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