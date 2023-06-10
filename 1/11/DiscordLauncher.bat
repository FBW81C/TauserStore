@echo off
echo Searching for Discord.exe ...
dir Porti\Applications\%app%\Discord.exe /S /B>Porti\Applications\%app%\discordexec.sys
set /p exec=<Porti\Applications\%app%\discordexec.sys
start /max cmd /c %exec%
exit
