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