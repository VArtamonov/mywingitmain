@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0

rem echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
call :LOGLINE1
call :LOGSTART "START '%~0'"
call :LOGINFO "LOG FILE - '%file_log%'"
call :LOGINFO "’…Š“™…‰ Š€’€‹Žƒ: '%CD%'"
call :LOGINFO "‘‹“—€‰Ž… „…‘Ÿ’ˆ—Ž… —ˆ‘‹Ž: %RANDOM%"
call :LOGLINE2
call :LOGINFO  "TEST INFO  ..."
call :LOGERROR "TEST ERROR ..."

call :LOGLINE2
rem root dir
set ROOTDIR=%CD%
call :LOG "ROOTDIR = '%ROOTDIR%' ..."
CALL :CHANGEDIR "%ROOTDIR%"

if "%~1" == "help" (
 call :help %~n0
 goto :end
)


call :LOGLINE2
call :LOGINFO "®¨áª ãâ¨«¨â"
call :FINDZIP
call :FINDWGET
call :FINDRCLONE
call :FINDGIT
call :FINDGITHUBCLI

call :LOGLINE2
call :LOGINFO "ZIPEXE    = '%ZIPEXE%'"
call :LOGINFO "WGETEXE   = '%WGETEXE%'"
call :LOGINFO "RCLONEEXE = '%RCLONEEXE%'"
call :LOGINFO "GITEXE = '%GITEXE%'"
call :LOGINFO "GHEXE = '%GHEXE%'"

call :LOGLINE2
call :LOGINFO "RUN ..."

rem for %%i in ("git.exe") do set FILE1=%%~$PATH:i
rem call :LOGINFO "FILE1 = '%FILE1%'"
rem for %%i in ("gh.exe") do set FILE2=%%~$PATH:i
rem call :LOGINFO "FILE2 = '%FILE2%'"
rem for %%i in ("wget.exe") do set FILE3=%%~$PATH:i
rem call :LOGINFO "FILE3 = '%FILE3%'"
rem for %%i in ("7z.exe") do set FILE4=%%~$PATH:i
rem call :LOGINFO "FILE4 = '%FILE4%'"
rem call :FINDFILE "wget.exe" "WGETEXE1"
rem call :FINDFILE "7z.exe" "ZIPEXE1" "C:\Program Files\7-Zip"

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


if "%~1" == "" (
 call :info
 goto :end
)


if "%~1" == "info" (
 call :info
 goto :end
)


call :LOGERROR "…ˆ‡‚…‘’€Ÿ ŠŽŒ€„€ '%~1'"
goto :FAILURE


rem ABBAProgrammMainEnd1
:END
call :LOGLINE2
call :LOGDEBUG "ERRORLEVEL %ERRORLEVEL%"
call :LOGINFO "END '%~0' ..."
call :LOGLINE0
exit 0
goto :eof

rem ABBAProgrammMainEnd2
:FAILURE
call :LOGLINE2
call :LOGDEBUG "ERRORLEVEL %ERRORLEVEL%"
call :LOGERROR "END '%~0' ..."
call :LOGLINE0
exit 1
goto :eof
rem ABBAProgrammEnd

rem ==========
:help
 call :LOGLINE2
 call :LOGINFO "ˆá¯®«ì§®¢ ­¨¥: "
 call :LOGINFO "    '%~1' [ŠŽŒ€„›] [€€Œ…’] "
 call :LOGINFO " "
 call :LOGINFO "Š®¬ ­¤ë: "
 call :LOGINFO "    create folder 	- á®§¤ ­¨¥ «®ª «ì­®£® à¥¯®§¨â à¨ï ¢ ¯ ¯ª¥ folder ¢ à®¤¨â¥«ìáª®¬ ª â «®£¥ "
 call :LOGINFO "                          ª®¯¨àã¥â ¢á¥ ­¥®¡å®¤¨¬®¥, ¯®á«¥ á®§¤ ­¨ï ¢á¥ ¢ë§®¢ë ­ ¤® ¤¥« âì ¨§ folder "
 call :LOGINFO "    createmaster        - á®§¤ ­¨¥ £« ¢­®£® à¥¯®§¨â à¨ï ­  GitHub, ¤«ï åà ­¥­¨ï íâ¨å ãâ¨«¨â "
 call :LOGINFO "    createhub           - á®§¤ ­¨¥ ã¤ «¥­­®£® à¥¯®§¨â à¨ï ­  GitHub, ¤«ï åà ­¥­¨ï á®§¤ ­­®£® "
 call :LOGINFO "    remote              - ®â¯à ¢«ï¥â ¢á¥ ¨§¬¥­¥­¨ï ¢ ã¤ «¥­­ë© à¥¯®§¨â à¨ï ­  GitHub "
 call :LOGINFO "    autocommit		-  ¢â®ª®¬¬¨â ¢ â¥ªãé¥© ¤ â®© ¨ ¢à¥¬¥­¨¬ "
 call :LOGINFO "    info                - ˆ­ä®à¬ æ¨ï, ª®¬ ­¤  ¯® ã¬®«ç ­¨î "
 call :LOGINFO "    help                - ®ª § âì íâã á¯à ¢ªã ¨ ¢ë©â¨ "
 call :LOGINFO " "
