param([switch]$csv, [switch]$recurse)
 
[Reflection.Assembly]::LoadWithPartialName("System.Security") | out-null
$sha1 = new-Object System.Security.Cryptography.SHA1Managed
$pathLength = (get-location).Path.Length + 1
 
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
            }
        }
    }
}