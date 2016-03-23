# trap statement

function myfunc
{ # func code here

    trap {   
        # catch statement catches .net error types  
        write-host "oh no an error!"  
        continue # continue to the next line of code after the error  
        break # stops function and returns to caller instead  
    }
}

write-debug # writes debug info

# whatif parameter can be used to find out what a command will do before actually running it


