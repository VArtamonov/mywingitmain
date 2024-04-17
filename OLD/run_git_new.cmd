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

call :LOGLINE2
call :READINIFILE1 !file_name!

call :LOGLINE2
call :LOGINFO "Поиск утилит ..."

call :FINDZIP

call :FINDWGET
rem set filenameout=%~0
rem call :MAKENEWFILENAME %filenameout%
rem call :LOGDEBUG "Filename backup = '%filenameout1%'"
rem call :WGETLOAD "%git_path%" "%filenameout1%"

call :FINDGIT
rem "%GITEXE%" --version

call :FINDGITHUBCLI
rem "%GHEXE%" --version


rem set ENVROOTDIR=%CD%
rem call :CHANGEDIR %ENVROOTDIR%
rem set PIPEXE=%ENVROOTDIR%\.venv\Scripts\pip.exe
rem set PYTHONEXE=%ENVROOTDIR%\.venv\Scripts\python.exe
rem call :LOGINFO "ENVROOTDIR = '%ENVROOTDIR%'"
rem call :LOGINFO "PIPEXE     = '%PIPEXE%'"
rem call :LOGINFO "PYTHONEXE  = '%PYTHONEXE%'"


call :LOGLINE2

rem echo .
rem call %ROOTDIR%\.venv\Scripts\activate.bat 

if "%~1" == "" goto :info
if "%~1" == "info" goto :info
if "%~1" == "help" goto :help
if "%~1" == "check" goto :check
if "%~1" == "create" goto :create
if "%~1" == "autocommint" goto :autocommint

if "%~1" == "createmaster" (
 call :GITCREATE master
 call :GITREMOTE
 goto :end
)

if "%~1" == "createhub" (
 call :GITCREATEHUB
 goto :end
)

if "%~1" == "remote" (
 call :GITREMOTE
 goto :end
)

goto :help

:check
echo .
call :GITCHECK
echo .
goto :end


:create
if "%~1" == "create" (
 if not "%~2" == "" (

 call :FINDGIT
 call :FINDGITHUBCLI
 call :GITCREATE %~2
 
 ) else (
 call :LOGERROR "ERROR ..."	
 echo Please run '%~nx0 init ^<gitname^>'
 goto :end
 )
)
echo .
goto :end


:autocommint
 call :GITAUTOCOMMIT
 echo .
goto :end

:info
 call :LOGINFO "INFO:"
 echo .
 "%GITEXE%" --version

 echo .
 "%GHEXE%" --version

 echo .
 "%GITEXE%" status

 echo .
goto :end


:help
 rem ==============================================================================================

 rem call :LOGLINE2
 call :LOGINFO "я¬-споя¬-ьзоя¬-я¬-я¬-я¬-я¬-:"
 call :LOGINFO "    '%~0' [я¬-я¬-я¬-я¬-я¬-я¬-я¬-] [я¬-я¬-я¬-я¬-я¬-я¬-я¬-я¬-я¬-] ..."
 call :LOGINFO " "
 call :LOGINFO "я¬-я¬-щие я¬-я¬-рамя¬-я¬-я¬-я¬-:"
 call :LOGINFO "    help                - я¬-я¬-я¬-я¬-я¬-я¬-я¬-я¬- я¬-я¬-я¬- я¬-равя¬-я¬- я¬- я¬-я¬-я¬-"
 call :LOGINFO "    create folder       - созя¬-я¬-я¬-я¬-я¬- я¬-я¬-я¬-я¬-я¬-ьноя¬-я¬- репя¬-я¬-я¬-я¬-я¬-я¬- я¬- я¬-я¬-я¬-я¬-я¬- folder (я¬- родя¬-теля¬-скоя¬- я¬-я¬-таля¬-я¬-я¬-"
 call :LOGINFO "                          я¬-я¬-я¬-я¬-я¬-я¬-я¬- я¬-я¬- я¬-я¬-я¬-я¬-ходя¬-я¬-я¬-я¬-, я¬-я¬-сле созя¬-я¬-я¬-я¬-я¬- я¬-я¬- я¬-ызоя¬-я¬- я¬-я¬-я¬-я¬- я¬-я¬-я¬-я¬-я¬-я¬- я¬-я¬- folder"
 call :LOGINFO "    createmaster        - созя¬-я¬-я¬-я¬-я¬- я¬-я¬-я¬-я¬-я¬-я¬-я¬-я¬- репя¬-я¬-я¬-я¬-я¬-я¬- я¬-я¬- GitHub, я¬-я¬-я¬- я¬-раня¬-я¬-я¬-я¬- я¬-я¬-я¬- я¬-тиля¬-я¬-"
 call :LOGINFO "    createhub           - созя¬-я¬-я¬-я¬-я¬- удая¬-я¬-я¬-я¬-я¬-я¬-я¬- репя¬-я¬-я¬-я¬-я¬-я¬- я¬-я¬- GitHub, я¬-я¬-я¬- я¬-раня¬-я¬-я¬-я¬- созя¬-я¬-я¬-я¬-я¬-я¬-я¬- "
 call :LOGINFO "    remote              - я¬-я¬-равя¬-я¬-я¬- я¬-я¬- я¬-я¬-я¬-я¬-я¬-я¬-я¬-я¬-я¬- я¬- удая¬-я¬-я¬-я¬-я¬- репя¬-я¬-я¬-я¬-я¬-я¬- я¬-я¬- GitHub"
 call :LOGINFO "    autocommint         - я¬-я¬-я¬- я¬-я¬-рамя¬-я¬-ров я¬-я¬-я¬-я¬-я¬-я¬- я¬-я¬-токя¬-я¬-я¬-я¬-я¬- я¬- текя¬-щей я¬-я¬-той я¬- я¬-ремя¬-я¬-я¬-я¬-"
 call :LOGINFO "                        - я¬-я¬-я¬- я¬-я¬-рамя¬-я¬-ров я¬-ывоя¬-я¬-я¬- я¬-я¬-я¬-рмая¬-я¬-"
 call :LOGINFO " "

 rem call :LOGLINE2

