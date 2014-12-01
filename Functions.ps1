# .\Untitled3.ps1 *.* -recurse | group-object sha | Where count -gt 1 |foreach { $_.group | select -first 1}

# PS C:\Users\Eric\Source> .\Untitled3.ps1 *.* -recurse | group-object sha | Where count -gt 1 | foreach { $a = $_; $_ | foreach { $_.group | select @{Name="Count";Expression={$a.count}}, * -first 1  }}



param([switch]$csv, [switch]$recurse)
 
[Reflection.Assembly]::LoadWithPartialName("System.Security") | out-null
$sha1 = new-Object System.Security.Cryptography.SHA1Managed
$pathLength = (get-location).Path.Length + 1
# $StringBuilder = New-Object System.Text.StringBuilder 50

$args | %{
    if ($recurse) {
        $files = get-childitem -recurse -include $_
    }
    else {
        $files = get-childitem -include $_
    }
 
    if ($files.Count -gt 0) {
        $files | %{

            $filename = $_.FullName
            $filenameDisplay = $filename.Substring($pathLength)
             
            if ($csv) {
                write-host -NoNewLine ($filenameDisplay + ",")
            } else {
                write-host $filenameDisplay
            }
 
            $file = [System.IO.File]::Open($filename, "open", "read")
            $sha1.ComputeHash($file) | %{
                write-host -NoNewLine $_.ToString("x2")
            }
            $file.Dispose()
 
            write-host
            if ($csv -eq $false) {
                write-host

<#
            $file = [System.IO.File]::Open($filename, "open", "read")
            $sha1.ComputeHash($file) | %{
                [void]$StringBuilder.Append($_.ToString("x2")) 
            }
            $file.Dispose()

            $object = New-Object –TypeName PSObject
            $object | Add-Member –MemberType NoteProperty –Name filename –Value $filenameDisplay
            $object | Add-Member –MemberType NoteProperty –Name sha –Value $StringBuilder.ToString();
            Write-Output $object
            [void]$StringBuilder.Clear();

            #>


            }
        }
    }
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

# make the window wide for easier copying of hashes
[console]::WindowWidth = [console]::LargestWindowWidth - 5

#hash three bytes
OutputHashes @(255, 1, 3) 
