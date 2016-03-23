# To use Invoke-SqlCmd do this first: 
Add-PSSnapin SqlServerCmdletSnapin100 
Add-PSSnapin SqlServerProviderSnapin100

# Red Gate sqlcompare has command line utility

$Database = 'Name_Of_SQLDatabase' 
$Server = '192.168.100.200' 
$UserName = 'DatabaseUserName' 
$Password = 'SecretPassword' 
$SqlQuery = 'Select * FROM TestTable'

# Accessing Data Base 
$SqlConnection = New-Object -TypeName System.Data.SqlClient.SqlConnection 
$SqlConnection.ConnectionString = "Data Source=$Server;Initial Catalog=$Database;user id=$UserName;pwd=$Password" 
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand 
$SqlCmd.CommandText = $SqlQuery 
$SqlCmd.Connection = $SqlConnection 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter 
$SqlAdapter.SelectCommand = $SqlCmd 
$set = New-Object data.dataset

# Filling Dataset 
$SqlAdapter.Fill($set)

# Consuming Data 
$Path = "$env:temp\report.hta" 
$set.Tables[0] | ConvertTo-Html | Out-File -FilePath $Path

Invoke-Item -Path $Path