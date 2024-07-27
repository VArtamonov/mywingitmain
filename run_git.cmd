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

call :LOGLINE2
call :LOGINFO "Žˆ‘Š “’ˆ‹ˆ’"
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


set mygitini=.mygitini

if "%~1" == "createini2" goto CREATEFILEINI
if "%~1" == "createini" goto CREATEFILEINI
goto GOREADINIFILE

:CREATEFILEINI
call :LOGLINE2
if "%~1" == "createini" (
 set file_name_ini=%mygitini%
)

if "%~1" == "createini2" (
 set file_name_ini=!file_name!.ini
)

call :LOGDEBUG "‘Ž‡„€ˆ… ”€‰‹ '%file_name_ini%'"
call :GITGETCONFIG
call :LOGDEBUG "‚‚…„ˆ’… €‡‚€ˆ… …Ž‡ˆ’€ˆŸ:"
set /p REPONAME=
call :LOGDEBUG "REPONAME = !REPONAME!"
call :LOGDEBUG "‡€ˆ‘œ ‚ ”€‰‹ '%file_name_ini%'"

echo ; > %file_name_ini%
echo ; >> %file_name_ini%
echo USERNAME,!USERNAME! >> %file_name_ini%
echo USEREMAIL,!USEREMAIL! >> %file_name_ini%
echo REPONAME,!REPONAME! >> %file_name_ini%
echo BRANCHNAME,test  >> %file_name_ini%
echo BRANCHNUMBER,1  >> %file_name_ini%

goto :end

:GOREADINIFILE
call :LOGLINE2
call :LOGDEBUG "Ž‚…Š€ '%mygitini%'"
if exist %mygitini% (
 call :LOGDEBUG "‡€ƒ“‡Š€ ŠŽ”ˆƒ€ ˆ‡ '%mygitini%'"
 call :READINIFILE2 %mygitini%
 if "%ERRORLEVEL%"=="0" (
  goto READINIFILEOK
 )
) 

call :LOGDEBUG "Ž‚…Š€ '!file_name!.ini'"
if exist !file_name!.ini (
 call :LOGDEBUG "‡€ƒ“‡Š€ ŠŽ”ˆƒ€ ˆ‡ '!file_name!.ini'"
 call :READINIFILE !file_name!
 if "%ERRORLEVEL%"=="0" (
  goto READINIFILEOK
 )
)

call :LOGLINE2
rem call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
call :LOGDEBUG "…Ž•Ž„ˆŒŽ ‘Ž‡„€’œ ”€‰‹ '!file_name!.ini'"
call :LOGDEBUG "ˆ‡ ŠŽ”ˆƒ“€–ˆˆ GIT GLOBAL"
call :GITGETCONFIG
call :LOGDEBUG "ˆ‘Ž‹œ‡“‰’… ŠŽŒ€„“ createini"
goto :FAILURE

:READINIFILEOK
call :LOGLINE2
call :LOGINFO "RUN ..."
call :LOGINFO "ˆŒŸ Ž‹œ‡Ž‚€’…‹Ÿ: '%USERNAME%'"

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

if "%~1" == "create" (
 if not "%~2" == "" (
  call :GITCREATE %~2
 ) else (
  call :LOGERROR "ERROR ..."	
  echo Please run '%~nx0 init ^<gitname^>'
  goto :FAILURE
 )
 goto :end
)

if "%~1" == "createmaster" (
 call :GITCREATE master
 call :GITREMOTEADD
 goto :end
)

if "%~1" == "autocommit" (
 call :GITAUTOCOMMIT
 goto :end
)

if "%~1" == "autopush" (
 call :GITAUTOPUSH
 goto :end
)

if "%~1" == "autopush2" (
 rem call :GITAUTOPUSH
 "%GITEXE%" push --all origin --verbose
 goto :end
)

if "%~1" == "remoteadd" (
 call :GITREMOTEADD %2 %3
 goto :end
)

