@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0

if "%2"=="" (
 set file_log=%~dp0%~n0.log
 rem set file_name=%~n0
) else (
 set file_log=%~2
 rem set file_name=%~n2
)

@echo off
:parse
if "%~1"=="" goto endparse
if "%~1"=="-install" ( echo . Install )

rem if "%~1"=="-b" rem do something else
shift
goto parse
:endparse
rem ready for action!
@echo off

rem ---------------------------------------------------------------------------------------
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

if "%~1" == "" (
 call :info
 goto :end
)

if "%~1" == "info" (
 call :info
 goto :end
)

call :LOGLINE2
call :LOGINFO "Žˆ‘Š “’ˆ‹ˆ’"

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
 call :LOGINFO "    create folder       - á®§¤ ­¨¥ «®ª «ì­®£® à¥¯®§¨â à¨ï ¢ ª â «®£¥ folder"
 call :LOGINFO "                          ¢ ª â «®£ ª®¯¨àã¥â ¢á¥ ­¥®¡å®¤¨¬®¥, ¯®á«¥ á®§¤ ­¨ï ¢á¥ ¢ë§®¢ë ­ ¤® ¤¥« âì ¨§ folder "
 call :LOGINFO "    createmaster        - á®§¤ ­¨¥ £« ¢­®£® à¥¯®§¨â à¨ï ­  GitHub, ¤«ï åà ­¥­¨ï íâ¨å ãâ¨«¨â "
 call :LOGINFO " "
 call :LOGINFO "    info                - ˆ­ä®à¬ æ¨ï, ª®¬ ­¤  ¯® ã¬®«ç ­¨î "
 call :LOGINFO "    help                - ®ª § âì íâã á¯à ¢ªã ¨ ¢ë©â¨ "
 call :LOGINFO " "
goto :eof

:info
 call :LOGLINE2
 rem call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO "ˆ”ŽŒ€–ˆŸ"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ---------------------------------------------------------------------------------------

rem ABBALibraryCMDStart

rem ==========
:CMDTEST1
 call :LOGLINE2
 call :LOGINFO "CMDTEST1"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"


 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ABBALibraryCMDEnd


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

