@echo off
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
call :LOG_DT "..."
call :LOG_DT "Logging to file - %file_log%"
call :LOG_DT "... START %0"

rem "%~n0.vbs" %*

set ROOTDIR=%CD%
call :LOG_DT "ROOTDIR = '%ROOTDIR%' ..."
CALL :CHANGEDIR %CDIR%

rem Read config file
echo ==========================================================================================
set MYINI=%~dp0%~n0.ini
if exist !MYINI! (
call :LOG_DT "CONFIG = '!MYINI!' ..."
FOR /F "eol=; tokens=1,2,3 delims=: usebackq" %%a in (%MYINI%) do (
echo '%%a' '%%b' '%%c'
if "%%a" == "Setup" (
set PATH1=%%b
set PATH2=%%c
call :LOG_DT "PATH1= '!PATH1!' ..."
call :LOG_DT "PATH2= '!PATH2!' ..."
) else ( 
call :LOGERROR "Config file !MYINI! bad ..."
goto :FAILURE
)
)
) else (
call :LOGERROR "Config file !MYINI! no found ..."
goto :FAILURE
)

call :CREATEDIR "!Path2!"
xcopy "!path1!\*.*" "%CD%\!Path2!" /e /y /j

:END
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
call :LOG_DT "END %0 ..."
exit 0
goto :eof

rem ---------------------------------------------------------------------------------------

:CHANGEDIR
rem call :LOG_DT "CHDIR '%~1' ..."
cd %~1
call :LOG_DT "CHDIR '%CD%' ..."
goto :eof

:CREATEDIR
call :LOG_DT "DIR '%~1' ..."
if not exist %~1 (
call :LOG_DT "CREATE dir '%~1' ..."
mkdir %~1
)
goto :eof


rem %1
rem %2
:CREATELINKDIR
if exist "%~2" (
	if not exist  "%~1" (
		echo CREATE %~1
		mklink /d "%~1" "%~2"
	) else echo "%~1" - EXIST
) else echo "%~2" - NO EXIST
goto :eof

rem %1 "%~1"
rem call :LOG Logtxt
:LOG
echo %~1
echo %~1 >> %file_log%
goto :eof

:LOG_DT
set t1=%TIME:~0,1%
if "%t1%" == " " (
 set dt=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2% 0%TIME:~1,1%:%TIME:~3,2%:%TIME:~6,2%
) else (
 set dt=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%
)
echo %dt% %~1
echo %dt% %~1 >> %file_log%
goto :eof
