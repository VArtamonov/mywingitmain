@echo off
chcp 1251 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0

call :LOGLINE1
call :LOGSTART "START '%~0'"
title "%~n0 - Работа с PostgreSQL ..."
call :LOGINFO "Log file - '%file_log%'"
call :LOGINFO "Текущей каталог: '%CD%'"
call :LOGINFO "Случайное десятичное число: %RANDOM%"

call :LOGLINE2
call :LOGINFO  "TEST INFO  ..."
call :LOGERROR "TEST ERROR ..."

call :LOGLINE2
rem root dir
set ROOTDIR=%CD%
call :LOGINFO "ROOTDIR = '%ROOTDIR%' ..."
call :CHANGEDIR %ROOTDIR%

:END
call :LOGLINE2
call :LOGINFO "ERRORLEVEL %ERRORLEVEL%"
call :LOGINFO "END '%~0' ..."
call :LOGLINE0
exit 0
goto :eof

:FAILURE
call :LOGLINE2
call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
call :LOGERROR "END '%~0' ..."
call :LOGLINE0
exit 1
goto :eof


rem ABBALibraryFilesStart
rem ==============================================================================================

rem ==========
:FINDZIP
call :FINDFILE "7z.exe" "ZIPEXE" "C:" "C:\Program Files\7-Zip"
rem "%ZIPEXE%"
goto :eof

rem ==========
:FINDFILE
call :LOGINFO "FIND '%~1' ..."
echo off
for /D %%k in (%3 %4 %5 %6 %7 %8 %9) do (
 rem for '%~1' %%i in ('%~2') do (
 set z1=%%~k\%~1
 rem echo !z1!
 if exist !z1! (
   set %~2=!z1!
   call :LOG "FOUND %~1 = '!%~2!'"
   goto :eof
 )
)
rem ) else (
  call :LOGERROR "'%~2' no found"
  call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
  goto :FAILURE
rem )
echo off
goto :eof

rem ==========
:CHANGEDIR
rem call :LOG_DT "CHDIR '%~1' ..."
cd "%~1"
call :LOG_DT "CHDIR '%CD%' ..."
goto :eof

rem ==========
:CREATEDIR
call :LOG_DT "DIR '%~1' ..."
if not exist %~1 (
call :LOG_DT "CREATE dir '%~1' ..."
mkdir "%~1"
)
goto :eof

rem ==========
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

rem ==========
:CROOTDIR
set ROOTDIR=%~1
if not exist %ROOTDIR% (
call :LOG_DT "CREATE dir '%ROOTDIR%' ..."
mkdir %projectdirname%
) else (
call :LOG_DT "DIR '%ROOTDIR%' ..."
)
call :LOG_DT "ROOTDIR = '%ROOTDIR%' ..."
goto :eof

rem ==========
:CHECKDIR
call :LOG_DT "CHECK DIR '%~1' ..."
if not exist "%~1" (
call :LOGERROR "DIR '%~1' - NOT EXIST ..."
exit /b 0
) else (
call :LOGINFO "DIR '%~1' - OK"
exit /b 1
)
goto :eof

rem ABBALibraryFilesEnd


rem ABBALibraryCmdLogStart
rem ==============================================================================================

rem ==========
:LOGLINE0
echo +-------------------+-----+-----------------------------------------------------------------------
goto :eof

rem ==========
:LOGLINE1
echo --------------------+-----+-----------------------------------------------------------------------
goto :eof

rem ==========
:LOGLINE2
echo +-------------------+-----+-----------------------------------------------------------------------
goto :eof

rem ==========
:LOG
call :LOGSTR "INFO " "%~1"
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%" "[37m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGINFO
call :LOGSTR "INFO " "%~1"
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%" "[32m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGDEBUG
call :LOGSTR "INFO " "%~1"
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%" "[33m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGERROR
call :LOGSTR "ERROR" "%~1"
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%" "[31m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
rem %1 "%~1"
rem call :LOG Logtxt
:LOG
echo ... %1[0m
echo ... %1 >> "%file_log%"
goto :eof

rem ==========
:LOGSTART
call :LOGSTR  "     " "%~1"
call :LOGFILE "%dt% --------------------------------------------------------------------------------------------------------------------"
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
rem %1 "%~1"
rem call :LOG Logtxt
:LOGSCR
if "%~2"=="" (
 echo %~1[0m
) else if not "%~2"=="" (
 echo %~2%~1[0m
)
goto :eof

rem ==========
rem %1 "%~1"
rem call :LOG Logtxt
:LOGFILE
echo "%~1" >> "%file_log%"
goto :eof

rem ==========
rem %1 "%~1"
rem %2 "%~2"
rem call :LOGSTR INFO LogStr
:LOGSTR
call :GET_DT
set dt=%mdate% %mtime%
set tlogstr1=%~1
set tlogstr2=%~2
rem echo %tlogstr%
goto :eof

rem ==========
:LOG_DT
call :LOGSTR  "     " "%~1"
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
rem get data and time
:GET_DT
set t1=%TIME:~0,1%
set mdate=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2%
if "%t1%" == " " (
 set mtime=0%TIME:~1,1%:%TIME:~3,2%:%TIME:~6,2%
) else (
 set mtime=%TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%
)
rem set dt=%mdate%-%mtime%
goto :eof

rem ==========
rem get data and time
:GET_DT1
set t1=%TIME:~0,1%
set mdate=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%
if "%t1%" == " " (
 set mtime=0%TIME:~1,1%%TIME:~3,2%%TIME:~6,2%
) else (
 set mtime=%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
)
rem set dt=%mdate%-%mtime%
goto :eof

rem ABBALibraryCmdLogEnd
