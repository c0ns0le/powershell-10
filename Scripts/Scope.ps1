# variable scope

# Global  The outermost scope. Items in the global scope are visible from all other scopes.
# Script  The scope that represents the current script. Items in the script scope are visible from all other scopes in the script.
# Local   The current scope.

# Private

# To create a variable with a specific scope, supply that scope before the variable name:
$SCOPE:variable = value

# To access a variable at a specific scope, supply that scope before the variable name:
$SCOPE:variable

# To create a variable that remains even after the script exits, create it in the GLOBAL scope:
$GLOBAL:variable = value

# To change a scriptwide variable from within a function, supply SCRIPT as its scope name:
$SCRIPT:variable = value

# you can define functions are a specific scope
function GLOBAL:MyFunction { ... }
GLOBAL:MyFunction args

Get-Help about-scope