goto :eof



:info
 call :LOGLINE2
 call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO "ˆ”ŽŒ€–ˆŸ"

 call :LOGDEBUG "GIT VERSION"
 "%GITEXE%" --version

 call :LOGLINE2
 call :LOGDEBUG "GITHUB VERSION"
 "%GHEXE%" --version

 call :LOGLINE2
 call :LOGDEBUG "GIT STATUS"
 "%GITEXE%" status --verbose

 echo off
 exit /b 0
goto :eof



rem ---------------------------------------------------------------------------------------
rem ABBALibraryGITStart

rem ==========
:FINDGIT
call :FINDFILE "git.exe" "GITEXE"
goto :eof


rem ==========
:FINDGITHUBCLI
call :FINDFILE "gh.exe" "GHEXE"
goto :eof

rem ABBALibraryGITEnd


rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdWgetStart
rem find wget
:FINDWGET
call :FINDFILE "wget.exe" "WGETEXE"
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
call :FINDFILE "rclone.exe" "RCLONEEXE" "D:\0_RCLONE" "Z:\0_RCLONE"
goto :eof
rem ABBALibraryCmdCloneEnd

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdZipStart
rem %1 
rem %2 FILEOUT
:FINDZIP
rem call :FINDFILE "%SystemDrive%" "7z.exe" "ZIPEXE"
call :FINDFILE "7z.exe" "ZIPEXE" "C:\Program Files\7-Zip"
goto :eof
rem ABBALibraryCmdZipEnd

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdFindStart
rem call :FINDFILE "wget.exe" "WGETEXE" "%CD%" "C:" "C:\Windows"
rem call ::FINDFILE1 %1 %2
:FINDFILE
if "%~1"=="" (
 call :LOGERROR "ARG1 = NULL"
 goto :FINDFILE2
)

if "%~2"=="" (
 call :LOGERROR "ARG2 = NULL"
 goto :FINDFILE2
)

call :LOGINFO "FIND '%~1' ..."
for %%i in ("%~1") do set %~2=%%~$PATH:i
rem echo "!%~2!"
if not "!%~2!" == "" (
 rem set %~2=!z1!
 goto :FINDFILE1
) else (
 echo off
 if not "%~3"=="" (
  for /D %%k in (%3 %4 %5 %6 %7 %8 %9) do (
   set z1=%%~k\%~1
   rem echo !z1!
   if exist !z1! (
    set %~2=!z1!
    goto :FINDFILE1
    )
   )
  )
 )

call :LOGERROR "'%~2' no found"
call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"

:FINDFILE1
call :LOG "FOUND %~2 = '!%~2!'"

:FINDFILE2
echo off
goto :eof
rem ABBALibraryFindZipEnd

rem ABBALibraryCmdDirStart
rem ==========
:CHANGEDIR
rem call :LOG "CHDIR '%~1' ..."
cd %~1
call :LOGDEBUG "CHDIR '%CD%' ..."
goto :eof

rem ==========
:CREATEDIR
call :LOG "DIR '%~1' ..."
if not exist %~1 (
 call :LOGDEBUG "CREATE dir '%~1' ..."
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
 call :LOG "CREATE DIR '%ROOTDIR%' ..."
 mkdir %projectdirname%
) else (
 call :LOG "DIR '%ROOTDIR%' ..."
)
call :LOG "ROOTDIR = '%ROOTDIR%' ..."
goto :eof

rem ==========
:CHECKDIR
call :LOGDEBUG "CHECK DIR '%~1' ..."
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
:LOG
call :LOGSTR  "     " "%~1"
call :LOGSCR  "³%dt%³%tlogstr1%³%tlogstr2%" "[37m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
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
:LOG1
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
