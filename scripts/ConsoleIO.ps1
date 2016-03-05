# To prompt user, read from console:
read-host -prompt "Enter something"
out-host
write-host

# Formatting should only be used at the end of a pipeline
# Formatting output: format-wide -column 4 # 4 columns. fw
format-table -autosize -wrap
format-list # fl

ls | out-gridview # ogv. pops up a grid view dialog box

# Powershell equivalent to String.Format
"{0}, your balance is {1}. (Status {2})" -f $name, $balance, $status