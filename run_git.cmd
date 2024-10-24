@echo off
chcp 866 >nul
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

title mygit

set DEBUG=1

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
call :LOGINFO " : '%CD%'"
call :LOGINFO "  : %RANDOM%"

if "%~1" == "install" (
 call :CMDINSTALL %0
 echo .
 echo off
 rem exit 0
 rem goto :eof
 goto :end
)

call :LOGLINE2
call :LOGINFO  "TEST INFO  ..."
call :LOGERROR "TEST ERROR ..."

call :LOGLINE2
rem root dir
set ROOTDIR=%CD%
call :LOG "ROOTDIR = '!ROOTDIR!' ..."
CALL :CHANGEDIR "%ROOTDIR%"

if "%~1" == "help" (
 call :help %~n0
 goto :end
)

rem call :LOGLINE2
rem set mygitini=.mygitini
rem if "%~1" == "createini2" goto CREATEFILEINI
rem if "%~1" == "createini" goto CREATEFILEINI
rem call :GETGITHUBOWNER
rem if not defined OWNER (
rem  call :LOGLINE2
rem  call :GITREADINIFILE
rem  rem call :CREATEGITHUBOWNER
rem  rem set OWNER=!GITUSERNAME!
rem  rem call :LOGWARNING "OWNER     = !OWNER!"
rem  goto :FAILURE
rem )
rem call :GITGETCONFIG
rem call :GITREADINIFILE
rem goto GORUN
rem :CREATEFILEINI
rem call :LOGLINE2
rem if "%~1" == "createini" (
rem  set file_name_ini=%mygitini%
rem )
rem if "%~1" == "createini2" (
rem  set file_name_ini=!file_name!.ini
rem )
rem call :LOG "  '%file_name_ini%'"
rem call :GITGETCONFIG
rem call :LOGDEBUG "  :"
rem set /p REPONAME=
rem set REPONAME=!PARENTFOLDER!
rem call :LOG " :"
rem call :LOG "REPONAME = !REPONAME!"
rem call :LOG "   '%file_name_ini%'"
rem echo ; > %file_name_ini%
rem echo ; >> %file_name_ini%
rem remecho GITUSERNAME,!GITUSERNAME! >> %file_name_ini%
rem echo GITUSEREMAIL,!GITUSEREMAIL! >> %file_name_ini%
rem echo REPONAME,!REPONAME! >> %file_name_ini%
rem !!!
rem echo OWNER,!GITUSERNAME! >> %file_name_ini%
rem echo BRANCHNAME,test  >> %file_name_ini%
rem echo BRANCHNUMBER,1  >> %file_name_ini%
rem !!!
rem call :GITREADINIFILE
rem goto :end
rem :GORUN

if "%~1" == "gitscan" (
 call :gitscan
 goto :end
)

if not exist .git (
 if not "%~1" == "gitinit" (
  call :LOGLINE2
  call :LOGWARNING "----------------------------------------------------------------------------------------------------"
  call :LOGWARNING "      "
  call :LOGWARNING "    "
  call :LOGWARNING "  'run_git.cmd.git.init.cmd' "
  call :LOGWARNING "   'run_git.cmd gitinit' "
  call :LOGWARNING "----------------------------------------------------------------------------------------------------" 
  goto :FAILURE
 )
)

call :LOGLINE2
call :LOGINFO " "
call :FINDZIP
call :FINDWGET
call :FINDRCLONE
call :FINDGIT
call :FINDGITHUBCLI

call :LOGLINE2
call :LOGINFO "ZIPEXE    = '%ZIPEXE%'"
call :LOGINFO "WGETEXE   = '%WGETEXE%'"
call :LOGINFO "RCLONEEXE = '%RCLONEEXE%'"
call :LOGINFO "GITEXE    = '%GITEXE%'"
call :LOGINFO "GHEXE     = '%GHEXE%'"

