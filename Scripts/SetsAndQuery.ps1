# select, where, group, sort, 

# select some of the objects piped into it or select some properties of each object piped into it
Select-Object
select -first 10

# select top 1 directory from ls order by length desc 
ls | sort length -descending | select -first 1 directory 
ls | sort length -descending | select -first 1 | foreach { $_.DirectoryName } 
ls | sort -descending # sorts directory by filename by default 
ls | sort length # sort by any property you want


group-object 
get-command | group verb | select -expandproperty group # expands the group column 
get-command | group verb -noelement # suppress the group in the output

# use hash table switch to dump the output to a hash that you can index later
$h = get-command | group -AsHashTable 
$h['Get']
$h['Set']

$h = get-command|group -AsHashTable name
$h['Get-Command']

$h = ls | group -AsHashTable name
$h['Help.ps1']

# set-alias myalias get-childitems export / import aliases from/to a csv file

$total = 0 
ls | foreach { $total += $_.length } # sums up the lengths of the files in the directory

get-process | sort -desc cpu | select -first 3 # get top 3 cpu processes

ps | where name -match svc # match all process names with svc

get-process|Measure-Object handles -sum -average -max




















