invoke-webrequest # (alias curl or iwr) 
$r = Invoke-WebRequest http://www.google.com 
$r.Content

# pass bearer token
$url = 'http://www.somewhere.com'
$token = 'Bearer asdf8765asf7685asdf'
Invoke-WebRequest $url -Headers @{ 'Authorization'=$token }

# invoke a rest method (alias irm) 
Invoke-RestMethod http://website.com/service.aspx

# restart iis 
get-service 
start-service w3svc # name of the iis service 
stop-service w3svc 
restart-service w3svc

new-webserviceproxy # use to talk to web services

[net.dns]::GetHostByName('www.google.com') # get ip address, but just use ping

# get zipcodes from web service 
$webservice = New-WebServiceProxy -Uri 'http://www.webservicex.net/uszip.asmx?WSDL' 
$webservice | get-member
$webservice.GetInfoByCity('New York').Table 
$webservice.GetInfoByZIP('10286').Table

$uri = 'http://www.ripedev.com/webservices/localtime.asmx?WSDL'

# weather api
$uri = 'http://www.webservicex.net/globalweather.asmx?WSDL'
$webservice = New-WebServiceProxy -Uri $uri
$x = [xml]$webservice.GetCitiesByCountry("Spain")
$x.NewDataSet.Table


http://www.webservicex.net/geoipservice.asmx?WSDL 
http://www.webservicex.net/WS/WSDetails.aspx?WSID=64&CATID=12 

$uri = 'http://www.webservicex.com/stockquote.asmx?WSDL'
$uri = 'http://www.webservicex.net/RealTimeMarketData.asmx?WSDL'
$webservice = New-WebServiceProxy -Uri $uri
$webservice|Get-Member


Invoke-WebRequest 'http://www.webservicex.net/RealTimeMarketData.asmx/Quote?Symbol="GOOG"'

# System.Uri

[uri]::CheckHostName('www.yahoo.com')
[UriHostNameType]|Get-Member -Static -MemberType Properties

$uri = new-object System.Uri -ArgumentList 'http://www.google.com/my/path?query=hello'
$uri.Scheme
$uri.Host
$uri.AbsolutePath
$uri.Query

# System.Net.NetworkCredential
# Provides credentials for password-based authentication schemes such as 
# basic, digest, Kerberos authentication, and NTLM.

# System.Net.Dns
[net.dns] | Get-Member -Static
[net.dns]::GetHostByName("www.google.com")
[net.dns]::Resolve("www.google.com")
[net.dns]::GetHostByAddress("127.0.0.1")

# System.DirectoryServices.DirectorySearcher
# Performs queries against Active Directory.

# System.DirectoryServices.DirectoryEntry
# The DirectoryEntry class encapsulates a node or object in the Active Directory hierarchy.

