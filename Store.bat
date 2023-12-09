@echo off
@echo off
set newuserprofile=%systemdrive%\User
md %newuserprofile%
:login
title Tauser Store
set weburl=https://raw.githubusercontent.com/FBW81C/TauserStore/main/
color 20
cls
echo -------------------
echo Tauser Store
echo by Banane#9114 (jangames)
echo Version 8.99
echo -------------------
set verder=0
if exist %newuserprofile% set /a verder=%verder%+1
set verder=0
if %verder%==0 echo %newuserprofile% is for the program now %systemdrive%\User\!
if %verder%==0 if not exist %systemdrive%\User md %systemdrive%\User
if %verder%==0 if not exist %systemdrive%\Downloads md %systemdrive%\Downloads
if %verder%==0 set userprofile=%systemdrive%\User\
rem echo -------------------
pause
:directlogin
if not exist %newuserprofile%\Ungenickt md %newuserprofile%\Ungenickt
if not exist %newuserprofile%\Downloads md %newuserprofile%\Downloads
cls
color 2
echo Deleting Cache...
del %newuserprofile%\Ungenickt\*.sys /Q /F >NUL
if exist %newuserprofile%\Ungenickt\script.bat del %newuserprofile%\Ungenickt\script.bat /Q /F >NUL
if exist %newuserprofile%\Ungenickt\Storeupdater.bat del %newuserprofile%\Ungenickt\Storeupdater.bat /Q /F >NUL
cls
color e
echo Connecting to server...
if not exist %newuserprofile%\Ungenickt\wget.exe copy %windir%\LockerBlock\wget.exe %newuserprofile%\Ungenickt\wget.exe
if not exist %newuserprofile%\Ungenickt\wget.exe if %useporti%==1 copy "%portiworkdir%\wget.exe" "%newuserprofile%\Ungenickt\wget.exe"
%newuserprofile%\Ungenickt\wget.exe "%weburl%status.sys" -O%newuserprofile%\Ungenickt\status.sys -q --no-cache
rem echo false>%newuserprofile%\Ungenickt\statusvergleich.sys
rem fc %newuserprofile%\Ungenickt\status.sys %newuserprofile%\Ungenickt\statusvergleich.sys
rem if %errorlevel%==1 goto wartungen
if not exist %newuserprofile%\Ungenickt\status.sys goto offline
type %newuserprofile%\Ungenickt\status.sys | findstr /C "false"
if not %errorlevel%==0 goto offline
for /F "usebackq" %%a in (%newuserprofile%\Ungenickt\status.sys) do set serverstatus=%%a
if not %serverstatus%==false goto wartungen
cls
echo Connected to server!
:check4updates
cls
echo Checking for updates...
set version=8.99
%newuserprofile%\Ungenickt\wget.exe "%weburl%version.sys" -O%newuserprofile%\Ungenickt\latestversion.sys -q --no-cache
for /F "usebackq" %%a in (%newuserprofile%\Ungenickt\latestversion.sys) do set latestversion=%%a
if %version%==%latestversion% goto loadstore
goto askifuwant2update
:downloadupdate
cls
echo Downloading update...
%newuserprofile%\Ungenickt\wget.exe "%weburl%Store.bat" -O%newuserprofile%\Ungenickt\Storeupdate.sys -q --no-cache
echo Writing Updater-Script...
echo @echo off>%newuserprofile%\Ungenickt\Storeupdater.bat
echo timeout 1 >>%newuserprofile%\Ungenickt\Storeupdater.bat
echo echo Updating Ungenickt Store>>%newuserprofile%\Ungenickt\Storeupdater.bat
echo copy %newuserprofile%\Ungenickt\Storeupdate.sys "%~f0">>%newuserprofile%\Ungenickt\Storeupdater.bat
echo start cmd /c "%~f0">>%newuserprofile%\Ungenickt\Storeupdater.bat
echo exit>>%newuserprofile%\Ungenickt\Storeupdater.bat
echo Starting update...
start %newuserprofile%\Ungenickt\Storeupdater.bat
exit

:loadstore
type NUL>%newuserprofile%\Ungenickt\empty.sys
set backcmd=0
set checker=0
set progfol=0
set progopt=0
cls
color e
echo Requesting store page...
%newuserprofile%\Ungenickt\wget.exe "%weburl%progfol.sys" -O%newuserprofile%\Ungenickt\progfol.sys -q --no-cache
cls
echo Requesting preperation script...
%newuserprofile%\Ungenickt\wget.exe "%weburl%sysprep.sys" -O%newuserprofile%\Ungenickt\sysprep.bat -q --no-cache
find "@echo off" %newuserprofile%\Ungenickt\sysprep.bat >NUL
if %errorlevel%==0 goto runprep

