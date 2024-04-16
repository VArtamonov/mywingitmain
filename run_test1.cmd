@echo off
chcp 1251 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0

call :LOGLINE1
call :LOGSTART "START '%~0'"
call :LOGINFO "Log file - '%file_log%'"
call :LOGINFO "Текущей каталог: '%CD%'"
call :LOGINFO "Случайное десятичное число: %RANDOM%"

call :LOGLINE2
call :LOGINFO  "TEST INFO  ..."
call :LOGERROR "TEST ERROR ..."


call :LOGLINE2
rem root dir
rem set ROOTDIR=%CD%
rem call :LOGINFO "TEST"
rem call :LOGINFO "ROOTDIR = '%ROOTDIR%' ..."
rem call :CHANGEDIR %ROOTDIR%

call :LOGLINE2
call :LOGINFO "Поиск утилит"

call :FINDZIP

call :FINDWGET

rem set filenameout=%~0
rem call :MAKENEWFILENAME %filenameout%
rem call :LOGDEBUG "Filename backup = '%filenameout1%'"
rem call :WGETLOAD "%git_path%" "%filenameout1%"

rem call :FINDGIT
rem "%GITEXE%" --version

rem call :FINDGITHUBCLI
rem "%GHEXE%" --version

call :LOGLINE2
if "%~1" == "" (
call :info
)

rem if "%~1" == "info" goto :info
rem if "%~1" == "help" goto :help

goto :end

:END
call :LOGLINE2
call :LOGINFO "ERRORLEVEL %ERRORLEVEL%"
call :LOGINFO "END '%~0' ..."
call :LOGLINE0
exit /b 0
goto :eof

:FAILURE
call :LOGLINE2
call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
call :LOGERROR "END '%~0' ..."
call :LOGLINE0
exit /b /1
goto :eof


:info
echo .
echo off
goto :eof

:help
 rem ==============================================================================================

 rem call :LOGLINE2
 call :LOGINFO "Использование:"
 call :LOGINFO "    '%~0' [КОМАНДЫ] [ПАРАМЕТР] ..."
 call :LOGINFO " "
 call :LOGINFO "Команды:"
 call :LOGINFO "    info                - Информация, команда по умолчанию"
 call :LOGINFO "    create folder 	- создание локального репозитария в папке folder в родительском каталоге"
 call :LOGINFO "                          копирует все необходимое, после создания все вызовы надо делать из folder"
 call :LOGINFO "    createmaster        - создание главного репозитария на GitHub, для хранения этих утилит"
 call :LOGINFO "    createhub           - создание удаленного репозитария на GitHub, для хранения созданного"
 call :LOGINFO "    remote              - отправляет все изменения в удаленный репозитария на GitHub"
 call :LOGINFO "    autocommint		- автокоммит в текущей датой и временим"
 call :LOGINFO " "
 call :LOGINFO "    info                - Информация, команда по умолчанию"
 call :LOGINFO "    help                - Показать эту справку и выйти"
 call :LOGINFO " "

 rem call :LOGLINE2
goto :eof

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdWgetStart

rem ==========
rem find wget
:FINDWGET
call :LOGINFO "FIND WGET ..."
rem call :LOG "Find wget.exe"
for %%i in ("%CD%\wget.exe","C:\Windows\wget.exe","C:\Program Files\GnuWin32\bin\wget.exe","C:\Program Files (x86)\GnuWin32\bin\wget.exe","C:\Windows\system32\wget.exe") do (
 rem call :LOGINFO "%%~i"
 if exist "%%~i" (
  set wgetexe=%%~i
  call :LOG_DT "WGET.EXE = '!wgetexe!'"
  exit /b 0
  )
 )
  call :LOGERROR "wget.exe no found"
  call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
  exit /b 1
rem )
goto :eof

rem ==========
rem %1 URL
rem %2 FILEOUT
:WGETLOAD
echo off
call :LOGDEBUG "WGET LOAD '%~1' to '%~2' ..."

if "%~1"=="" (
 call :LOGERROR "WGETLOAD 1"
 exit /b 1
)

if "%~2"=="" (
 call :LOGERROR "WGETLOAD 2"
 exit /b 1
)

 rem %wgetexe% --verbose --show-progress "https://downloads.rclone.org/version.txt" --append-output="%file_log%" --output-document="%rclonecurrent_version%"
 "%wgetexe%" --verbose --show-progress --hsts-file=wget.hsts.txt --save-cookies=wget.cookies.txt --load-cookies=wget.cookies.txt --keep-session-cookies "%~1" --append-output="%file_log%" --output-document="%~2"

goto :eof

:MAKENEWFILENAME
rem ==========
rem %1 FILENAME
call :GET_DT1
rem echo mdate='!mdate!'
rem echo mtime='!mtime!'
set filenameout1=%~n1_!mdate!!mtime!%~x1
goto :eof

rem ABBALibraryCmdWgetEnd


rem ABBALibraryFilesStart
rem ==============================================================================================

rem ==========
:FINDZIP
rem call :LOGINFO "FINFILE"
call :FINDFILE "7z.exe" "ZIPEXE" "C:" "C:\Program Files\7-Zip"
call :LOGINFO  "ZIPEXE = '%ZIPEXE%'"
goto :eof

rem ==========
:FINDFILE
call :LOGINFO "FIND '%~1' ..."
echo off
for /D %%k in (%3 %4 %5 %6 %7 %8 %9) do (
 set z1=%%~k\%~1
 rem echo !z1!
 if exist !z1! (
   set %~2=!z1!
   call :LOG "FOUND %~1 = '!%~2!'"
   exit /b 0
 )
)
call :LOGERROR "'%~2' no found"
call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
exit /b 1
goto :eof

rem ==========
:CHANGEDIR
rem call :LOG_DT "CHDIR '%~1' ..."
cd "%~1"
call :LOG "CHDIR '%CD%' ..."
goto :eof

rem ==========
:CREATEDIR
call :LOG "DIR '%~1' ..."
if not exist %~1 (
call :LOG "CREATE dir '%~1' ..."
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
echo ----------------------------------------------------------------------------------------------------
goto :eof

rem ==========
:LOGLINE1
echo ----------------------------------------------------------------------------------------------------
goto :eof

rem ==========
:LOGLINE2
rem echo .2
echo ----------------------------------------------------------------------------------------------------
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
goto :eof

rem ==========
:LOG
call :LOGSTR "     " "%~1"
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
:LOGSTART
call :LOGSTR  "     " "%~1"
call :LOGFILE "%dt% --------------------------------------------------------------------------------------------------------------------"
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ABBALibraryCmdLogEnd

goto :eof