echo off
rem call :GITREADINIFILE
echo off

if "%~1" == "" (
 call :gitinfo
 goto :end
)

call :gitinfo

call :LOGLINE2
call :LOGINFO "RUN COMMAND '%1' ..."


if "%~1" == "gitinit" (
 call :GETPARENTFOLDER
 call :LOGINFO " : '!PARENTFOLDER!'"

 call :GETGITHUBOWNER
 set REPONAME=!PARENTFOLDER!

 call :GITINIT
 set OWNER=
 call :GETGITHUBOWNER 
 call :LOGINFO "REPONAME: '!REPONAME!'"
 call :LOGINFO "OWNER:    '!OWNER!'"
 call :GITHUBCREATE !REPONAME!
 call :GITAUTOCOMMIT
 call :GITREMOTEADD !OWNER! !REPONAME!
 goto :end
)

rem call :LOGINFO " : '%GITUSERNAME%'"

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

if "%~1" == "info" (
 call :info
 goto :end
)

if "%~1" == "test" ( 
 goto :end
)

rem --------------------------------------------------------------------------------------------------------------
rem  

if "%~1" == "autocommit" (
 call :GITAUTOCOMMIT %3
 goto :end
)

if "%~1" == "autopush" (
 call :GITAUTOPUSH
 goto :end
)

