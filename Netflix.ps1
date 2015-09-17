cd C:\Users\Eric\HtmlAgilityPack.1.4.9\lib\Net45

add-type -Path .\HtmlAgilityPack.dll 

$doc = New-Object HtmlAgilityPack.HtmlDocument 

$result = $doc.Load("C:\Users\Eric\Desktop\Netflix.html") 

$nodes = $doc.DocumentNode.SelectNodes("//li[@class='retableRow']")

$result = $nodes | foreach { 

    $node = $_ 

    $title = $node.SelectSingleNode("div[@class='col title']//a").InnerText.Trim() 

    $rating = $node.SelectSingleNode("div[@class='col rating nowrap']//div").Attributes["data-your-rating"].Value 

    New-Object PsObject -Property @{ Title = $title; Rating = $rating} | Select Title, Rating
}

$result


