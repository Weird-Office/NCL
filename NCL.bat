@echo off
title NCL
set root=C:\NCL_DATA
set curma2=NULL
set curip2=NULL
set curgw2=NULL
set cursb2=NULL
if exist %root% (echo>nul FLDR_OK) else (mkdir %root%)
::if exist %root%\
start %root%
:nclselect
echo  NCL Local or Remote?
set /p nclsel= L/R:
if %nclsel%==R (set nclsel=true)
if %nclsel%==r (set nclsel=true)
if %nclsel%==true (goto ncl_remote) else (goto ncl_local)

:ncl_local
:lstart
cls
if exist %root% (echo>nul FLDR_OK) else (mkdir %root%)
ipconfig/all | findstr /i "Physical" > %root%\log_mc.txt
ipconfig | findstr /i "IPv4" > %root%\log_ip.txt
ipconfig | findstr /i "gateway" > %root%\log_gw.txt
ipconfig | findstr /i "subnet" > %root%\log_sb.txt
set /p curmc1= < %root%\log_mc.txt
set /p curip1= < %root%\log_ip.txt
set /p curgw1= < %root%\log_gw.txt
set /p cursb1= < %root%\log_sb.txt
if "%curmc1%"=="%curmc2%" (echo>nul MC OK )else (goto changelog)
if "%curip1%"=="%curip2%" (echo>nul IP OK )else (goto changelog)
if "%curgw1%"=="%curgw2%" (echo>nul GW OK )else (goto changelog)
if "%cursb1%"=="%cursb2%" (echo>nul SN OK )else (goto changelog)
::
:var2
set /p curmc2= < %root%\log_mc.txt
set /p curip2= < %root%\log_ip.txt
set /p curgw2= < %root%\log_gw.txt
set /p cursb2= < %root%\log_sb.txt
echo.
echo  Current network setup 
echo.
echo %curmc1%
echo.
echo %curip1%
echo %curgw1%
echo %cursb1%
echo.
echo  This proccess will repeat every 5 seconds . . .
echo  Press any key to refresh . . .
timeout>nul /t 4
echo.
echo  Checking network setup . . .
timeout>nul /t 1
goto lstart
:changelog
if exist %root%\log_change.txt echo  The change in network setup has been logged in C:\NCL_DATA\log_change.txt
if not exist %root%\log_change.txt echo %root%\log_change.txt has been created and will log any network changes
echo >> %root%\log_change.txt --------------------Setup Changed--------------------
echo    %date% >> %root%\log_change.txt && echo    %time% >> %root%\log_change.txt
echo. >> %root%\log_change.txt
echo %curmc1% >> %root%\log_change.txt
echo. >> %root%\log_change.txt
echo %curip1% >> %root%\log_change.txt
echo %curgw1% >> %root%\log_change.txt
echo %cursb1% >> %root%\log_change.txt
echo. >> %root%\log_change.txt
goto var2












:ncl_remote
set net=NCL_NET
if exist %root%\%net% (echo>nul FLDR_OK) else (mkdir %root%\%net%)
::
echo  Using this tool will enable Admin Shares on host and target machines. Would you like to continue?
set /p nclr_con= Y/N:
if %nclr_con%==Y (set nclr_con=true)
if %nclr_con%==y (set nclr_con=true)
cls
if %nclr_con%==true (echo>nul OK) else (goto nclselect)
echo.
echo  Does the target machine have Admin Shares enabled?
set /p targetadminshares= Y/N:
if %targetadminshares%==Y (set targetadminshares=true)
if %targetadminshares%==y (set targetadminshares=true)
cls
if %targetadminshares%==true (goto PSTools)
echo REG ADD HKLM\Software\Microsoft\windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f >> %root%\%net%\reg.txt
echo. >> %root%\%net%\reg.txt
echo Run the above command on target machine. >> %root%\%net%\reg.txt
start %root%\%net%\reg.txt
:PSTools
cls
if exist C:\Windows\System32\PsExec.exe (echo  PsExec tool found && goto PSToolsFound)
echo  PsExec tool missing
echo  PSTools download will start started in default browser.
echo  Extract files to C:\Windows\System32.
timeout>nul -t 5
start https://download.sysinternals.com/files/PSTools.zip
pause
goto PSTools
:PSToolsFound
echo.
echo  What is the IP of host machine? IP must be relevent to network you wish to use.
set /p iphost= _Enter IP: 
echo.
echo  Enter Username and Password of an admin account on host machine.
set /p userhost= _Enter Host Username: 
echo  _Enter Host Password: 
set>nul /p passhost= _Enter Host Password: 
echo.
echo.
echo.
echo.
echo.
::
echo What is the IP of target machine?
set /p iptarget= _Enter IP: 
echo.
echo  Enter Username and Password of an admin account on target machine.
set /p usertarget= _Enter Target Username: 
set /p passtarget= _Enter Target Password: 
echo.
pause

REG ADD HKLM\Software\Microsoft\windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
net stop server /Y
net start server
pause



set L1=@echo off
set L2=title test variable script
set L3=set name=alison
set L4=cls
set L5=echo.
set L6=echo my name is %%name%%
set L7=if %%name%%==alison echo looks like the variable worked
set L8=goto skip
set L9=echo should not show
set L10=:skip
set L11=echo did the skip show
set L12=timeout /t 3
set L13=pause

echo %L1% >> %root%\%data%\ncl_r.bat
echo %L2% >> %root%\%data%\ncl_r.bat
echo %L3% >> %root%\%data%\ncl_r.bat
echo %L4% >> %root%\%data%\ncl_r.bat
echo %L5% >> %root%\%data%\ncl_r.bat
echo %L6% >> %root%\%data%\ncl_r.bat
echo %L7% >> %root%\%data%\ncl_r.bat
echo %L8% >> %root%\%data%\ncl_r.bat
echo %L9% >> %root%\%data%\ncl_r.bat
echo %L10% >> %root%\%data%\ncl_r.bat
echo %L11% >> %root%\%data%\ncl_r.bat
echo %L12% >> %root%\%data%\ncl_r.bat
echo %L13% >> %root%\%data%\ncl_r.bat
echo this will exit
pause
exit




