#### Key Commands
* user mode: window key > powershell
* admin mode: window key > powershell ctrl+shft+enter
* explorer to powershell: alt D > powershell
* powershell to explorer: ii .
* launch url in browser:  start http://url
* copy to clipboard:   highlight text and hit enter or right click or pipe to clip
* paste from clipboard:  right mouse button
* pass command to cmd.exe:  cmd /c dir
* F7 display window with command history
* ESC - clear command line
* ctrl+end - clear line after cursor
* ctrl-left/right - jump by word
* home/end - beginning/end of line
* backtick spans multiple lines, enter on empty line executes command
* set windows to open ps1, psm1, psd1 files with powershell ISE

#### ISE
* powershell_ise.exe - integrated scripting environment
* F5 - run entire script
* F8 - run highlighted or current line
* ctrl+D - goto console
* ctrl+I - goto script

#### Types of commands
* _cmdlets_ - Implemented by a .NET class that derives from the Cmdlet base class in the PowerShell SDK.  Cmdlets are compiled into a DLL and loaded into the PowerShell process.  Verb-Noun form.
* _shell function commands_ - function Do-Something { }
* _script commands_ - code in a file with ps1 extension
* _native win32 windows commands_

#### Aliases and shortcuts
* unix commands ls, cat, mv, cp, man, pwd, ps, grep
* ? is short for where
* % is short for foreach

#### Visual Studio
* studioshell - powershell inside visual studio window
* traverse visual studio ide object tree like a drive in powershell
* myproject.psm1 project solution module file.  lives next to myproject.sln file
* when visual studio opens a solution file, it automatically runs the psm1 file.
* add entries to visual studio menus

#### Websites
* [Powershell.com](http://powershell.com)
* [Mad With Powershell](http://www.madwithpowershell.com)
* [Owners Manual Technet](https://technet.microsoft.com/en-us/library/ee221100.aspx)
* [Learning Powershell Msdn](https://msdn.microsoft.com/en-us/library/cc281945.aspx)
* [Get Powershell Blog](http://get-powershell.com)
* [Master Powershell Tutorial](http://powershell.com/cs/blogs/ebookv2/default.aspx)
* [Hey Scripting Guy](https://blogs.technet.microsoft.com/heyscriptingguy)

#### Module Repositories 
* [Microsoft Script Center](https://technet.microsoft.com/en-us/scriptcenter/default)
* [PoshCode](http://poshcode.org/)
* codeplex
* github
* nuget
* [PsGet](http://psget.net/)

#### Modules
* [Popular Modules](http://social.technet.microsoft.com/wiki/contents/articles/4308.popular-powershell-modules.aspx) 
* [Azure Powershell](https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/)
* [SQL Powershell Extensions](http://sqlpsx.codeplex.com/)
* [Powershell Community Extensions PSCX](http://pscx.codeplex.com/)
* [OData Powershell Explorer](http://psodata.codeplex.com/)
* [Powershell ISE Pack](http://powershellise.com/)