goto :end

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

rem ========== Read SET from ini file ==========
:READINIFILE1
rem Read config file
call :LOGINFO "Read config file ..."
set MYINI=%~1.ini
if exist !MYINI! (
 call :LOG_DT "CONFIG = !MYINI! ..."
 for /F "usebackq eol=; tokens=1,2 delims=, " %%a in (!MYINI!) do (
  set %%a=%%b
  if "%%a" == "UserName" (
   set USERNAME=%%b
   call :LOG_DT "USERNAME= '!USERNAME!' ..." 
   ) else (
   call :LOG_DT "%%a = '%%b' ..."
   )
  )
 ) else (
  call :LOGERROR "Config file !MYINI! no found ..."
  goto :FAILURE
  )
goto :eof


rem ABBALibraryGITStart
rem ==============================================================================================

rem ==========
:GITCHECK
call :LOGINFO "CHECK: GIT repositories ..."
set CDIR=%CD%..
call :LOG "CDIR=%CDIR%"
if exist ".git" (
 call :LOGINFO "GIT EXIST - OK ..."
 rem "%GITEXE%" status
 call :LOG "ERRORLEVEL %ERRORLEVEL%"
 exit /b 1
) else (
 call :LOGERROR "ERROR: no GIT repositories"
 echo [34mPlease run '%~nx0 init ^<gitname^>'[0m
 goto :FAILURE
)
goto :eof


rem ==========
:FINDGIT
call :LOGINFO "FIND GIT ..."
FOR %%i IN ("git.exe") DO SET GITEXE=%%~$PATH:i
IF EXIST "!GITEXE!" (
	call :LOG "GIT.EXE = '!GITEXE!'"
	goto :eof
) else (
call :LOGERROR "Git.exe no found"
call :LOG "ERRORLEVEL %ERRORLEVEL%"
goto :FAILURE
)
goto :eof

rem ==========
:FINDGITHUBCLI
call :LOGINFO "FIND GITHUBCLI ..."
for %%i in ("gh.exe", "C:\Program Files (x86)\GitHub CLI\gh.exe", "C:\Program Files\GitHub CLI\gh.exe") do (
rem echo File '%%~i'
if exist "%%~i" (
 set GHEXE=%%~i
 call :LOG "GH.EXE = '!GHEXE!'"
 goto :eof
 rem  ) else (
 rem  call :LOG_DT "%%i no found"
 )
)
call :LOGERROR "GitHubCli no found"
call :LOG "ERRORLEVEL %ERRORLEVEL%"
goto :FAILURE

goto :eof


rem - GIT Command

rem ==========
:GITCREATE
if "%~1" == "master" (
call :LOGINFO "CREATE MASTER ..."
call :LOGINFO "COPY FILES ..."
for %%I in ( "LICENSE.md", "README.md", ".gitignore ", "run_git.cmd" ) do (
	echo File %%~I
	if not exist "%%~I" (
		copy "..\%%~I" "%%~I"
		)
	)

) else (
echo ==========================================================================================
call :CHANGEDIR ..
call :LOGINFO "CREATE REPO 'mywingit%~1' ..."
call :LOGINFO "INIT GIT 'mywingit%~1' ..."
"%GITEXE%" init "mywingit%~1"
set MCD=!CD!
call :LOG_DT !MCD!
set RDIR=!MCD!\mywingit%~1
call :LOG_DT "DIR REPO '!RDIR!' ..."
call :CHANGEDIR "%ROOTDIR%"
call :LOG_DT "COPY FILES ..."
for %%I in ( "CopyFiles\LICENSE.md", "CopyFiles\README.md", "CopyFiles\.gitignore ", "run_git.cmd" ) do (
	rem echo File %%~I
	if exist "%%~I" (
		call :LOG_DT "COPY '%%~I' to '!RDIR!\%%~nxI' ..."
		copy %%~I "!RDIR!\%%~nxI"
		)
	)
)

call :CHANGEDIR %RDIR%

"%GITEXE%" add .
"%GITEXE%" commit -m "first commit"
"%GITEXE%" branch -M master
"%GITEXE%" remote add origin https://github.com/!USERNAME!/mywingit%~1.git

call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
goto :eof

rem ==========
:GITAUTOCOMMIT
echo ==========================================================================================
call :LOGINFO "ADD ALL FILES ..."
"%GITEXE%" add .

call :LOGINFO "ADD AUTO COMMIT ..."
call :GET_DT
call :LOGINFO "Create timestamp %dt%"
"%GITEXE%" commit -a -m "Auto commit '%dt%'"

call :LOG_DT "GIT STATUS ..."
"%GITEXE%" status
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
goto :eof

rem ==========
:GITREMOTE
echo ==========================================================================================
call :LOGINFO "GIT PUSH REMOTE ..."
"%GHEXE%" auth status
"%GITEXE%" push -u origin master
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
goto :eof


rem ==========
:GITCREATEHUB
call :LOGINFO "Create remote repo on GitHub"
rem "%GHEXE%" auth login --web
"%GHEXE%" auth status
rem "%GHEXE%" repo create --public --description "My Repo 'mywingit%~1'" -y
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
goto :eof


rem ABBALibraryGITEnd


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
:WGETLOAD
echo off
call :LOGDEBUG "WGET LOAD '%~1' to '%~2' ..."

if "%~1"=="" (
 call :LOGERROR "WGETLOAD 1"
 goto :eof
)

if "%~2"=="" (
 call :LOGERROR "WGETLOAD 2"
 goto :eof
)

 rem %wgetexe% --verbose --show-progress "https://downloads.rclone.org/version.txt" --append-output="%file_log%" --output-document="%rclonecurrent_version%"
 "%wgetexe%" --verbose --show-progress --hsts-file=wget.hsts.txt --save-cookies=wget.cookies.txt --load-cookies=wget.cookies.txt --keep-session-cookies "%~1" --append-output="%file_log%" --output-document="%~2"


echo off
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



rem ABBALibraryCmdLogStart
rem ==============================================================================================

:LOGLINE0
echo ====================================================================================================
goto :eof

:LOGLINE1
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
goto :eof

:LOGLINE2
echo ----------------------------------------------------------------------------------------------------
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

rem %1 "%~1"
rem call :LOG Logtxt
:LOG
echo ... %1[0m
echo ... %1 >> "%file_log%"
goto :eof

rem %1 "%~1"
rem call :LOG Logtxt
:LOGSCR
echo off
if "%~2"=="" (
 echo %~1[0m
) else if not "%~2"=="" (
 echo %~2%~1[0m
)
echo off
goto :eof

rem %1 "%~1"
rem call :LOG Logtxt
:LOGFILE
echo "%~1" >> "%file_log%"
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
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

:LOGSTART
call :LOGSTR  "     " "%~1"
call :LOGFILE "%dt% --------------------------------------------------------------------------------------------------------------------"
call :LOGSCR  "%dt% %tlogstr1% %tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
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
