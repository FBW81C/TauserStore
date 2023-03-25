@echo off
echo Enter the Name of the Process you want to end.
set /p process=Process: 
taskkill /F /IM %process% /T
echo %process% killed.
pause
exit