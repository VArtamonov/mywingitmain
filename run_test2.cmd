@echo off
chcp 1251 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0
set ret=0

call :LOGLINE0
call :LOGSTART "START '%~0'"
call :LOGINFO "Log file - '%file_log%'"
call :LOGINFO "��������� ���������� �����: %RANDOM%"

call :LOGLINE2
call :LOGINFO  "TEST INFO"
call :LOGERROR "TEST ERROR"

call :LOGLINE2
call :LOGINFO "������� �������: '%CD%'"
set ROOTDIR=%CD%
call :LOGINFO "ROOTDIR = '%ROOTDIR%'"
call :CHANGEDIR %ROOTDIR%

if "%~1" == "help" (
 call :help %~n0
 goto :end
)

call :LOGLINE2
call :LOGINFO "����� ������"
call :FINDZIP

call :FINDWGET
set filenameout=%~0
call :MAKENEWFILENAME %filenameout%
call :LOGDEBUG "Filename backup = '%filenameout1%'"
rem call :WGETLOAD "%git_path%" "%filenameout1%"

call :FINDGIT
rem "%GITEXE%" --version

call :FINDGITHUBCLI
rem "%GHEXE%" --version


if "%~1" == "" (
 call :info
 goto :end
)


if "%~1" == "info" (
 call :info
 goto :end
)

if "%~1" == "create" (
 if not "%~2" == "" (
  call :FINDGIT
  call :FINDGITHUBCLI
  call :GITCREATE %~2
 ) else (
  call :LOGERROR "ERROR ..."	
  echo Please run '%~nx0 init ^<gitname^>'
  goto :FAIL
 )
 goto :end
)

if "%~1" == "autocommint" (
 call :GITAUTOCOMMIT
 goto :end
)

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


call :LOGERROR "����������� ������� '%~1'"
goto :fail
goto :eof

:END
call :LOGLINE2
call :LOGINFO "ERRORLEVEL = '%ERRORLEVEL%'"
call :LOGINFO "END '%~0'"
call :LOGLINE0
exit /b 0
goto :eof

:FAIL
 call :LOGLINE2
 call :LOGERROR "ERRORLEVEL = '%ERRORLEVEL%'"
 call :LOGERROR "END '%~0'"
 call :LOGLINE0
 exit /b 1
goto :eof

rem ==========
:help
 call :LOGLINE2
 call :LOGINFO "�������������: "
 call :LOGINFO "    '%~1' [�������] [��������] "
 call :LOGINFO " "
 call :LOGINFO "�������: "
 call :LOGINFO "    info                - ����������, ������� �� ��������� "
 call :LOGINFO "    create folder 	- �������� ���������� ����������� � ����� folder � ������������ �������� "
 call :LOGINFO "                          �������� ��� �����������, ����� �������� ��� ������ ���� ������ �� folder "
 call :LOGINFO "    createmaster        - �������� �������� ����������� �� GitHub, ��� �������� ���� ������ "
 call :LOGINFO "    createhub           - �������� ���������� ����������� �� GitHub, ��� �������� ���������� "
 call :LOGINFO "    remote              - ���������� ��� ��������� � ��������� ����������� �� GitHub "
 call :LOGINFO "    autocommint		- ���������� � ������� ����� � �������� "
 call :LOGINFO "    info                - ����������, ������� �� ��������� "
 call :LOGINFO "    help                - �������� ��� ������� � ����� "
 call :LOGINFO " "
 rem exit /b 0
goto :eof


:info
 call :LOGLINE2
 call :LOGINFO "����������"

 call :LOGDEBUG "GIT VERSION"
 "%GITEXE%" --version

 call :LOGLINE2
 call :LOGDEBUG "GITHUB VERSION"
 "%GHEXE%" --version

 call :LOGLINE2
 call :LOGDEBUG "GIT STATUS"
 "%GITEXE%" status

 echo off
goto :eof

rem ---------------------------------------------------------------------------------------

rem ==========
:LOGLINE0
 echo +--------------------------------------------------------------------------------------------------+
goto :eof

rem ==========
:LOGLINE2
rem echo .2
 echo +----------+--------+-----+-------------------------------------------------------------------------+
goto :eof

rem ==========
:LOGSTART
 call :LOGSTR "     " %1
 call :LOGFILE "%dt%" "--------------------------------------------------------------------------------------------------------------------"
 call :LOGSCR  "%dt%" %tlogstr1% %tlogstr2% "[37m"
 call :LOGFILE "%dt%" %tlogstr1% %tlogstr2%
