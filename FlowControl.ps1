
$var = 32
switch ($var)
{
  12 {"no"}
  32 {"yes" : break}  # powershell will continue evaluating 
                      # subsequent conditions unless you specify :break
  "32" {"without break above this would match too"}
  default {"default"}
}

switch -Wildcard ("hello") { }

$i=0
while ($i++ -lt 10) { if ($i % 2) {"$i is odd"}}

do {} while (true)
do {} until (true)

for ($i=0;$i -lt 10; $i++) {}  # use foreach($i in 0..9) instead

$array = 11,12,13
foreach ($item in $array) { $item }

foreach-Object (foreach alias)
foreach ($file in get-childitem) { $file.Name }

1..5|%{$_*$_}  # percent % is short for foreach

# Do something 10 times:

foreach ($i in 1..10) { }
foreach ($i in 10..1) { }
foreach ($i in 0..($Files.Count-1)) { }
Foreach can run parallel tasks (creates separate threads) and you can throttle thread count if necessary:

foreach -parallel -ThrottleLimit 50 ($Report in $Reports) { Process-Report $Report }