:afterprep
color
title Tauser Store: Main Menu (Connected)
cls
type %newuserprofile%\Ungenickt\progfol.sys
set /p progfol=Opt: 
cls
color e
echo Loading folder...
title Tauser Store: Download in Progress...
:folderdownload
%newuserprofile%\Ungenickt\wget.exe "%weburl%%progfol%/info.sys" -O%newuserprofile%\Ungenickt\progs.sys -q --no-cache
fc %newuserprofile%\Ungenickt\progs.sys %newuserprofile%\Ungenickt\empty.sys
if %errorlevel%==0 del %newuserprofile%\Ungenickt\progs.sys /Q /F
:folder
if not exist %newuserprofile%\Ungenickt\progs.sys set checker=1
if not exist %newuserprofile%\Ungenickt\progs.sys set checkurl=%weburl%%progfol%/script.sys
if not exist %newuserprofile%\Ungenickt\progs.sys goto foldernotexist
title Tauser Store: Connected! (DIR: %weburl%%progfol%/)
cls
color
set yesitis=0
type %newuserprofile%\Ungenickt\progs.sys
set /p progopt=Opt: 
:loadprogopt
title Tauser Store: Downloading...
echo Downloading %progopt%-Info ...
%newuserprofile%\Ungenickt\wget.exe "%weburl%%progfol%/%progopt%/info.sys" -O%newuserprofile%\Ungenickt\info.sys -q --no-cache
if %errorlevel%==8 set yesitis=1
if %yesitis%==1 set checker=1
if %yesitis%==1 set checkurl=%weburl%%progfol%/%progopt%/script.sys
if %yesitis%==1 goto foldernotexist
:proginfo
if not exist %newuserprofile%\Ungenickt\info.sys set checker=1
if not exist %newuserprofile%\Ungenickt\info.sys set checkurl=%weburl%%progfol%/%progopt%/script.sys
if not exist %newuserprofile%\Ungenickt\info.sys goto foldernotexist
echo ERRORLEVEL: %errorcode%
cls
type %newuserprofile%\Ungenickt\info.sys
echo 1) Download
echo 2) Back
echo 3) Exit
set /p downloadopt=Opt: 
if %downloadopt%==1 goto downloadprog
if %downloadopt%==2 goto folder
if %downloadopt%==3 exit
cls
goto proginfo

:downloadprog
title Tauser Store: Getting Download details...
cls
echo Checking filetype...
%newuserprofile%\Ungenickt\wget.exe "%weburl%%progfol%/%progopt%/filetype.sys" -O%newuserprofile%\Ungenickt\filetype.sys -q --no-cache
for /F "usebackq" %%a in (%newuserprofile%\Ungenickt\filetype.sys) do set type=%%a
rem if %type%==zip goto downloadunzip
echo Checking for Mirrors...
%newuserprofile%\Ungenickt\wget.exe "%weburl%%progfol%/%progopt%/mirrors.sys" -O%newuserprofile%\Ungenickt\mirrors.sys -q --no-cache
fc %newuserprofile%\Ungenickt\mirrors.sys %newuserprofile%\Ungenickt\empty.sys
if %errorlevel%==0 del %newuserprofile%\Ungenickt\mirrors.sys /Q /F
if exist %newuserprofile%\Ungenickt\mirrors.sys goto selectmirror
goto downloadprognow

:downloadprognow
title Tauser Store: Download in Progress...
if not exist %newuserprofile%\Downloads md %newuserprofile%\Downloads
cls
echo Downloading %progopt% ...
%newuserprofile%\Ungenickt\wget.exe "%weburl%%progfol%/%progopt%/%progopt%.%type%" -O%newuserprofile%\Downloads\%progopt%.%type% -q --no-cache
:downloaddone
title Tauser Store: Download completed!
cls
echo Download successful!
echo 1) Open %progopt%
echo 2) Open Folder
echo 3) Back
echo 4) Quit
if not exist %newuserprofile%\Downloads\%progopt%.%type% goto downloaderror
set /p downloaddoneopt=Opt: 
if %downloaddoneopt%==1 goto startdownload
if %downloaddoneopt%==2 goto opendownloadfolder
if %downloaddoneopt%==3 goto login
if %downloaddoneopt%==4 exit
goto login

:startdownload
start %newuserprofile%\Downloads\%progopt%.%type%
goto login

