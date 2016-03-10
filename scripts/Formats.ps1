ConvertFrom-Csv 
ConvertTo-Csv

# output data to excel csv file
Get-Process | Export-Csv services.csv

# import data from excel csv file
$header = "ColumnOne", "ColumnTwo"
$mycsv = import-csv "my.csv" -header $header
$mycsv.Count

# output data to html file
Get-Process | ConvertTo-Html > ps.html
ii ps.html
start ps.html

ConvertTo-Xml

# load xml from file
$xml = new-object xml $xml.Load("myfile.xml")

# take an xml file and create a System.Xml.XmlDocument
([xml](get-content my.xml))

# write xml to file
$xml | out-file "myfile.xml"

# pretty print xml (pscx module) 
'Debug ' | Format-Xml

# parse an xml string
$s = '<customer name="larry">smith</customer>'
$x = [xml]$s
$x.customer
$x.customer.name
$x.customer.'#text'

# transform text output from a program into first-class objects 
# basic idea is to turn the text into a csv file and then convert the csv into objects 
myprogramwithtextoutput | foreach {$_ -replace "\s+",','} | ConvertFrom-Csv -Header Col1,Col2


