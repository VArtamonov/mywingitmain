@echo off
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0

rem echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
call :LOGLINE1
call :LOGSTART "START '%~0'"
title %~n0 - à®£à ¬¬   àå¨¢ æ¨¨ ¯à®¥ªâ®¢ ¢  àå¨¢ ...
call :LOG_DT "LOG FILE - '%file_log%'"
call :LOG_DT "’…Š“™…‰ Š€’€‹Žƒ: '%CD%'"
call :LOG_DT "‘‹“—€‰Ž… „…‘Ÿ’ˆ—Ž… —ˆ‘‹Ž: %RANDOM%"

rem call :LOGINFO  "TEST INFO  ..."
rem call :LOGERROR "TEST ERROR ..."

rem root dir
set ROOTDIR=%CD%
call :LOG_DT "ROOTDIR = '%ROOTDIR%' ..."
CALL :CHANGEDIR "%ROOTDIR%"

call :LOGLINE2
call :FINDZIP1
call :FINDWGET1
call :FINDRCLONE

call :LOGLINE2
call :LOGINFO "ZIPEXE    = '%ZIPEXE%'"
call :LOGINFO "WGETEXE   = '%WGETEXE%'"
call :LOGINFO "RCLONEEXE = '%RCLONEEXE%'"
call :LOGLINE2

call :LOGINFO "RUN ..."

rem call :CREATEDIR arc
rem set dotnetsamplelink=https://github.com/dotnet/samples/archive/refs/heads/main.zip
rem set filenamezip1=dotnetsamples.zip
rem call :WGETLOAD "%dotnetsamplelink%" "%cd%\arc\%filenamezip1%"
rem call :LOGINFO "%new_full_file_name%"
rem set arcdir=%cd%\arc
rem set new_full_file_name=%cd%\arc\dotnetsamples_20230517_085234.zip
rem call :LOGINFO "UNZIP '%new_full_file_name%' ..." 
rem "%ZIPEXE%" x -y -bb3 -bsp2 -o%arcdir% -- "%new_full_file_name%" 1>> "%file_log%"
rem echo on
rem "%ZIPEXE%" x -y -bb3 -bsp2 -o"%arcdir%" -- "%new_full_file_name%" 1>> "%file_log%"
rem echo off

call :LOGLINE2

rem ABBAProgrammMainEnd1
:END
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
call :LOG_DT "END '%~0' ..."
call :LOGLINE0
exit 0
goto :eof

rem ABBAProgrammMainEnd2
:FAILURE
call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
call :LOGERROR "END '%~0' ..."
call :LOGLINE0
exit 1
goto :eof
rem ABBAProgrammEnd


rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdWgetStart
rem find wget
rem find wget
:FINDWGET
call :LOGINFO "FIND WGET ..."
call :FINDFILE "" "wget.exe" "WGETEXE"
goto :eof

:FINDWGET1
call :LOGINFO "FIND WGET ..."
rem call :LOG "Find wget.exe"
for %%i in ("%CD%\wget.exe","C:\Windows\wget.exe","C:\Program Files\GnuWin32\bin\wget.exe","C:\Program Files (x86)\GnuWin32\bin\wget.exe","C:\Windows\system32\wget.exe") do (
 rem call :LOGINFO "%%~i"
 if exist "%%~i" (
  set wgetexe=%%~i
  call :LOG_DT "WGET.EXE = '!wgetexe!'"
  goto :eof
  )
 )
  call :LOGERROR "wget.exe no found"
  call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
  goto :FAILURE
rem )
goto :eof

rem ==========
rem %1 URL
rem %2 FILEOUT
rem %3 DIROUT
:WGETLOAD
rem call :LOGDEBUG "WGET LOAD '%~1' to '%~2' ..."
call :GET_DT1
rem echo %file_name_dt%
set new_file_name=%~n2_%file_name_dt%%~x2
rem %wgetexe% --verbose --show-progress "https://downloads.rclone.org/version.txt" --append-output="%file_log%" --output-document="%rclonecurrent_version%"
rem %wgetexe% --verbose --show-progress --hsts-file=wget-hsts.txt --save-cookies=wget-cookies.txt --load-cookies=wget-cookies.txt --keep-session-cookies "%git_path%" --output-document="%DIRPREFIX%\%new_file_name%" --append-output="%file_log%"

set new_full_file_name=%~dp2%new_file_name%
call :LOGDEBUG "WGET LOAD '%~1' to"
call :LOGDEBUG "'%new_full_file_name%'"
%wgetexe% --verbose --show-progress --hsts-file=wget-hsts.txt --save-cookies=wget-cookies.txt --load-cookies=wget-cookies.txt --keep-session-cookies "%~1" --append-output="%file_log%" --output-document="%new_full_file_name%"

