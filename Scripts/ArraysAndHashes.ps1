# array

$array = 1,2,3,4
$array = (1,2,3,4)
$array = "bill", "george"
$array[0] = "jill"
$array = @() # empty array
$array.Count

$array = 1..10
$array = 10..1 # backwards
$array = 1..($count) # use variable
$array -contains 42 # false

# use list for large sets 

$array = New-Object System.Collections.Generic.List[int]
foreach ($i in 1..1000000) { $array.Add($i) }

# hash (associative array)

$hash = @{"key" = "value"; "anotherkey" = "anothervalue"}
$hash["key"]
$mykey = "anotherkey"
$hash.$mykey
$hash.Remove("key")
$hash.Contains("something")
$hash.ContainsValue("else")
$hash = @{} # empty hash
$hash = @{a=1; b=2}
$hash # display
$hash.a # value of a
$hash["a"] # value of a

# stack 

$stack = New-Object System.Collections.Stack
$stack = New-Object System.Collections.Generic.Stack[int]
$stack.Push(4)
$stack.Pop()
$stack

# queue

$q = New-Object System.Collections.Queue
$q = New-Object System.Collections.Generic.Queue[int]
$q.Enqueue(4)
$q.Peek()
$q.Dequeue()
$q.Count
$q

# dictionary

$dict = New-Object "System.Collections.Generic.Dictionary[int,string]"
$dict.Add(5,"hello")
$dict.Remove(5)
$dict.Count
$dict

# hashset

$hashset = New-Object System.Collections.Generic.HashSet


















