@echo off
:reload
cls
echo NOTE: This program is not affiliated with Mojang or Microsoft.
echo Current Directory: %cd%
echo Application Directory: %appdir%
echo Minecraft workDir: %appdir%\MCInstall
set exist=0
echo Porti WorkDir: %portiworkdir%
echo App Version 1.1
if exist %appdir%\Minecraft.exe echo 1) Start Minecraft Launcher
if exist %appdir%\olauncher.jar echo 1) Start Minecraft Launcher (UNOFFICIAL)
if exist %appdir%\Minecraft.exe set exist=1
if exist %appdir%\olauncher.jar set exist=1
if %exist%==0 echo 1) Download Minecraft Launcher
echo 2) Terminate Minecraft Launcher +javaw (game)
echo 3) Remove Minecraft Launcher
echo 4) Exit
set /p opt=Opt: 
if %opt%==1 goto checkmclauncher
if %opt%==2 goto confirmation
if %opt%==3 goto confirmation2
if %opt%==4 exit
echo The selected option was not found.
pause
goto reload
rem powershell gc banana2.txt -Wait

:checkmclauncher
cls
echo Checking ...
rem if not exist %appdir%\Minecraft.exe goto downloadmclauncher
if exist %appdir%\Minecraft.exe goto launch
if exist %appdir%\olauncher.jar goto launchunofficial
goto whichlauncher

:downloadmclauncher
rem https://launcher.mojang.com/download/Minecraft.exe
%portiworkdir%\wget.exe https://launcher.mojang.com/download/Minecraft.exe -O "%appdir%\Minecraft.exe"
goto reload

:confirmation
cls
echo Are you sure you want to close off the Minecraft Launcher and java?
echo If you have any running worlds open, they might get corrupted.
echo Do you still want to contiune? (y/n)
set /p opt=Opt: 
if %opt%==y goto killmc
if %opt%==n goto reload
goto confirmation

:killmc
taskkill /F /IM Minecraft.exe /T
taskkill /F /IM java.exe /T
taskkill /F /IM javaw.exe /T
ech Done!
pause
goto reload

:confirmation2
cls
echo Do you want to delete Minecraft.exe and / or olauncher.jar ? (y/n)
echo NOTE: Make sure to close off the Minecraft Launcher before you proceed.
set /p opt=Opt: 
if %opt%==y goto delmcexe
if %opt%==n goto reload
goto confirmation2

:delmcexe
del %appdir%\Minecraft.exe /Q /F
del %appdir%\olauncher.jar /Q /F
echo Done!
pause
goto reload

:launch
cls
echo Starting Minecraft launcher...
echo Executing: %appdir%\Minecraft.exe --workDir %cd%\%appdir%
start cmd /c "%appdir%\Minecraft.exe --workDir %cd%\%appdir%"
pause
goto reload

:whichlauncher
cls
echo Choose an Minecraft Launcher.
echo 1) Official Minecraft Launcher from Mojang
echo 2) Olauncher from github (https://github.com/olauncher/olauncher) (Works better on older PCs and USB Devices, but requires java)
set /p opt=Opt: 
if %opt%==1 goto downloadmclauncher
if %opt%==2 goto downloadolauncher
goto whichlauncher

:downloadolauncher
cls
echo Checking for Java...
if not exist "%portiworkdir%\Java\jdk-17.0.7+7\bin\java.exe" goto javanotfound
goto startdownloadolauncher

:javanotfound
cls
echo You need to install Java to use Olauncher.
echo Open the Tauser Store from Porti, select bat software and Download OpenJDK / Java Microsoft Build (option 8)
echo You can also install a different Java version into the "%portiworkdir%\Java\" directory.
echo Make sure the java executable is stored in these sub-folders: "%portiworkdir%\Java\jdk-17.0.7+7\bin\java.exe"
pause
goto reload

:startdownloadolauncher
cls
echo Java has been detected in "%portiworkdir%\Java\jdk-17.0.7+7\bin\java.exe"
echo Downloading olauncher from github...
"%portiworkdir%\wget.exe" https://github.com/olauncher/olauncher/releases/download/v1.7.2_09/olauncher-1.7.2_09-redist.jar -O "%cd%\%appdir%\olauncher.jar"
echo Done!
pause
goto reload

:launchunofficial
cls
echo Java: launching %cd%\%appdir%\olauncher.jar
"%portiworkdir%\Java\jdk-17.0.7+7\bin\java.exe" -jar "%cd%\%appdir%\olauncher.jar" --workDir "%cd%\%appdir%"
