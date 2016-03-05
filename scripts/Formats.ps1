ConvertFrom-Csv 
ConvertTo-Csv

# output data to excel csv file
ps | export-csv services.csv

# import data from excel csv file
$header = "ColumnOne", "ColumnTwo"
$mycsv = import-csv "my.csv" -header $header
$mycsv.Count

# output data to html file
ps = get-process
ps | convertto-html > ps.html
ii ps.html

ConvertTo-Xml

# load xml from file
$xml = new-object xml $xml.Load("myfile.xml")

# take an xml file and create a System.Xml.XmlDocument
([xml](get-content my.xml))

# write xml to file
$xml | out-file "myfile.xml"

# pretty print xml (pscx module) 
'Debug ' | Format-Xml
