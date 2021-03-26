@echo off
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

rem if "%~1" == "" goto help
rem if "%~2" == "" goto help
if "%~1" == "help" (
	:help
	echo ...
	echo Please use %~nx0 ^<url^> ^<nametosave^> ^<namelogfile^>
	echo ...
	exit 0
	goto end
)

set file_log=%~dp0%~n0.log
call :LOG_DT "..."
call :LOG_DT "Logging to file - %file_log%"
call :LOG_DT "... START %0"

rem root dir
set ROOTDIR=%CD%
call :LOG_DT "ROOTDIR = '%ROOTDIR%' ..."
CALL :CHANGEDIR %ROOTDIR%

set MYINI=%~dp0%~n0.ini
if exist !MYINI! (
call :LOG_DT "CONFIG = !MYINI! ..."
FOR /F "eol=; tokens=1,2 delims=: " %%a in (!MYINI!) do (
rem echo %%a %%b
if "%%a" == "UserName" (
set USERNAME=%%b
call :LOG_DT "USERNAME= '!USERNAME!' ..."
) else ( 
call :LOGERROR "Config file !MYINI! bad ..."
goto :FAILURE
)
)
) else (
call :LOGERROR "Config file !MYINI! no found ..."
goto :FAILURE
)

call :FINDGIT
rem "%GITEXE%" --version

call :FINDGITHUBCLI
rem "%GHEXE%" --version

if "%~1" == "init" (
 if not "%~2" == "" (

 call :FINDGIT
 call :FINDGITHUBCLI
 call :GITINIT %~2
 
 ) else (
 call :LOG_DT "ERROR ..."	
 echo Please run '%~nx0 init ^<gitname^>'
 goto :end
 )
)

rem -----
if "%~1" == "master" (
call :GITINIT master
call :GITREMOTE
goto :end
)

call :CHECKGIT

if "%~1" == "remote" (
call :GITREMOTE
goto :end
)

if "%~1" == "create" (
call :GITCREATE
goto :end
)

call :GITAUTOCOMMIT

:END
:FAILURE
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
call :LOG_DT "END %0 ..."
exit 0
goto :eof

rem ---------------------------------------------------------------------------------------

:CHECKGIT
set CDIR=%CD%..
call :LOG_DT "[33mCDIR=%CDIR%"
call :LOG_DT "[32mCHECK: GIT repositories ..."
if exist ".git" (
call :LOG_DT "GIT EXIST - OK ..."
rem "%GITEXE%" status
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
) else (
call :LOGERROR "ERROR: no GIT repositories"
echo [34mPlease run '%~nx0 init ^<gitname^>'[0m
goto :FAILURE
)
goto :eof

rem ==========
:FINDGIT
call :LOG_DT "FIND GIT ..."
FOR %%i IN ("git.exe") DO SET GITEXE=%%~$PATH:i
IF EXIST "!GITEXE!" (
	call :LOG_DT "GIT.EXE = '!GITEXE!'"
	goto :eof
) else (
call :LOGERROR "Git.exe no found"
goto :FAILURE
)
goto :eof

rem ==========
:FINDGITHUBCLI
call :LOG_DT "FIND GITHUBCLI ..."
for %%i in ("gh.exe", "C:\Program Files (x86)\GitHub CLI\gh.exe", "C:\Program Files\GitHub CLI\gh.exe") do (
rem echo File '%%~i'
if exist "%%~i" (
 set GHEXE=%%~i
 call :LOG_DT "GH.EXE = '!GHEXE!'"
 goto :eof
 rem  ) else (
 rem  call :LOG_DT "%%i no found"
 )
)
call :LOGERROR "GitHubCli no found"
goto :FAILURE
goto :eof

rem ==========
:GITINIT
if "%~1" == "master" (
call :LOG_DT "CREATE MASTER ..."
call :LOG_DT "COPY FILES ..."
for %%I in ( "LICENSE.md", "README.md", ".gitignore ", "run_git.cmd" ) do (
	echo File %%~I
	if not exist "%%~I" (
		copy "..\%%~I" "%%~I"
		)
	)

) else (
echo [33m==========================================================================================
call :CHANGEDIR ..
call :LOG_DT "CREATE REPO 'mywingit%~1' ..."
call :LOG_DT "INIT GIT 'mywingit%~1' ..."
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
call :LOG_DT "[34mADD ALL FILES ..."
"%GITEXE%" add .

call :LOG_DT "ADD AUTO COMMIT ..."
call :GET_DT
call :LOG_DT "Create timestamp %dt%"
"%GITEXE%" commit -a -m "Auto commit '%dt%'"

call :LOG_DT "GIT STATUS ..."
"%GITEXE%" status
goto :eof

rem ==========
:GITREMOTE
call :LOG_DT "GIT PUSH REMOTE ..."
"%GITEXE%" push -u origin master
goto :eof


rem ==========
:GITCREATE
call :LOG_DT "Create remote repo on GitHub"
rem "%GHEXE%" auth login --web
"%GHEXE%" auth status
rem "%GHEXE%" repo create --public --description "My Repo 'mywingit%~1'" -y
call :LOG_DT "ERRORLEVEL %ERRORLEVEL%"
goto :eof



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
rem %1 "%~1"
rem call :LOG Logtxt
:LOG
echo %~1
echo %~1 >> %file_log%
goto :eof

:LOGERROR
call :LOG_DT [31m%1
goto :eof

rem ==========
:LOG_DT
rem echo [37m
set t1=%TIME:~0,1%
if "%t1%" == " " (
 set dt=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2% 0%TIME:~1,1%:%TIME:~3,2%:%TIME:~6,2%
) else (
 set dt=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%
)
echo %dt% %~1[0m
echo %dt% %~1 >> %file_log%
goto :eof

rem ==========
:GET_DT
set t1=%TIME:~0,1%
set mdate=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2%
if "%t1%" == " " (
 set mtime=0%TIME:~1,1%:%TIME:~3,2%:%TIME:~6,2%
) else (
 set mtime=%TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%
)
set dt='%mdate% %mtime%'
goto :eof