if "%~1" == "remoteadd2" (
 call :GITREMOTEADD !USERNAME! !REPONAME!
 goto :end
)

if "%~1" == "gitinit" (
 call :GITINIT
 call :GITHUBCREATE %REPONAME%
 call :GITAUTOCOMMIT
 call :GITREMOTEADD %OWNER% %REPONAME%

 goto :end
)

if "%~1" == "gitbranch" (
 call :GITBRANCH %3 %4 %5
 goto :end
)

if "%~1" == "gitbranchnew" (
 call :GITBRANCH new %3 %4 %5
 goto :end
)

if "%~1" == "createhub" (
 call :GITHUBCREATE %2
 goto :end
)

if "%~1" == "githubcreate" (
 call :GITHUBCREATE %2
 goto :end
)

if "%~1" == "createhub2" (
 call :GITHUBCREATE %REPONAME%
 goto :end
)

if "%~1" == "githubcreate2" (
 call :GITHUBCREATE %REPONAME%
 goto :end
)

if "%~1" == "githubdelete" (
 call :GITHUBDELETE %2
 goto :end
)

if "%~1" == "githubdelete2" (
 call :GITHUBDELETE %REPONAME%
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
 call :LOGINFO "    create folder       - á®§¤ ­¨¥ «®ª «ì­®£® à¥¯®§¨â à¨ï ¢ ª â «®£¥ folder"
 call :LOGINFO "                          ¢ ª â «®£ ª®¯¨àã¥â ¢á¥ ­¥®¡å®¤¨¬®¥, ¯®á«¥ á®§¤ ­¨ï ¢á¥ ¢ë§®¢ë ­ ¤® ¤¥« âì ¨§ folder "
 call :LOGINFO "    createmaster        - á®§¤ ­¨¥ £« ¢­®£® à¥¯®§¨â à¨ï ­  GitHub, ¤«ï åà ­¥­¨ï íâ¨å ãâ¨«¨â "
 call :LOGINFO " "
 call :LOGINFO " Š®¬ ­¤ë à ¡®â  á à¥¯®§¨â à¨ï¬¨:"
 call :LOGINFO "    gitinit             - á®§¤ ­¨¥¨ ¨ ¨­¨­æ¨ «¨§ æ¨ï à¥¯®§¨â à¨ï ¢ â¥ªãé¥© ¯ ¯ª¥ "
 call :LOGINFO "    autopush            - ®â¯à ¢«ï¥â ¢á¥ ¨§¬¥­¥­¨ï ¢ ã¤ «¥­­ë© à¥¯®§¨â à¨ï ­  GitHub "
 call :LOGINFO "    autocommit		-  ¢â®ª®¬¬¨â ¢ â¥ªãé¥© ¤ â®© ¨ ¢à¥¬¥­¨¬ "
 call :LOGINFO "    remoteadd           - ¤®¡ ¢«¥­¨¥ ã¤ «ñ­­ëå à¥¯®§¨â®à¨¥¢"
 call :LOGINFO "    gitbranch           - ª®¬ ­¤  ¤«ï ã¯à ¢«¥­¨ï ¢¥âª ¬¨ ¢ à¥¯®§¨â®à¨¨ Git"
 call :LOGINFO " "
 call :LOGINFO " Š®¬ ­¤ë ¤«ï GitHub:"
 call :LOGINFO "    createhub           - á®§¤ ­¨¥ ã¤ «¥­­®£® à¥¯®§¨â à¨ï ­  GitHub, ¤«ï åà ­¥­¨ï á®§¤ ­­®£® "
 call :LOGINFO "    githubcreate        - á®§¤ ­¨¥ ã¤ «¥­­®£® à¥¯®§¨â à¨ï ­  GitHub, ¤«ï åà ­¥­¨ï á®§¤ ­­®£® "
 call :LOGINFO "    githubdelete        - ã¤ «¥­¨¥ à¥¯®§¨â à¨ï ­  GitHub"
 call :LOGINFO " "
 call :LOGINFO "    info                - ˆ­ä®à¬ æ¨ï, ª®¬ ­¤  ¯® ã¬®«ç ­¨î "
 call :LOGINFO "    help                - ®ª § âì íâã á¯à ¢ªã ¨ ¢ë©â¨ "
 call :LOGINFO " "
goto :eof

:info
 call :LOGLINE2
 rem call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO "ˆ”ŽŒ€–ˆŸ"
 call :LOGDEBUG "WGET VERSION"
 rem %WGETEXE% --version --quiet
 echo off
 rem GNU Wget 1.21.4 built on mingw32.
 rem for /f %%a in ('"%WGETEXE% --version"') do ( echo UserName=%%a )
for /f "usebackq eol= delims=" %%a in (`"%WGETEXE% --version"`) do (
 rem echo %%a
 set str1=%%a
 set str2=!str1:~0,8!
 rem echo '!str2!'
 if "!str2!"=="GNU Wget" (
  call :LOGDEBUG "!str1!"
 )
)
 echo off

 call :LOGDEBUG "GIT VERSION"
 echo .
 "%GITEXE%" --version
 echo .

 call :LOGDEBUG "GITHUB VERSION"
 echo .
 "%GHEXE%" --version
 echo .

 call :LOGDEBUG "GIT €„…‘€ „‹Ÿ —’…ˆŸ ˆ ‡€ˆ‘ˆ, ˆ‚Ÿ‡€›… Š …Ž‡ˆ’Žˆž:"
 echo .
 "%GITEXE%" remote -v
 echo .

 call :LOGDEBUG "GIT STATUS"
 echo .
 "%GITEXE%" status --verbose
 echo .

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ---------------------------------------------------------------------------------------
rem ABBALibraryGITStart

rem ==========
:FINDGIT
 call :FINDFILE "git.exe" "GITEXE"
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof


rem ==========
:FINDGITHUBCLI
 call :FINDFILE "gh.exe" "GHEXE"
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof


rem - GIT Command

rem ==========
:GITGETCONFIG
 call :LOGDEBUG "GIT GLOBAL CONFIG: Username Email"
 rem  for /f "tokens=1" %%a in ('"git config --local --get user.name"') do ( 
 rem   echo UserName=%%a
 rem   set USERNAME=%%a
 rem   call :LOGDEBUG "USERNAME = '%USERNAME%'"
 rem   call :LOGDEBUG "USERNAME = '!USERNAME!'"
 rem   call :LOGDEBUG "USERNAME = '%USERNAME%'"
 rem   )
 rem  git config --local --get user.email
 rem  echo .

 for /f "tokens=1* delims==" %%a in ('"git config --global --list"') do ( 
  rem echo '%%a = %%b'
  if "%%a" == "user.name" (
   rem echo '%%a = %%b'
   set USERNAME=%%b
   call :LOGDEBUG "USERNAME = '!USERNAME!'"
  ) else if "%%a" == "user.email" (
   rem  echo '%%a = %%b'
   set USEREMAIL=%%b
   call :LOGDEBUG "USEREMAIL = '!USEREMAIL!'"
  )

  rem set USERNAME=%%a
  rem call :LOGDEBUG "USERNAME = '%USERNAME%'"
  rem call :LOGDEBUG "USERNAME = '!USERNAME!'"
  rem call :LOGDEBUG "USERNAME = '%USERNAME%'"
  )

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GITCREATE
call :LOGLINE2
if "%~1" == "master" (
 call :LOGINFO "CREATE MASTER ..."
 call :LOGINFO "COPY FILES ..."
 for %%I in ( "LICENSE.md", "README.md", ".gitignore ", ".gitattributes", "run_git.cmd" ) do (
  call :LOGDEBUG "COPY FILE '%%~I'"
  if not exist "%%~I" ( copy "..\%%~I" "%%~I" )
 )
) else (
 echo ==========================================================================================
 call :CHANGEDIR ..
 call :LOGDEBUG "CREATE REPO 'mywingit%~1' ..."
 call :LOGDEBUG "INIT GIT 'mywingit%~1' ..."
 "%GITEXE%" init "mywingit%~1"
 set MCD=!CD!
 call :LOGDEBUG "MCD = '!MCD!'"
 set RDIR=!MCD!\mywingit%~1
 call :LOGDEBUG "DIR REPO '!RDIR!' ..."
 call :CHANGEDIR "%ROOTDIR%"
 call :LOGDEBUG "COPY FILES ..."
 for %%I in ( "CopyFiles\LICENSE.md", "CopyFiles\README.md", "CopyFiles\.gitignore ", "CopyFiles\.gitattributes", "run_git.cmd" ) do (
  rem call :LOGDEBUG "COPY FILE '%%~I'"
  if exist "%%~I" (
   call :LOGDEBUG "COPY '%%~I' to '!RDIR!\%%~nxI' ..."
   rem copy %%~I "!RDIR!\%%~nxI"
   xcopy /YF %%~I "!RDIR!"
  )
 )
)

call :CHANGEDIR %RDIR%

rem "%GITEXE%" remote add origin https://github.com/!USERNAME!/mywingit%~1.git
rem "%GITEXE%" branch master
rem "%GITEXE%" checkout master

echo .
"%GITEXE%" add .
"%GITEXE%" commit -m "first commit"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GITINIT
 call :LOGDEBUG "‘Ž‡„€ˆ… ˆ ˆˆ–ˆ€‹ˆ‡€–ˆŸ …Ž‡ˆ’€ˆŸ ..."
 "%GITEXE%" init
 "%GITEXE%" add . --verbose
 call :GET_DT
 call :LOGDEBUG "CREATE TIMESTAMP '%DT%'"
 "%GITEXE%" commit -a -m "First commit '%dt%'" --verbose

 git branch -M master --verbose

 call :LOGDEBUG "GIT BRANCH LIST"
 git branch

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GITREMOTEADD
 call :LOGLINE2
 call :LOGINFO "„Ž€‚‹…ˆ… “„€‹ð›• …Ž‡ˆ’Žˆ…‚ ..."
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 if "%~1"=="" (
  call :LOGERROR "ARG1 = NULL"
  call :LOGDEBUG "call :GITREMOTEADD UserName RepoName"
  set errorlevel=1
  goto :FAILURE
 )

 if "%~2"=="" (
  call :LOGERROR "ARG2 = NULL"
  call :LOGDEBUG "call :GITREMOTEADD UserName RepoName"
  set errorlevel=1
  goto :FAILURE
 )

 echo .
 echo off

 git remote remove origin
 "%GITEXE%" remote add origin https://github.com/%~1/%~2.git
 git branch -a

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof


rem ==========
:GITAUTOCOMMIT
 call :LOGLINE2
 call :LOGINFO "GIT ADD AUTO COMMIT ..."

 call :LOGDEBUG "ADD ALL FILES ..."
 echo .
 "%GITEXE%" add . --verbose

 call :GET_DT
 rem call :LOGDEBUG "CREATE TIMESTAMP '%DT%'"
 set COMMITTXT=Auto commit '%dt%'
 call :LOGDEBUG "COMMITTXT '%COMMITTXT%'"
 "%GITEXE%" commit -a -m "%COMMITTXT%" --verbose

 rem call :LOGDEBUG "GIT STATUS ..."
 rem "%GITEXE%" status --verbose

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GITAUTOPUSH
 call :LOGLINE2
 call :LOGINFO "GIT AUTO PUSH REMOTE ..."

 echo off
 rem for /f "tokens=2 delims=:." %%a in ('"%SystemRoot%\System32\chcp.com"') do ( echo %%a )
 rem "%GITEXE%" branch"
 set BRANCH=
 for /f "tokens=1*" %%a in ('"git branch"') do ( 
  rem echo Debug1 %%a,%%b 
  if "%%a"=="*" (
   rem echo Debug2 %%a,%%b 
    set BRANCH=%%b
    call :LOGDEBUG "BRANCH = '!BRANCH!'"
    "%GITEXE%" push --set-upstream origin !BRANCH! --verbose
  )
 )

 echo off
 rem call :LOGDEBUG "ERRORLEVEL %ERRORLEVEL%"
 rem echo %ERRORLEVEL%
 echo off
 if not "%ERRORLEVEL%" == "128" (
 rem echo "!BRANCH!"
 if not "!BRANCH!"=="master" ( "%GITEXE%" push --set-upstream origin --verbose )
  echo off
  if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
  call :LOGDEBUG "ERRORLEVEL %ERRORLEVEL%"
 )

goto :eof

rem ==========
:GITHUBCREATE
 call :LOGLINE2
 call :LOGINFO "CREATE REMOTE REPO ON GITHUB"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 rem "%GHEXE%" auth login --web

 if "%~1"=="" (
  call :LOGERROR "ARG1 = NULL"
  call :LOGDEBUG "call :GITHUBCREATE RepoName"
  set errorlevel=1
  goto :FAILURE
 )

 echo .
 echo off
 "%GHEXE%" auth status
 rem "%GHEXE%" repo create --public --description "My Repo 'mywingit%~1'" -y

 echo .
 "%GHEXE%" repo create %OWNER%/%1 --private --source=. --remote=origin --description "My Repo '%1'"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GITHUBDELETE
 call :LOGLINE2
 call :LOGINFO "DELETE REMOTE REPO ON GITHUB"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 rem "%GHEXE%" auth login --web
 rem gh auth refresh -h github.com -s delete_repo

 if "%~1"=="" (
  call :LOGERROR "ARG1 = NULL"
  call :LOGDEBUG "call :GITHUBDELETE RepoName"
  set errorlevel=1
  goto :FAILURE
 )

 echo off
 echo .
 "%GHEXE%" auth status

 echo .
 "%GHEXE%" repo delete %OWNER%/%1 --yes

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GITBRANCH
 call :LOGLINE2
 call :LOGINFO "â® ª®¬ ­¤  ¤«ï ã¯à ¢«¥­¨ï ¢¥âª ¬¨ ¢ à¥¯®§¨â®à¨¨ Git"
 call :LOGDEBUG "CALL %0 %1 %2 %3 %4 %5"
 echo off

 if "%1"=="new" (
  if "%2"=="" (
   set BRANCHINI=!file_name!.branch.ini
  ) else (
   set BRANCHINI=%~2
  )
 ) else (
   set BRANCHINI=%~1
 )
echo off

echo off
 if exist "%BRANCHINI%" (
  call :LOGDEBUG "—’…ˆ… ”€‰‹€ '%BRANCHINI%'"
  for /f "usebackq eol=; tokens=1,2 delims=, " %%a in (%BRANCHINI%) do ( 
   rem echo %%a,%%b
   if "%%a"=="BRANCHNAME" ( 
	set BRANCHNAME=%%b
   ) else if "%%a"=="BRANCHNUMBER" ( 
	set BRANCHNUMBER=%%b
   )
  )
 ) else (
  call :LOGDEBUG "‘Ž‡„€ˆ… ”€‰‹€ '%BRANCHINI%'"
  call :LOGDEBUG "‡€ˆ‘œ ‚ ”€‰‹ '%BRANCHINI%'"
  echo ; > %BRANCHINI%
  echo BRANCHNAME,test >> %BRANCHINI%
  echo BRANCHNUMBER,0 >> %BRANCHINI%
  call :LOGDEBUG "Ž‚’Ž›‰ ‚›‡Ž‚ %0"
  call :GITBRANCH %~1 %~2
  echo off
  if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
  exit /b 0
 )
echo off
 call :LOGDEBUG "BRANCHNAME   = '!BRANCHNAME!'"
 call :LOGDEBUG "BRANCHNUMBER = '!BRANCHNUMBER!'"

 if "%1"=="new" (
  call :LOGDEBUG "ŠŽŒ€„€ %1"
  set /a BRANCHNUMBER=!BRANCHNUMBER!+1
  call :GITBRANCHSAVE

  call :LOGINFO "‘Ž‡„€’œ Ž‚“ž ‚…’Š“ '!BRANCHNAME!!BRANCHNUMBER!' ˆ ……Š‹ž—ˆ’œ‘Ÿ € …ð"
  "%GITEXE%" checkout -b !BRANCHNAME!!BRANCHNUMBER!

 ) else (
  call :LOGDEBUG "à®á¬®âà¥âì á¯¨á®ª ¢á¥å ¢¥â®ª ¢ â¥ªãé¥¬ à¥¯®§¨â®à¨¨:"
  echo .
  "%GITEXE%" branch
  echo .
 )

:GITBRANCH1
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

:GITBRANCHSAVE
 call :LOGDEBUG "‡€ˆ‘œ Ž‚›• „€›• ‚ ”€‰‹ '%BRANCHINI%'"
 call :LOGDEBUG "BRANCHNAME   = '!BRANCHNAME!'"
 call :LOGDEBUG "BRANCHNUMBER = '!BRANCHNUMBER!'"
 echo ; > %BRANCHINI%
 echo BRANCHNAME,!BRANCHNAME! >> %BRANCHINI%
 echo BRANCHNUMBER,!BRANCHNUMBER! >> %BRANCHINI%

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ABBALibraryGITEnd


rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdWgetStart
rem find wget
:FINDWGET
 call :FINDFILE "wget.exe" "WGETEXE"
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
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
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )

goto :eof
rem ABBALibraryCmdWgetEnd

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdCloneStart
:FINDRCLONE
 call :FINDFILE "rclone.exe" "RCLONEEXE" "D:\0_RCLONE" "Z:\0_RCLONE"
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof
rem ABBALibraryCmdCloneEnd

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdZipStart
rem %1 
rem %2 FILEOUT
:FINDZIP
rem call :FINDFILE "%SystemDrive%" "7z.exe" "ZIPEXE"
 call :FINDFILE "7z.exe" "ZIPEXE" "C:\Program Files\7-Zip"
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof
rem ABBALibraryCmdZipEnd

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdFindStart

REM
REM print_head
REM Prints the first non-blank %1 lines in the file %2.
REM
:print_head
setlocal EnableDelayedExpansion
set /a counter=0

for /f ^"usebackq^ eol^=^

^ delims^=^" %%a in (%2) do (
        if "!counter!"=="%1" goto :eof
        echo %%a
        set /a counter+=1
)
goto :eof


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
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof
rem ABBALibraryFindZipEnd

rem ========== Read SET from ini file ==========
:READINIFILE
rem Read config file
call :LOGINFO "Read config file ..."
set MYINI=%~1.ini
if exist !MYINI! (
		call :LOG "CONFIG = !MYINI! ..."
		for /F "usebackq eol=; tokens=1,2 delims=, " %%a in (!MYINI!) do (
			set %%a=%%b
			call :LOGDEBUG "%%a = '%%b' ..."
		)
	) else (
		call :LOGERROR "Config file !MYINI! no found ..."
		set errorlevel=1
		goto :READINIFILE12
	)

:READINIFILE12
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ========== Read SET from ini file ==========
:READINIFILE2
rem Read config file
call :LOGINFO "Read config file ..."
set MYINI2=%~1
if exist !MYINI2! (
		call :LOG "CONFIG = !MYINI2! ..."
		for /F "usebackq eol=# tokens=1,2 delims=, " %%a in (!MYINI2!) do (
			set %%a=%%b
			call :LOGDEBUG "%%a = '%%b' ..."
		)
	) else (
		call :LOGERROR "Config file !MYINI2! no found ..."
		set errorlevel=1
		goto :READINIFILE21
	)

:READINIFILE21
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

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


