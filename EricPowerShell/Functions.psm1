# nuget.exe install System.IdentityModel.Tokens.Jwt

$jwtPath = join-path $PSScriptRoot "packages\System.IdentityModel.Tokens.Jwt.4.0.2.206221351\lib\net45\System.IdentityModel.Tokens.Jwt.dll"
$htmlAgilityPath = join-path $PSScriptRoot  "packages\HtmlAgilityPack.1.4.9\lib\net45\HtmlAgilityPack.dll"

function Get-JwtSecurityToken
{
    [CmdletBinding()]
    Param ([Parameter(Mandatory=$true)][string]$JwtToken)

    add-type -Path $jwtPath
    new-object System.IdentityModel.Tokens.JwtSecurityToken -ArgumentList $JwtToken
}

function Reload-Module
{
    [CmdletBinding()]
    Param ([Parameter(Mandatory=$true)][string]$ModulePath)

    $moduleName = Split-Path $ModulePath -Leaf
    Remove-Module $moduleName 
    Import-Module $ModulePath
}

function Get-NetflixMovieRatings
{
    [CmdletBinding()]
    Param ([Parameter(Mandatory=$true)][string]$NetflixHtmlPath)

    add-type -Path $htmlAgilityPath 
    $doc = New-Object HtmlAgilityPack.HtmlDocument 
    $result = $doc.Load($NetflixHtmlPath) 
    $nodes = $doc.DocumentNode.SelectNodes("//li[@class='retableRow']")
    $result = $nodes | foreach { 
        $node = $_ 
        $title = $node.SelectSingleNode("div[@class='col title']//a").InnerText.Trim() 
        $rating = $node.SelectSingleNode("div[@class='col rating nowrap']//div").Attributes["data-your-rating"].Value 
        New-Object PsObject -Property @{ Title = $title; Rating = $rating} | Select Title, Rating
    }
    $result
}

function OutputFormattedBytes ($bytes)
{
                Write-Output "Hexadecimal:"
                [BitConverter]::ToString($bytes)

                Write-Output "Hexadecimal (without dashes):"
                [BitConverter]::ToString($bytes).Replace('-', '')

                Write-Output "Base64:"
                [Convert]::ToBase64String($bytes)

                Write-Output "Base64 URL:"
                [Convert]::ToBase64String($bytes).Replace('+', '-').Replace('/', '_')
}

function OutputHashes ($data)
{
                $data = [byte[]]$data
                $hashMD5 = New-Object Security.Cryptography.MD5CryptoServiceProvider
                $hashSHA1 = New-Object Security.Cryptography.SHA1Managed
                $hashSHA256 = New-Object Security.Cryptography.SHA256Managed
                $hashSHA512 = New-Object Security.Cryptography.SHA512Managed

                Write-Output "`nMD5"
                OutputFormattedBytes $hashMD5.ComputeHash($data)
                
                Write-Output "`nSHA1"
                OutputFormattedBytes $hashSHA1.ComputeHash($data)
                
                Write-Output "`nSHA256"
                OutputFormattedBytes $hashSHA256.ComputeHash($data)
                
                Write-Output "`nSHA512"
                OutputFormattedBytes $hashSHA512.ComputeHash($data)
}


# Export-ModuleMember -Function Get-JwtSecurityToken