goto :eof
rem ABBALibraryCmdWgetEnd

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdCloneStart
:FINDRCLONE
call :LOGINFO "FIND RCLONE ..."
for %%i in ("rclone.exe","..\rclone.exe","D:\0_RCLONE\rclone.exe") do (
 rem call :LOGINFO "%%~i"
 if exist "%%~i" (
  set rcloneexe=%%~i
  call :LOG_DT "RCLONE.EXE = '!RCLONEEXE!'"
  goto :eof
 )
)
rem ) else (
rem   call :LOGERROR "RCLONE.exe no found"
rem   call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
rem   goto :FAILURE
rem )
goto :eof
rem ABBALibraryCmdCloneEnd

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdZipStart
rem %1 
rem %2 FILEOUT
:FINDZIP
rem call :FINDFILE "%SystemDrive%" "7z.exe" "ZIPEXE"
call :FINDFILE "" "7z.exe" "ZIPEXE"
goto :eof
rem ABBALibraryCmdZipEnd

:FINDZIP1
call :LOGINFO "FIND 7ZIP ..."
rem call :LOG "Find wget.exe"
for %%i in ("%CD%\7z.exe","%CD%\7za.exe","C:\Program Files\7-Zip\7z.exe") do (
 rem call :LOGINFO "%%~i"
 if exist "%%~i" (
  set ZIPEXE=%%~i
  call :LOG_DT "7Z.EXE = '!ZIPEXE!'"
  goto :eof
  )
 )
  call :LOGERROR "7ZIP NO FOUND"
  call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
  goto :FAILURE
rem )
goto :eof


rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdFindStart
rem %1 
rem %2
rem %3
:FINDFILE
if "%~1"=="" (
 set findpath=%SystemDrive%\
) else (
 set findpath=%~1\
)
call :LOGINFO "FIND '%~2' in '%findpath%'..."
for /r "%findpath%" %%I in (%~2) do (
 rem call :LOGINFO "%%~I"
 rem echo "%%~I"
 if exist "%%~I" (
  set %~3=%%~I
  call :LOG_DT "FOUND %~3='!%~3!'"
  goto :eof
 )
)
rem ) else (
call :LOGERROR "'%~2' no found"
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
goto :FAILURE
goto :eof
rem ABBALibraryFindZipEnd

rem ABBALibraryCmdDirStart
rem ==========
:CHANGEDIR
rem call :LOG_DT "CHDIR '%~1' ..."
cd %~1
call :LOG_DT "CHDIR '%CD%' ..."
goto :eof

rem ==========
:CREATEDIR
call :LOG_DT "DIR '%~1' ..."
if not exist %~1 (
 call :LOG_DT "CREATE dir '%~1' ..."
 mkdir %~1
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
if not exist %~1 (
 call :LOGERROR "DIR '%~1' - NOT EXIST ..."
) else (
 call :LOGINFO "DIR '%~1' - OK"
)
goto :eof
rem ABBALibraryCmdDirEnd

rem ABBALibraryCmdLogStart
rem ==========
:LOGLINE0
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
goto :eof

:LOGLINE1
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
goto :eof

:LOGLINE2
echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
goto :eof

rem ==========
:LOGINFO
call :LOGSTR  "INFO " "%~1"
call :LOGSCR  "³%dt%³%tlogstr1%³%tlogstr2%" "[32m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGDEBUG
call :LOGSTR  "DEBUG" "%~1"
call :LOGSCR  "³%dt%³%tlogstr1%³%tlogstr2%" "[33m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGERROR
call :LOGSTR  "ERROR" "%~1"
call :LOGSCR  "³%dt%³%tlogstr1%³%tlogstr2%" "[31m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"

goto :eof

rem %1 "%~1"
rem call :LOG Logtxt
:LOG
echo ... %1[0m
echo ... %1 >> "%file_log%"
goto :eof

rem %1 "%~1"
rem call :LOG Logtxt
:LOGSCR
if "%~2"=="" (
echo %~1[0m
) else if not "%~2"=="" (
echo %~2%~1[0m
)
goto :eof

rem %1 "%~1"
rem call :LOG Logtxt
:LOGFILE
echo %~1 >> "%file_log%"
goto :eof

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

:GET_DT1
set t1=%TIME:~0,1%
if "%t1%" == " " (
 set file_name_dt=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_0%TIME:~1,1%%TIME:~3,2%%TIME:~6,2%
) else (
 set file_name_dt=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
)
goto :eof

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

:LOG_DT
call :LOGSTR  "     " "%~1"
call :LOGSCR  "³%dt%³%tlogstr1%³%tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

:LOGSTART
call :LOGSTR  "     " "%~1"
call :LOGFILE "%dt% --------------------------------------------------------------------------------------------------------------------"
call :LOGSCR  "³%dt%³%tlogstr1%³%tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ABBALibraryCmdLogEnd
goto :eof