goto :eof

rem ==========
rem %1 "%~1"
rem %2 "%~2"
rem call :LOGSTR INFO LogStr
:LOGSTR
 call :GET_DT
 set dt=%mdate% %mtime%
 set tlogstr1=%1
 set tlogstr2=%2
 rem echo %tlogstr%
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
:LOGSCR
 rem echo %~4%~1 %~2 %~3 
 if "%~4"=="" (
  echo %~1 %~2 %~3 [0m
 ) else (
  echo %~4 %~1 %~2 %~3 [0m
 )
goto :eof

rem ==========
:LOGFILE 
 rem echo %1%2%3%4%5 
 echo %~1 %~2 %~3 >> "%file_log%"
goto :eof

rem ==========
:LOG
 call :LOGSTR "INFO " %1
 call :LOGSCR  "%dt%" %tlogstr1% %tlogstr2% "[37m"
 call :LOGFILE "%dt%" %tlogstr1% %tlogstr2%
goto :eof

rem ==========
:LOGINFO 
 call :LOGSTR "INFO " %1
 call :LOGSCR  "%dt%" %tlogstr1% %tlogstr2% "[32m"
 call :LOGFILE "%dt%" %tlogstr1% %tlogstr2%
goto :eof

rem ==========
:LOGERROR
 call :LOGSTR "ERROR" %1
 call :LOGSCR  "%dt%" %tlogstr1% %tlogstr2% "[31m"
 call :LOGFILE "%dt%" %tlogstr1% %tlogstr2%
goto :eof

rem ==========
:LOGDEBUG
 call :LOGSTR "DEBUG" %1
 call :LOGSCR  "%dt%" %tlogstr1% %tlogstr2% "[33m"
 rem call :LOGFILE %dt% %tlogstr1% %tlogstr2%
goto :eof


rem ABBALibraryFilesStart
rem ==============================================================================================

rem ==========
:FINDZIP
rem call :LOGINFO "FINFILE"
call :FINDFILE "7z.exe" "ZIPEXE" "C:" "C:\Program Files\7-Zip"
call :LOG "ZIPEXE = '%ZIPEXE%'"
goto :eof

rem ==========
:FINDFILE
 echo off
 call :LOG "FIND '%~1' ..."
 rem echo %2
 set %~2=""
 for /D %%k in (%3 %4 %5 %6 %7 %8 %9) do (
  set z1=%%~k\%~1
  rem echo !z1!
  if exist !z1! (
   set %~2=!z1!
   rem call :LOG1 "FOUND '%~2' = '!%~2!'"
   set !ret!=0
   goto :FINDFILE1
  )
 )
 echo off

 if "!%~2!" == "" (
  call :LOGERROR "'%~2' no found"
  call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
  set ret=1
 )
:FINDFILE1
 rem echo Return = '%ret%'
 echo off
 exit /b %ret%
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
 call :LOG "CREATE dir '%ROOTDIR%' ..."
 mkdir %projectdirname%
) else (
 call :LOG "DIR '%ROOTDIR%' ..."
)
call :LOG "ROOTDIR = '%ROOTDIR%' ..."
goto :eof

rem ==========
:CHECKDIR
call :LOG "CHECK DIR '%~1' ..."
if not exist "%~1" (
 call :LOGERROR "DIR '%~1' - NOT EXIST ..."
 exit /b 0
) else (
 call :LOGINFO "DIR '%~1' - OK"
exit /b 1
)
goto :eof
rem ABBALibraryFilesEnd

rem ABBALibraryCmdWgetStart
rem ==========
rem find wget
:FINDWGET
call :LOG "FIND WGET ..."
rem call :LOGINFO "Find wget.exe"
for %%i in ("%CD%\wget.exe","C:\Windows\wget.exe","C:\Program Files\GnuWin32\bin\wget.exe","C:\Program Files (x86)\GnuWin32\bin\wget.exe","C:\Windows\system32\wget.exe") do (
 rem call :LOGINFO "%%~i"
 if exist "%%~i" (
  set wgetexe=%%~i
  call :LOG "WGET.EXE = '!wgetexe!'"
  exit /b 0
  )
 )
call :LOGERROR "wget.exe no found"
exit /b 1
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