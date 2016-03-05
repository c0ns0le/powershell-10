invoke-webrequest # (alias curl or iwr) 
$r = Invoke-WebRequest http://www.google.com 
$r.Content

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
$webservice.GetInfoByCity('New York').Table 
$webservice.GetInfoByZIP('10286').Table