if "%~1" == "checkout" (
 call :GITCHECKOUT %3 %4 %5
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

if "%~1" == "githubcreate2" (
 call :GITHUBCREATE !REPONAME!
 goto :end
)

if "%~1" == "githubdelete2" (
 call :GITHUBDELETE !REPONAME!
 goto :end
)

if "%~1" == "githubdelete" (
 call :GITHUBDELETE %2
 goto :end
)

rem --------------------------------------------------------------------------------------------------------------
rem    

if "%~1" == "create" (
 if not "%~2" == "" (
  call :GITCREATE %~2
 ) else (
  call :LOGERROR "ERROR ..."	
  echo Please run '%~nx0 init ^<gitname^>'
  goto FAILURE
 )
 goto :end
)

if "%~1" == "createmaster" (
 call :GITCREATE master
 call :GITREMOTEADD
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
 call :GITREMOTEADD !GITUSERNAME! !REPONAME!
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
 call :GITHUBCREATE !REPONAME!
 goto :end
)

call :LOGERROR "  '%~1'"
goto FAILURE

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

:END2
exit 0
goto :eof

rem ==========
:help
 call :LOGLINE2
 call :LOGINFO "แฏฎซ์งฎข ญจฅ: "
 call :LOGINFO "    '%~1' [] [] "
 call :LOGINFO " "
 call :LOGINFO "ฎฌ ญค๋: "
 call :LOGINFO "    create folder       - แฎงค ญจฅ ซฎช ซ์ญฎฃฎ เฅฏฎงจโ เจ๏ ข ช โ ซฎฃฅ folder"
 call :LOGINFO "                          ข ช โ ซฎฃ ชฎฏจเใฅโ ขแฅ ญฅฎกๅฎคจฌฎฅ, ฏฎแซฅ แฎงค ญจ๏ ขแฅ ข๋งฎข๋ ญ คฎ คฅซ โ์ จง folder "
 call :LOGINFO "    createmaster        - แฎงค ญจฅ ฃซ ขญฎฃฎ เฅฏฎงจโ เจ๏ ญ  GitHub, คซ๏ ๅเ ญฅญจ๏ ํโจๅ ใโจซจโ "
 call :LOGINFO " "
 call :LOGINFO " ฎฌ ญค๋ เ กฎโ  แ เฅฏฎงจโ เจ๏ฌจ:"
 call :LOGINFO "    gitinit             - แฎงค ญจฅจ จ จญจญๆจ ซจง ๆจ๏ เฅฏฎงจโ เจ๏ ข โฅชใ้ฅฉ ฏ ฏชฅ "
 call :LOGINFO "    autopush            - ฎโฏเ ขซ๏ฅโ ขแฅ จงฌฅญฅญจ๏ ข ใค ซฅญญ๋ฉ เฅฏฎงจโ เจ๏ ญ  GitHub "
 call :LOGINFO "    autocommit		-  ขโฎชฎฌฌจโ ข โฅชใ้ฅฉ ค โฎฉ จ ขเฅฌฅญจฌ "
 call :LOGINFO "    remoteadd           - คฎก ขซฅญจฅ ใค ซ๑ญญ๋ๅ เฅฏฎงจโฎเจฅข"
 call :LOGINFO "    gitbranch           - ชฎฌ ญค  คซ๏ ใฏเ ขซฅญจ๏ ขฅโช ฌจ ข เฅฏฎงจโฎเจจ Git"
 call :LOGINFO " "
 call :LOGINFO " ฎฌ ญค๋ คซ๏ GitHub:"
 call :LOGINFO "    createhub           - แฎงค ญจฅ ใค ซฅญญฎฃฎ เฅฏฎงจโ เจ๏ ญ  GitHub, คซ๏ ๅเ ญฅญจ๏ แฎงค ญญฎฃฎ "
 call :LOGINFO "    githubcreate        - แฎงค ญจฅ ใค ซฅญญฎฃฎ เฅฏฎงจโ เจ๏ ญ  GitHub, คซ๏ ๅเ ญฅญจ๏ แฎงค ญญฎฃฎ "
 call :LOGINFO "    githubdelete        - ใค ซฅญจฅ เฅฏฎงจโ เจ๏ ญ  GitHub"
 call :LOGINFO " "
 call :LOGINFO "    info                - ญไฎเฌ ๆจ๏, ชฎฌ ญค  ฏฎ ใฌฎซ็ ญจ๎ "
 call :LOGINFO "    help                - ฎช ง โ์ ํโใ แฏเ ขชใ จ ข๋ฉโจ "
 call :LOGINFO " "
goto :eof

rem ==========
:gitscan
 call :LOGLINE2
 rem call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO " "
 call :FINDGIT
 call :FINDGITHUBCLI
 call :LOGINFO2 "    '%CD%'..."
 
 for /d %%i in (*) do (
  cd %%i
  if exist .git (
    rem call :LOGINFO2 ":                      '%CD%\%%i'"
    rem call :LOG      "ADD SAFE.DIRECTORY          '!f!'"
    call :GITCONFIGSAFEDIRECTORY
   )
  cd ..
  ) 

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:gitinfo
 call :LOGLINE2
 rem call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO2 "  "

 call :GETPARENTFOLDER
 set REPONAME=!PARENTFOLDER!
 call :LOGINFO2 ":                   '!REPONAME!'"

 call :GETGITHUBOWNER 
 if not defined OWNER goto :FAILURE
 call :LOGINFO2  ":                   '%OWNER%'"
                                                                                           
 for /f "tokens=1* delims==" %%a in ('"git config --get user.name"')   		do ( call :LOGINFO2 " :           '%%a'")
 for /f "tokens=1* delims==" %%a in ('"git config --get user.email"')		do ( call :LOGINFO2 ".:                   '%%a'")
 for /f "tokens=1* delims==" %%a in ('"git config --get remote.origin.url"')	do ( call :LOGINFO2 "URL:                        '%%a'")
 for /f "tokens=1* delims==" %%a in ('"git rev-parse --abbrev-ref HEAD"')	do ( call :LOGINFO2 "  :     '%%a'")

 call :GITCONFIGSAFEDIRECTORY

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

:info
 call :LOGLINE2
 rem call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO ""
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

 call :LOGDEBUG "         GitHub."
 echo .
 "%GHEXE%" auth status
 echo .

 call :LOGDEBUG "GIT     ,   :"
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
:GITREADINIFILE
call :LOGLINE2

call :LOGDEBUG " '%mygitini%'"
if exist %mygitini% (
 call :LOG "   '%mygitini%'"
 call :READINIFILE2 %mygitini%
 if "%ERRORLEVEL%"=="0" (
  goto GITREADINIFILEOK
 )
) 

call :LOG " '!file_name!.ini'"
if exist !file_name!.ini (
 call :LOG "   '!file_name!.ini'"
 call :READINIFILE !file_name!
 if "%ERRORLEVEL%"=="0" (
  goto GITREADINIFILEOK
 )
)

call :LOGLINE2
rem call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
call :LOGDEBUG "   '!file_name!.ini'"

call :GITGETCONFIG
call :LOGDEBUG "  createini"

goto FAILURE

:GITREADINIFILEOK
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof
rem ==========


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
:GITCONFIGSAFEDIRECTORY
 rem call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 echo off
 rem git config --global --get-all safe.directory

 set f=%CD%
 set "f=!f:\=/!"
 rem echo !f!

 for /f "tokens=1*" %%a in ('"git config --global --get-all safe.directory"') do (
	if not %%a == "" (
	if %%a == !f! (
	  rem echo %%a
	  set safedir=%%a
	  call :LOGINFO2 "SAFE.DIRECTORY              '%%a'"
	  rem "%GITEXE%" config --global --add safe.directory '%CD%'
	 )
        )
   )

 if not defined safedir (
  call :LOG      "ADD SAFE.DIRECTORY          '!f!'"
  "%GITEXE%" config --global --add safe.directory !f!
 )


 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GITGETCONFIG
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 rem git config --get user.email
 for /f "tokens=1* delims==" %%a in ('"git config --get user.email"') do (set GITUSEREMAIL=%%a)
 rem git config --get user.name
 for /f "tokens=1* delims==" %%a in ('"git config --get user.name"') do (set GITUSERNAME=%%a)

 call :LOGDEBUG "GITUSERNAME = '%GITUSERNAME%'"
 call :LOGDEBUG "GITUSEREMAIL = '%GITUSEREMAIL%'"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GETGITHUBOWNER
 rem call :LOGDEBUG "CALL '%0'"
 rem call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"
 rem git config --get github.name
 rem git config --file ..\.gitconfig-work --get github.name

 rem echo "!ROOTDIR!\..\.gitconfig-work"
 set GITCONFIG-WORK="!ROOTDIR!\..\.gitconfig-work"
 if exist %GITCONFIG-WORK% (
  call :LOGDEBUG "GITCONFIG-WORK = '%GITCONFIG-WORK%'"
  for /f "tokens=1* delims==" %%a in ('"git config --file %GITCONFIG-WORK% --get github.name"') do (set OWNER=%%a)
 )

 if not defined OWNER (
  for /f "tokens=1* delims==" %%a in ('"git config --get user.name"') do (set OWNER=%%a)
 )

 if not defined OWNER goto :FAILURE
 rem call :LOGINFO  " = '%OWNER%'"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:CREATEGITHUBOWNER
 call :LOGDEBUG "CALL '%0'"
 rem call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"
 if "%OWNER%" == "" ( 
  call :LOGWARNING "----------------------------------------------------------------------------------------------------"
  call :LOGWARNING "      GitHub   'GIT INIT'"
  call :LOGWARNING "  'git config github.name ""' "
  call :LOGWARNING "----------------------------------------------------------------------------------------------------" 

  set mygitini=%~dp0%.mygitini
  call :GITREADINIFILE
  call :LOG " :"
  set cint=1
  for /f "tokens=1* delims==" %%a in ('"set OWNER"') do (
   set %%a=%%b
   echo . !cint!.	'%%b'
   set /a cint=!cint!+1
  )

  echo.
  Set /p choice=" ่ ข๋กฎเ: "
  if not defined choice goto :FAILURE
  echo !choice!
  if "!choice!"=="1" (set OWNESELECT=!OWNER1!)
  if "!choice!"=="2" (set OWNERSELECT=!OWNER2!)
  if "!choice!"=="3" (set OWNERSELECT=!OWNER3!)
  if "!choice!"=="4" (set OWNERSELECT=!OWNER4!)

  if defined OWNERSELECT (
  call :LOG "OWNERSELECT = !OWNERSELECT!"
   echo .
   git config --global github.name "!OWNERSELECT!"
   goto :end
  )                         

  call :LOGWARNING "----------------------------------------------------------------------------------------------------" 
  goto :FAILURE
 )

 call :LOGINFO  "GITHUB OWNER = '%OWNER%'"
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof


rem ==========
:GITGETCONFIGGLOBAL
 call :LOGDEBUG "GIT GLOBAL CONFIG: Username Email"
 rem  for /f "tokens=1" %%a in ('"git config --local --get user.name"') do ( 
 rem   echo GITUSERNAME=%%a
 rem   set GITUSERNAME=%%a
 rem   call :LOGDEBUG "GITUSERNAME = '%GITUSERNAME%'"
 rem   call :LOGDEBUG "GITUSERNAME = '!GITUSERNAME!'"
 rem   call :LOGDEBUG "GITUSERNAME = '%GITUSERNAME%'"
 rem   )
 rem  git config --local --get user.email
 rem  echo .

 for /f "tokens=1* delims==" %%a in ('"git config --global --list"') do ( 
  rem echo '%%a = %%b'
  if "%%a" == "user.name" (
   rem echo '%%a = %%b'
   set GITUSERNAME=%%b
   call :LOGDEBUG "GITUSERNAME = '!GITUSERNAME!'"
  ) else if "%%a" == "user.email" (
   rem  echo '%%a = %%b'
   set GITUSEREMAIL=%%b
   call :LOGDEBUG "GITUSEREMAIL = '!GITUSEREMAIL!'"
  )

  rem set GITUSERNAME=%%a
  rem call :LOGDEBUG "GITUSERNAME = '%GITUSERNAME%'"
  rem call :LOGDEBUG "GITUSERNAME = '!GITUSERNAME!'"
  rem call :LOGDEBUG "GITUSERNAME = '%GITUSERNAME%'"
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

rem "%GITEXE%" remote add origin https://github.com/!GITUSERNAME!/mywingit%~1.git
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
 call :LOGDEBUG "    ..."
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
 call :LOGINFO " ๐  ..."
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 if "%~1"=="" (
  call :LOGERROR "ARG1 = NULL"
  call :LOGDEBUG "call :GITREMOTEADD GITUSERNAME RepoName"
  set errorlevel=1
  goto FAILURE
 )

 if "%~2"=="" (
  call :LOGERROR "ARG2 = NULL"
  call :LOGDEBUG "call :GITREMOTEADD GITUSERNAME RepoName"
  set errorlevel=1
  goto FAILURE
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
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :LOGDEBUG "ADD ALL FILES ..."

 echo .
 "%GITEXE%" add . --verbose
 echo .

 call :GET_DT
 rem call :LOGDEBUG "CREATE TIMESTAMP '%DT%'"
 
 if "%~1" == "" (
  set COMMITTXT=The autocommit has been added to '%dt%'
  call :LOGDEBUG "COMMITTXT '!COMMITTXT!'"
 ) else (
  set COMMITTXT=Commit '%~1' has been added to '%dt%'
  call :LOGDEBUG "COMMITTXT '!COMMITTXT!'"
 )

 echo .
 "%GITEXE%" commit -a -m "!COMMITTXT!" --verbose
 echo .

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
    echo .
    "%GITEXE%" push --set-upstream origin !BRANCH! --verbose
    echo .
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
  goto FAILURE
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
  goto FAILURE
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
 call :LOGINFO "โฎ ชฎฌ ญค  คซ๏ ใฏเ ขซฅญจ๏ ขฅโช ฌจ ข เฅฏฎงจโฎเจจ Git"
 call :LOGDEBUG "CALL %0 %1 %2 %3 %4 %5"
 echo off

 if "%1"=="new" (

  if "%2"=="" (
   set BRANCHINI=.mygitbranchini
  ) else (
   set BRANCHINI=%~2
  )

 ) else (

  if "%1"=="" (
   set BRANCHINI=.mygitbranchini
  ) else (
   set BRANCHINI=%~1
  )

 rem set BRANCHINI=%~1
 )
echo off

echo off
 if exist "%BRANCHINI%" (
  call :LOGDEBUG "  '%BRANCHINI%'"
  for /f "usebackq eol=; tokens=1,2 delims=, " %%a in (%BRANCHINI%) do ( 
   rem echo %%a,%%b
   if "%%a"=="BRANCHNAME" ( 
	set BRANCHNAME=%%b
   ) else if "%%a"=="BRANCHNUMBER" ( 
	set BRANCHNUMBER=%%b
   )
  )
 ) else (
  call :LOGDEBUG "  '%BRANCHINI%'"
  call :LOGDEBUG "   '%BRANCHINI%'"
  echo ; > %BRANCHINI%
  echo BRANCHNAME,test >> %BRANCHINI%
  echo BRANCHNUMBER,0 >> %BRANCHINI%
  call :LOGDEBUG "  %0"
  call :GITBRANCH %~1 %~2
  echo off
  if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
  exit /b 0
 )

 echo off
 call :LOGDEBUG "BRANCHNAME   = '!BRANCHNAME!'"
 call :LOGDEBUG "BRANCHNUMBER = '!BRANCHNUMBER!'"

 if "%1"=="new" (
  call :LOGDEBUG " %1"
  set /a BRANCHNUMBER=!BRANCHNUMBER!+1
  call :GITBRANCHSAVE

  call :LOGINFO "   '!BRANCHNAME!!BRANCHNUMBER!'    ๐"
  "%GITEXE%" checkout -b !BRANCHNAME!!BRANCHNUMBER!
  goto GITBRANCH1
 )

 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :LOGDEBUG "เฎแฌฎโเฅโ์ แฏจแฎช ขแฅๅ ขฅโฎช ข โฅชใ้ฅฌ เฅฏฎงจโฎเจจ:"
 echo .
 "%GITEXE%" branch
 echo .
 
:GITBRANCH1
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

:GITBRANCHSAVE
 call :LOGDEBUG "     '%BRANCHINI%'"
 call :LOGDEBUG "BRANCHNAME   = '!BRANCHNAME!'"
 call :LOGDEBUG "BRANCHNUMBER = '!BRANCHNUMBER!'"
 echo ; > %BRANCHINI%
 echo BRANCHNAME,!BRANCHNAME! >> %BRANCHINI%
 echo BRANCHNUMBER,!BRANCHNUMBER! >> %BRANCHINI%

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

:GITCHECKOUT
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"
 
 if "%~1"=="" (
  call :LOGERROR "ARG1 = NULL"
  call :LOGDEBUG "call %0 [ญ จฌฅญฎข ญจฅ ขฅโชจ]"
  set errorlevel=1
  goto FAILURE
 )

 "%GITEXE%" checkout %1

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
 goto FINDFILE2
)

if "%~2"=="" (
 call :LOGERROR "ARG2 = NULL"
 goto FINDFILE2
)

call :LOGINFO "FIND '%~1' ..."
for %%i in ("%~1") do set %~2=%%~$PATH:i
rem echo "!%~2!"
if not "!%~2!" == "" (
 rem set %~2=!z1!
 goto FINDFILE1
) else (
 echo off
 if not "%~3"=="" (
  for /D %%k in (%3 %4 %5 %6 %7 %8 %9) do (
   set z1=%%~k\%~1
   rem echo !z1!
   if exist !z1! (
    set %~2=!z1!
    goto FINDFILE1
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
set MYINI=%~1.ini
if exist !MYINI! (
		call :LOGINFO "  '!MYINI!' ..."
		for /F "usebackq eol=; tokens=1,2 delims=, " %%a in (!MYINI!) do (
			set %%a=%%b
			call :LOGDEBUG "%%a = '%%b' ..."
		)
	) else (
		call :LOGERROR "Config file !MYINI! no found ..."
		set errorlevel=1
		goto READINIFILE12
	)

:READINIFILE12
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ========== Read SET from ini file ==========
:READINIFILE2
rem Read config file
set MYINI2=%~1
if exist !MYINI2! (
		call :LOGINFO "  '!MYINI2!' ..."
		for /F "usebackq eol=; tokens=1,2 delims=, " %%a in (!MYINI2!) do (
			set %%a=%%b
			call :LOGDEBUG "%%a = '%%b' ..."
		)
	) else (
		call :LOGERROR "Config file !MYINI2! no found ..."
		set errorlevel=1
		goto READINIFILE21
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

rem ==========
rem %1
rem %2
:FILEDELETE
if exist "%~1" (
	call :LOGINFO "FILE DELETE '%~1' ..."
	del /f "%~1"
) else (
	call :LOGERROR "FILE '%~1' - NO EXIST"
)
goto :eof

rem ABBALibraryCmdDirEnd

rem ABBALibraryCmdLogStart
rem ==========
:LOGLINE0
echo ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
goto :eof

:LOGLINE1
echo ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
goto :eof

:LOGLINE2
echo รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
goto :eof

rem ==========
:LOG
call :LOGSTR  "     " "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%" "[97m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGINFO
call :LOGSTR  "INFO " "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%" "[92m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGINFO2
call :LOGSTR  "INFO " "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%" "[93m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGWARNING
call :LOGSTR  "INFO " "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%" "[95m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGDEBUG
 if "%DEBUG%"== "0" goto :eof
 call :LOGSTR  "DEBUG" "%~1"
 call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%" "[94m"
 call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
rem )
goto :eof

rem ==========
:LOGERROR
call :LOGSTR  "ERROR" "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%" "[91m"
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
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

:LOGSTART
call :LOGSTR  "     " "%~1"
call :LOGFILE "%dt% --------------------------------------------------------------------------------------------------------------------"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ABBALibraryCmdLogEnd
goto :eof

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdInstallStart

:CMDINSTALL
 echo off
 echo .
 echo [32mStart '%~0' ...[0m

 rem echo "%~0"
 rem echo "%USERPROFILE%\.spbcmd\%~0"

 set filenamecmdfull=%~dpnx0
 set filenamecmd=%~nx0
 set pathcmd=%USERPROFILE%\.spbcmd

 echo .. "%~dp0"
 echo .. "!pathcmd!"

 if "%~dp0" == "!pathcmd!\" (
  echo [31mError install path '%~dp0' [0m
  echo .
  echo [32mEnd '%~0' ...[0m
  exit 2
  goto :eof
 )

 echo .
 call :LOGINFO2 "   PATH"
 echo off
 for %%G in ("%path:;=" "%") do (
  rem echo %%G
  if "%pathcmd%" == %%G (
    set pathcmd1=%%G
  )
 )

 if not defined pathcmd1 (
  echo . ฎก ขซฅญจฅ ข PATH ฏใโจ '%pathcmd%' คฎ ชฎฌ ญค
  rem setx path "%path%;%pathcmd%" -- ญฅ จแฏฎซ์งฎข โ์ ฎฃเ ญจ็ฅญจฅ 1024 แจฌขฎซ 
  echo on
  rem powershell -version 5 -Command { $PATH=[Environment]::GetEnvironmentVariable("PATH") & $my_path = "%pathcmd%"; [Environment]::SetEnvironmentVariable("PATH", "$PATH;$my_path", "User") }
  powershell -version 5 -Command "& { $PATH=[Environment]::GetEnvironmentVariable('PATH'); [Environment]::SetEnvironmentVariable('PATH', $PATH+';%pathcmd%', 'User'); }"
  echo off
  call :LOGWARNING "----------------------------------------------------------------------------------------------------"
  call :LOGWARNING "---                                                              ---"
  call :LOGWARNING "----------------------------------------------------------------------------------------------------"
  echo .
  timeout 5 /nobreak
  pause
  echo off
  rem exit 2
  rem goto :eof
 ) else (
  call :LOGINFO2 " = '%pathcmd%'"
)

 rem tasklist.exe /fo csv /nh /fi "imagename eq far.exe"
 rem @for /f %%i in ('set "x=%~f0"^& call wmic process where "CommandLine like '%%%%x:\=\\%%%%'" get ProcessId^| findstr [0-9]') do @set PID=%%i& call echo %%PID%%& pause>nul& exit /b
 
 echo off
 rem exit 2
 rem goto :eof

 echo .
 rem echo '!filenamecmdfull!'
 rem echo '!pathcmd!\!filenamecmd!'
 echo Install to '!pathcmd!'

 echo .
 echo Copy '!filenamecmdfull!' to '!pathcmd!\!filenamecmd!'
 copy /y "!filenamecmdfull!" "!pathcmd!\!filenamecmd!"

 echo .
 rem dir run_git.cmd.*.cmd
 echo Copy "%~dp0!filenamecmd!.*.cmd" to "!pathcmd!"
 xcopy "%~dp0!filenamecmd!.*.cmd" "!pathcmd!" /Y /F

 rem echo .
 rem echo Copy '.mygitini' to '!pathcmd!\.mygitini'
 rem copy /y ".mygitini" "%USERPROFILE%\.mygitini"

 echo .
 echo ๋ขฎค แฏจแช  ไ ฉซฎข จ ฏฎคช โ ซฎฃฎข ข ช โ ซฎฃฅ !pathcmd! ...
 cd !pathcmd!
 dir /w

 echo .
 echo [32mEnd '%~0' ...[0m

 echo .
 if not defined pathcmd1 (
  timeout 5 /nobreak
  pause
 )

goto :eof

rem ==========
:ECHOFILE
rem %~1 %~2
echo %~1 >> %~2
goto :eof

rem ==========
rem  
:GETPARENTFOLDER
 rem call :LOGDEBUG "CALL '%0'"
 rem call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"
 set FILEVBS1=%CD%\File%RANDOM%.vbs
 rem call :LOGDEBUG "FILEVBS1 = %FILEVBS1%"
 rem call :FILEDELETE "%FILEVBS1%"
 call :ECHOFILE "Rem WScript.Echo "Run_CreateShortcut"" "%FILEVBS1%"
 call :ECHOFILE "Set objFSO = CreateObject("Scripting.FileSystemObject")" "%FILEVBS1%"
 call :ECHOFILE "RootDir = objFSO.GetParentFolderName(WScript.ScriptFullName)" "%FILEVBS1%"
 call :ECHOFILE "Set objF4 = objFSO.getFolder(RootDir)" "%FILEVBS1%"
 call :ECHOFILE "WScript.Echo (objF4.Name)" "%FILEVBS1%"
 rem cscript //nologo //E:VBScript "%FILEVBS1%"
 for /F "delims=" %%a in ('cscript //nologo //E:VBScript "%FILEVBS1%"') do (
	rem echo %%a
	set PARENTFOLDER=%%a
   )
 rem call :FILEDELETE "%FILEVBS1%"
 if exist "%FILEVBS1%" ( del "%FILEVBS1%")
 rem call :LOG "PARENTFOLDER = %PARENTFOLDER%"
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ABBALibraryCmdInstallEnd

goto :eof