:opendownloadfolder
start %newuserprofile%\Downloads
goto login

:wartungen
title Tauser Store: Maintenance
cls
color c
if %serverstatus%==mainreason goto mainreason
echo The Server is currently in maintenance mode!
echo Server status: %serverstatus%
echo No further details are currently available.
echo 1) Ignore and bypass maintenance mode for this session
echo 2) Retry
echo 3) Exit
set /p opt=Opt: 
if %opt%==1 goto askifupdate
if %opt%==2 goto directlogin
if %opt%==3 exit
pause
exit

:offline
type %newuserprofile%\Ungenickt\status.sys | findstr /C "true"
if %errorlevel%==0 goto wartungen
cls
echo Unable to connect to server.
echo Please check your internet connection and try again.
pause
exit

:foldernotexist
title Tauser Store: Checking for script...
rem if %checker%==1 echo hi
if %checker%==1 %newuserprofile%\Ungenickt\wget.exe "%checkurl%" -O%newuserprofile%\Ungenickt\checkifscript.sys -q --no-cache
if %checker%==1 type NUL>%newuserprofile%\Ungenickt\empty.sys
if %checker%==1 fc %newuserprofile%\Ungenickt\checkifscript.sys %newuserprofile%\Ungenickt\empty.sys
if %checker%==1 if %errorlevel%==0 goto realfoldernotexist
if %checker%==1 rename %newuserprofile%\Ungenickt\checkifscript.sys script.bat
if %checker%==1 title Tauser Store: Running Script (%newuserprofile%\Ungenickt\script.bat) IRL: %checkurl%
if %checker%==1 echo Executing Script from Server...
if %checker%==1 call %newuserprofile%\Ungenickt\script.bat
if %checker%==1 %backcmd%
if %checker%==1 echo Back command executed, but there was no goto command.
if %checker%==1 echo Press a random key to reload the Store.
rem if %checker%==1 pause >NUL
if %checker%==1 goto directlogin
:realfoldernotexist
title Tauser Store: Folder not found.
cls
echo This Folder does not exist!
pause
goto directlogin

:selectmirror
echo Downloading Mirror URL...
for /F "usebackq" %%a in (%newuserprofile%\Ungenickt\mirrors.sys) do set downloadlink=%%a
cls
echo You can use a mirror for this download!
echo 1) Tauser Store
echo 2) Official Site
echo Mirror: %downloadlink%
set /p mirroropt=Opt: 
if %mirroropt%==1 goto downloadprognow
if %mirroropt%==2 goto downloadmirror
echo This is not an Option!
pause
goto selectmirror

:downloadmirror
%newuserprofile%\Ungenickt\wget.exe "%downloadlink%" -O%newuserprofile%\Downloads\%progopt%.%type% -q --no-cache
goto downloaddone

:downloaderror
echo An error occoured while downloading the file.
echo Press any key to reveal technical details.
pause >NUL
cls
echo Technical details:
echo --------------
set
echo --------------
echo Press any key to reload TauserStore.
pause >NUL
goto login

:mainreason
cls
color e
echo The server is in maintenance mode!
echo Downloading details, please wait!
%newuserprofile%\Ungenickt\wget.exe "%weburl%reason.sys" -O%newuserprofile%\Ungenickt\reason.sys -q --no-cache
cls
color c
echo The server is currently in maintenance mode!
echo.
echo --------------------------------------------
type %newuserprofile%\Ungenickt\reason.sys
echo --------------------------------------------
echo.
echo 1) Retry
echo 2) Ignore
echo 3) Exit
set /p opt=Opt: 
if %opt%==1 goto directlogin
if %opt%==2 goto askifupdate
if %opt%==3 exit
goto mainreason

:askifupdate
cls
color 4
echo Bypass Maintenance Mode
echo Do you want to check for updates?
echo 1) Skip Updates
echo 2) Check for Updates
set /p opt=Opt: 
if %opt%==1 goto loadstore
if %opt%==2 goto check4updates
goto askifupdate

:askifuwant2update
cls
color a
echo An update is available!
echo It is recommended to download updates.
echo Do you want to download the update?
echo 1) Download update
echo 2) Continue without update
echo 3) Exit
set /p opt=Opt: 
if %opt%==1 goto downloadupdate
if %opt%==2 goto loadstore
if %opt%==3 exit
goto askifuwant2update

:runprep
color e
call %newuserprofile%\Ungenickt\sysprep.bat
if not defined exitcmd goto noexitcmd
%exitcmd%

:noexitcmd
color c
echo No valid prep-point found.
goto afterprep