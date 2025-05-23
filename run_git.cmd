@rem run_git.cmd
@echo off
chcp 866 >nul
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0%~x0.log
set file_name=%~n0

if "%2"=="" (
 rem set file_log=%~dp0%~n0%~x0.log
 rem set file_name=%~n0
 set file_log=%cd%\%~n0%~x0.1.log
) else (
 set file_log=%~2
 rem set file_name=%~n2
)

set MAINTITLE=%~n0 - เฎฃเ ฌฌ  คซ๏ ใฏเ ขซฅญจ๏ เฅฏฎงจโฎเจ๏ฌจ.

rem ---------------------------------------------------------------------------------------
call :LOGLINE1
call :LOGSTART "START '%~0'"
call :LOGINFO "LOG FILE - '%file_log%'"
call :LOGDEBUG "MAINTITLE = '%MAINTITLE%'"
title %MAINTITLE%
rem call :LOGINFO " : '%CD%'"
call :LOGINFO "  : %RANDOM%"
call :LOGCALLSTART "%~0" "1"

rem ----------  ----------
call :LOGLINE2
if defined DEBUG (
 rem call :LOGLINE2
 rem set DEBUG=1
 rem echo .DEBUG=%DEBUG%
 call :LOGINFO2		"DEBUG = '%DEBUG%'"

 if "!DEBUG!"=="1" (
  call :LOGINFO2 "  - "
  call :LOGLINE2
  call :LOGINFO		"TEST INFO	..."
  call :LOGINFO2	"TEST INFO2	..."
  call :LOGERROR	"TEST ERROR	..."
  call :LOGDEBUG	"TEST DEBUG	..."
  call :LOGWARNING	"TEST WARNING	..."

  rem call :LOGLINE2
  rem call :LOGCALLSTART
  rem call :LOGCALLEND
  rem call :LOGCALLEND %0

  call :LOGCALLSTART "%~0"
  call :LOGCALLEND "%~0" "%ERRORLEVEL%"

 ) else (
  call :LOGINFO2 "  - "
 )

) else (
 rem echo .DEBUG NO DEFINED
 call :LOGWARNING "DEBUG NO DEFINED"
)
rem ----------  ----------

call :LOGLINE2
rem root dir
set ROOTDIR=%CD%
call :LOGDEBUG "ROOTDIR = '!ROOTDIR!' ..."
call :LOGINFO " : '!ROOTDIR!'"
call :CHANGEDIR "%ROOTDIR%"

call :LOGLINE2
call :LOGINFO2 " "

call :FINDZIP
call :FINDWGET
rem call :FINDRCLONE

call :FINDGIT
if %ERRORLEVEL% GTR 0 ( goto :FINDFAILURE)

call :FINDGITHUBCLI
if %ERRORLEVEL% GTR 0 ( goto :FINDFAILURE)

rem call :LOGLINE2
rem call :LOGINFO "ZIPEXE    = '%ZIPEXE%'"
rem call :LOGINFO "WGETEXE   = '%WGETEXE%'"
rem call :LOGINFO "RCLONEEXE = '%RCLONEEXE%'"
rem call :LOGINFO "GITEXE    = '%GITEXE%'"
rem call :LOGINFO "GHEXE     = '%GHEXE%'"

rem echo 0 = '%~0'
rem echo 1 = '%~1'

if "%~1" == "" (
 call :LOGLINE2
 call :LOGTEST " '%~n0%~x0' ญฅ 'run_git.cmd'"
 if not "%~n0%~x0"=="run_git.cmd" (
  call :LOGTEST " - OK"
  call :RUNAUTOCMD "%~n0%~x0"
  if %ERRORLEVEL% GTR 0 ( goto :FAILURE )

  goto :END
 )
)

if "%~1" == "" (
 rem call :gitinfo
  call :LOGLINE2
  call :LOGWARNING " ------------------------------------------------------------------------------------------"
  call :LOGWARNING " ---                                                                          ---"
  call :LOGWARNING " --- :                                                                           ---"
  call :LOGWARNING " --- %~n0 help                                                                       ---"
  call :LOGWARNING " ---                                                          ---"
  call :LOGWARNING " ------------------------------------------------------------------------------------------"
  rem call :LOGLINE3
 goto :end
)

if "%~1" == "help" (
 call :help %~n0
 goto :end
)

if "%~1" == "install" (
 call :CMDINSTALL "%~dp0%~n0%~x0"
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
rem call :LOGDEBUG "  :"
rem set /p REPONAME=
rem set REPONAME=!PARENTFOLDER!
rem call :LOG " :"
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

set file_scan_ini=%cd%\run_git.cmd.auto.scan.ini

if "%~1" == "autoscangit" (
 call :LOG "FILE_SCAN_INI = '%file_scan_ini%'"
 call :AUTOSCANGIT %file_scan_ini% %3 %4 %5
 goto :end
)

if "%~1" == "autoscanrun" (
 call :AUTOSCANRUN %file_scan_ini% %3 %4 %5
 goto :end
)

echo off
rem call :GITREADINIFILE
echo off

if "%~1" == "info" (
 call :info
 goto :end
)

if "%~1" == "test" ( 
 call :LOGLINE2
 call :LOGWARNING "------------------------------------------------------------------------------------------"
 call :LOGWARNING "  "
 call :LOGWARNING "------------------------------------------------------------------------------------------"

 call :LOGWARNING "'%~0' '%~1' '%~2' '%~3' '%~4' '%~5' '%~6'"

 call :FINDFILE "wget.exe" "WGETEXE2"
 if !ERRORLEVEL! GTR 0 ( goto :FINDFAILURE)

 if not "%~3"=="" (
  call :FINDFILE "%~3" "TESTEXE"
  if !ERRORLEVEL! GTR 0 ( goto :FINDFAILURE)
 )

 goto :end
)

if "%~1" == "test2" ( 
 call :LOGWARNING "------------------------------------------------------------------------------------------"
 call :LOGWARNING "  "
 call :LOGWARNING "------------------------------------------------------------------------------------------"
 set ERRORLEVEL=200
 goto :FAILURE
)

call :LOGLINE2
call :LOGTEST "    '%CD%' "
if not exist .git (
 if not "%~1" == "gitinit" (
  call :LOGLINE3
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGWARNING "      "
  call :LOGWARNING "    "
  call :LOGWARNING "  'run_git.cmd.git.init.cmd' "
  call :LOGWARNING "   'run_git.cmd gitinit' "
  call :LOGWARNING "------------------------------------------------------------------------------------------" 
  call :LOGLINE3
  set ERRORLEVEL=100
  goto :FAILURE
 )
)

call :LOGTEST " - OK"
call :GETPARENTFOLDER
call :LOGDEBUG " : '!PARENTFOLDER!'"
set REPONAME=!PARENTFOLDER!
call :LOGINFO " REPONAME: '!REPONAME!'"

call :LOGLINE2
call :LOGINFO2 "RUN COMMAND '%1' ..."

if "%~1" == "gitinfo" (
 call :gitinfo
 goto :end
)

if "%~1" == "gitinit" (
:GITINITL1
 call :LOGINFO "      '!ROOTDIR!'"

 if exist .git (
 call :LOGTEST "   '!REPONAME!'    Y/N"

 rem echo [2F[60G.
 echo . ฎฏเฎแ Y/N /
 set /p ASK1=
 echo .

 rem echo !ASK1!

 if "!ASK1!"=="Y" goto :GITINITL2
 if "!ASK1!"=="y" goto :GITINITL2
 if "!ASK1!"=="" goto :GITINITL2
 if "!ASK1!"=="ค" goto :GITINITL2

 call :LOGWARNING " ------------------------------------------------------------------------------------------"
 call :LOGWARNING " ---                                                                    ---"
 call :LOGWARNING " ------------------------------------------------------------------------------------------"

 goto :end


 :GITINITL2
  call :LOGWARNING " ------------------------------------------------------------------------------------------"
  call :LOGWARNING " ---   '!REPONAME!'"
  call :LOGWARNING " ------------------------------------------------------------------------------------------"
  echo . 
  echo rmdir /s /q "!ROOTDIR!\.git"
  rmdir /s /q "!ROOTDIR!\.git"
  echo .

)

  call :GITINITFILES "%~dp0%~n0%~x0" "%ROOTDIR%"
  call :GITINIT
  rem call :GETGITHUBOWNER
  rem call :LOGINFO "REPONAME: '!REPONAME!'"
  rem set OWNER=
  rem call :GETGITHUBOWNER 
  rem call :LOGINFO "OWNER:    '!OWNER!'"
  rem call :GITAUTOCOMMIT
  rem call :GITREMOTEADD !OWNER! !REPONAME!
  rem call :GITHUBCREATE "!REPONAME!"
  rem if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
  rem call :GITAUTOPUSH
  rem if !ERRORLEVEL! GTR 0 ( goto :FAILURE )

 
goto :end
)

rem --------------------------------------------------------------------------------------------------------------
if "%~1" == "gitinitremote" (
rem [remote "tnas1"]
rem url = ssh://git@192.168.88.12:9222/mnt/DISK4/1_REPO/mywingitmain.git
rem fetch = +refs/heads/*:refs/remotes/tnas1/*
rem ssh -p 9222 git@192.168.88.12 "cd /mnt/DISK4/1_REPO && ls"

 set gitremote=192.168.88.12
 call :LOGINFO "     '!REPONAME!'   '!gitremote!'"

 echo .
 echo on
 ssh -p 9222 git@!gitremote! "cd /mnt/DISK4/1_REPO && mkdir !REPONAME!.git && cd !REPONAME!.git && git init --bare && ls"
 @echo off
 echo .

 goto :end
)
rem --------------------------------------------------------------------------------------------------------------

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

rem --------------------------------------------------------------------------------------------------------------
rem  

call :GETGITHUBOWNER 
call :LOGINFO "REPONAME: '!REPONAME!'"
call :LOGINFO "OWNER:    '!OWNER!'"
rem set REPONAME=!PARENTFOLDER!

if "%~1" == "autocommit" (
 call :GITAUTOCOMMIT %3
 goto :end
)

if "%~1" == "autopush" (
 call :GITAUTOPUSH
 goto :end
)

if "%~1" == "autopull" (
 call :GITAUTOPULL %3
 goto :end
)

if "%~1" == "autocommitpush" (
 call :GITAUTOCOMMITPUSH
 rem call :LOGWARNING " 1"
 rem call :GITAUTOCOMMIT %3
 rem call :LOGWARNING " 2"
 rem call :GITAUTOPUSH
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

rem ---------- GitHub Command

if "%~1" == "githubauth" (
 call :GITHUBAUTH
 if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
 goto :end
)

if "%~1" == "githubauthstatus" (
 call :GITHUBAUTHSTATUS
 if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
 goto :end
)

if "%~1" == "githubauthswitch" (
 call :GITHUBAUTHSWITCH
 if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
 goto :end
)

if "%~1" == "githubauthlogin" (
 call :GITHUBAUTHLOGIN
 if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
 goto :end
)

if "%~1" == "githubauthlogout" (
 call :GITHUBAUTHLOGOUT
 if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
 goto :end
)

if "%~1" == "githubauthrefresh" (
 call :GITHUBAUTHREFRESH
 if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
 goto :end
)

if "%~1" == "githubcreate2" (
 call :LOGINFO "REPONAME: '!REPONAME!'"
 call :LOGINFO "OWNER:    '!OWNER!'"
 call :GITHUBCREATE "!OWNER!/!REPONAME!"
 if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
 goto :end
)

if "%~1" == "githubdelete2" (
 call :LOGINFO "REPONAME: '!REPONAME!'"
 call :LOGINFO "OWNER:    '!OWNER!'"
 call :GITHUBDELETE "!OWNER!/!REPONAME!"
 if !ERRORLEVEL! GTR 0 ( goto :FAILURE )
 goto :end
)

if "%~1" == "githubdelete" (
 call :GITHUBDELETE %2
 goto :end
)
rem ---------- GitHub Command

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
 call :GITREMOTEADD "!GITUSERNAME!" "!REPONAME!"
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
 call :GITHUBCREATE "!REPONAME!"
 goto :end
)

call :LOGERROR "  '%~1'"
set errorlevel=1
goto FAILURE

rem ABBAProgrammMainEnd1
:END
 set MEMERRORLEVEL=!ERRORLEVEL!
 call :LOGLINE2
 call :LOGDEBUG "ERRORLEVEL %MEMERRORLEVEL%"
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%" "1"
 call :LOGLINE0
 exit /b %MEMERRORLEVEL%
goto :eof

rem ABBAProgrammMainEnd2
:FAILURE
 set MEMERRORLEVEL=!ERRORLEVEL!
 call :LOGLINE2
 call :LOGDEBUG "ERRORLEVEL %MEMERRORLEVEL%"
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%" "1"
 call :LOGLINE0
 exit /b %MEMERRORLEVEL%
goto :eof
rem ABBAProgrammEnd

rem ==========
:END2
 endlocal
 exit /b /0
goto :eof

rem ==========
:FINDFAILURE
 call :LOGLINE2
 call :LOGWARNING "------------------------------------------------------------------------------------------"
 call :LOGWARNING "      "
 call :LOGWARNING " "
 call :LOG        " **Git for Windows**	'https://git-scm.com/download/win' "
 call :LOG        " 'https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.1/Git-2.47.1-64-bit.exe' "
 call :LOG        " 'winget install --id Git.Git -e --source winget' "
 call :LOG        " "
 call :LOG        " **GitHub CLI**	'https://cli.github.com' "
 call :LOG        " 'https://github.com/cli/cli/releases/download/v2.64.0/gh_2.64.0_windows_amd64.msi' "
 call :LOGWARNING " "
 call :LOGWARNING "------------------------------------------------------------------------------------------"
 goto :FAILURE
goto :eof



rem ==========
:help
 call :LOGLINE2
 call :LOGCALLSTART "%0"
 call :LOGINFO "แฏฎซ์งฎข ญจฅ: "
 call :LOGINFO "    '%~1' [] [] "
 call :LOGINFO " "
 call :LOGINFO "ฎฌ ญค๋: "
 call :LOGINFO "    create folder       - แฎงค ญจฅ ซฎช ซ์ญฎฃฎ เฅฏฎงจโฎเจ๏ ข ช โ ซฎฃฅ folder"
 call :LOGINFO "                          ข ช โ ซฎฃ ชฎฏจเใฅโ ขแฅ ญฅฎกๅฎคจฌฎฅ, "
 call :LOGINFO "                          ฏฎแซฅ แฎงค ญจ๏ ขแฅ ข๋งฎข๋ ญ คฎ คฅซ โ์ จง folder "
 call :LOGINFO "    createmaster        - แฎงค ญจฅ ฃซ ขญฎฃฎ เฅฏฎงจโฎเจ๏ ญ  GitHub, คซ๏ ๅเ ญฅญจ๏ ํโจๅ ใโจซจโ "
 call :LOGINFO " "
 call :LOGINFO " ฎฌ ญค๋ เ กฎโ  แ เฅฏฎงจโฎเจ๏ฌจ:"
 call :LOGINFO "    gitinit             - แฎงค ญจฅจ จ จญจญๆจ ซจง ๆจ๏ เฅฏฎงจโฎเจ๏ ข โฅชใ้ฅฉ ฏ ฏชฅ "
 call :LOGINFO "    autopush            - ฎโฏเ ขซ๏ฅโ ขแฅ จงฌฅญฅญจ๏ ข ใค ซฅญญ๋ฉ เฅฏฎงจโฎเจ๏ ญ  GitHub "
 call :LOGINFO "    autocommit		-  ขโฎชฎฌฌจโ ข โฅชใ้ฅฉ ค โฎฉ จ ขเฅฌฅญจฌ "
 call :LOGINFO "    remoteadd           - คฎก ขซฅญจฅ ใค ซ๑ญญ๋ๅ เฅฏฎงจโฎเจฅข"
 call :LOGINFO "    gitbranch           - ชฎฌ ญค  คซ๏ ใฏเ ขซฅญจ๏ ขฅโช ฌจ ข เฅฏฎงจโฎเจจ Git"
 call :LOGINFO " "
 call :LOGINFO " ฎฌ ญค๋ คซ๏ GitHub:"
 call :LOGINFO "    createhub           - แฎงค ญจฅ ใค ซฅญญฎฃฎ เฅฏฎงจโฎเจ๏ ญ  GitHub, คซ๏ ๅเ ญฅญจ๏ แฎงค ญญฎฃฎ "
 call :LOGINFO "    githubcreate        - แฎงค ญจฅ ใค ซฅญญฎฃฎ เฅฏฎงจโฎเจ๏ ญ  GitHub, คซ๏ ๅเ ญฅญจ๏ แฎงค ญญฎฃฎ "
 call :LOGINFO "    githubdelete        - ใค ซฅญจฅ เฅฏฎงจโฎเจ๏ ญ  GitHub"
 call :LOGINFO " "
 call :LOGINFO "    info                - ญไฎเฌ ๆจ๏, ชฎฌ ญค  ฏฎ ใฌฎซ็ ญจ๎ "
 call :LOGINFO "    help                - ฎช ง โ์ ํโใ แฏเ ขชใ จ ข๋ฉโจ "
 call :LOGINFO " "

 call :LOGCALLEND "%0" "%ERRORLEVEL%"

goto :eof

rem ==========
:RUNAUTOCMD
 call :LOGCALLSTART "%~0"

 rem call :GETCMDVAR "%~n0"
 rem if errorlevel 1 goto :FAILURE
 rem echo "%~1"
 rem run_git.cmd.auto.commit.cmd
 rem run_git.cmd.auto.commit.push.cmd
 rem for /f "tokens=1,2,3,4,5,6,7 delims=." %%a in ("%~n0%~x0") do (

 for /f "tokens=1,2,3,4,5,6,7 delims=." %%a in ("%~1") do (
  rem echo 1 - '%%a'
  rem echo 2 - '%%b'
  rem echo 3 - '%%c'
  rem echo 4 - '%%d'
  rem echo 5 - '%%e'
  rem echo 6 - '%%f'
  rem echo 7 - '%%g'
 
  call :LOGWARNING "'%%a' '%%b' '%%c' '%%d' '%%e' '%%f' '%%g'"

  if not "%%a"=="run_git" (
	set ERRORLEVEL=1
	goto :RUNAUTOCMD1
  )

  if not "%%b"=="cmd" (
	set ERRORLEVEL=2
	goto :RUNAUTOCMD1
  )

  if not "%%c"=="auto" (
	set ERRORLEVEL=3
	goto :RUNAUTOCMD1
  )

 rem run_git.cmd.auto.commit.cmd
  set CMDVAR=%%d

 rem  if "%%e"=="cmd" (
 rem	set ERRORLEVEL=1
 rem	goto :FAILURE
 rem  )

  rem run_git.cmd.auto.commit.push.cmd
  if not "%%e"=="cmd" (
	set CMDVAR=!CMDVAR!.%%e

  	if not "%%f"=="cmd" (
		set ERRORLEVEL=4
		goto :RUNAUTOCMD1
	  )

  )


)

 call :LOGWARNING " "
 call :LOGWARNING " CMDVAR           = '!CMDVAR!' "
 call :LOGWARNING " "
 call :LOGWARNING " ------------------------------------------------------------------------------------------"
 call :LOGWARNING "   "
 call :LOGWARNING " ------------------------------------------------------------------------------------------"
 call :LOGWARNING " "

 if "!CMDVAR!"=="commit" (
  call :GITAUTOCOMMIT
  goto :RUNAUTOCMD1
 )

 if "!CMDVAR!"=="push" (
  call :GITAUTOPUSH
  goto :RUNAUTOCMD1
 )

 if "!CMDVAR!"=="commit.push" (
  call :GITAUTOCOMMITPUSH
  goto :RUNAUTOCMD1
 )

 (
  call :LOGERROR "  '!CMDVAR!' ..."
  set ERRORLEVEL=5
 )

:RUNAUTOCMD1
set MEMERRORLEVEL=!ERRORLEVEL!
call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:gitscan
 call :LOGLINE2
 rem call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO " "
 call :FINDGIT
 call :FINDGITHUBCLI
 call :LOGINFO2 "    '%CD%'..."
 
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
 call :LOGINFO2 "  "

 call :GETPARENTFOLDER
 set REPONAME=!PARENTFOLDER!
 call :LOGINFO2 ":                   '!REPONAME!'"

 call :GETGITHUBOWNER 
 if not defined OWNER goto :FAILURE
 call :LOGINFO2  ":                   '%OWNER%'"

 call :LOGLINE2 
 call :LOGINFO2 "GIT CONFIG GLOBAL"
 for /f "tokens=1* delims==" %%a in ('"git config --global --get user.name"') do ( call :LOGINFO2 " :           '%%a'")
 for /f "tokens=1* delims==" %%a in ('"git config --global --get user.email"') do ( call :LOGINFO2 ".:                   '%%a'")

 if exist .git (
  call :LOGLINE2 
  call :LOGINFO2 "GIT CONFIG LOCAL"
  for /f "tokens=1* delims==" %%a in ('"git config --local --get user.name"') do ( call :LOGINFO2 " :           '%%a'")
  for /f "tokens=1* delims==" %%a in ('"git config --local --get user.email"') do ( call :LOGINFO2 ".:                   '%%a'")

  call :LOGLINE2 
  call :LOGINFO2 "GIT CONFIG WORKTREE"
  for /f "tokens=1* delims==" %%a in ('"git config --worktree --get user.name"') do ( call :LOGINFO2 " :           '%%a'")
  for /f "tokens=1* delims==" %%a in ('"git config --worktree --get user.email"') do ( call :LOGINFO2 ".:                   '%%a'")

  call :LOGLINE2 
  call :LOGINFO2 "GIT CONFIG"
  for /f "tokens=1* delims==" %%a in ('"git config --get user.name"') do ( call :LOGINFO2 " :           '%%a'")
  for /f "tokens=1* delims==" %%a in ('"git config --get user.email"') do ( call :LOGINFO2 ".:                   '%%a'")


  call :LOGLINE2 
  call :LOGINFO2 "GIT     ,   :"
  echo .
  "%GITEXE%" remote -v
  echo .

  call :LOGLINE2 
  call :LOGINFO2 "GIT STATUS"
  echo .
  "%GITEXE%" status --verbose
  echo .

 ) else (
  call :LOGLINE3
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGWARNING "      "
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGLINE3
 )

 rem for /f "tokens=1* delims==" %%a in ('"git config --get remote.origin.url"')	do ( call :LOGINFO2 "URL:                        '%%a'")
 rem for /f "tokens=1* delims==" %%a in ('"git rev-parse --abbrev-ref HEAD"')	do ( call :LOGINFO2 "  :     '%%a'")

 rem call :GITCONFIGSAFEDIRECTORY

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

:info
 call :LOGLINE2
 call :LOGCALLSTART %0
 rem call :LOGCALLEND %0 0
 rem call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO2 ""
 call :LOGINFO2 "WGET VERSION"
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
  call :LOGINFO2 "!str1!"
 )
)
 echo off

 call :LOGINFO2 "GIT VERSION"
 echo .
 "%GITEXE%" --version
 echo .

 call :LOGINFO2 "GITHUB VERSION"
 echo .
 "%GHEXE%" --version
 echo .

 call :LOGINFO2 "         GitHub."
 echo .
 "%GHEXE%" auth status
 echo .

 if exist .git (
 call :LOGINFO2 "GIT     ,   :"
 echo .
 "%GITEXE%" remote -v
 echo .

 call :LOGINFO2 "GIT STATUS"
 echo .
 "%GITEXE%" status --verbose
 echo .

 ) else (
  call :LOGLINE3
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGWARNING "      "
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGLINE3
 )

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
 call :LOGCALLEND %0 "%ERRORLEVEL%"
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
  call :LOGWARNING "      GitHub   'GIT INIT'"
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
:GITINITFILES
 call :LOGLINE2
 call :LOGCALLSTART %0
 call :LOGINFO "    ..."
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 set pathfiles1=%~dp1GitCopyFiles
 set pathfiles2=%~2
 call :LOGINFO "PATHFILES1 = '!pathfiles1!'"
 call :LOGINFO "PATHFILES2 = '!pathfiles2!'"

 echo .
 for %%i in ( "LICENSE.txt", "README.md", ".gitignore ", ".gitattributes") do (
  if not exist "!pathfiles2!\%%~i" (
   echo COPY '!pathfiles1!\%%~i' to '!pathfiles2!\%%~i'
   copy /y "!pathfiles1!\%%~i" "!pathfiles2!\%%~i"
  ) else (
  echo . !pathfiles2!\%%~i - EXIST
)
 )
 echo .

 call :LOGCALLEND %0 "%ERRORLEVEL%"
goto :eof

rem ==========
:GITINIT
 call :LOGCALLSTART "%~0"
 call :LOGINFO "    ..."

rem ------------------------------------------------------------------------
rem create a new repository on the command line
rem echo "# test1" >> README.md
rem git init
rem git add README.md
rem git commit -m "first commit"
rem git branch -M main
rem git remote add origin https://github.com/VArtamonov/test1.git
rem git push -u origin main
rem ------------------------------------------------------------------------
rem push an existing repository from the command line
rem git remote add origin https://github.com/VArtamonov/test1.git
rem git branch -M main
rem git push -u origin main
rem ------------------------------------------------------------------------

 echo .
 "%GITEXE%" init

 echo .
 "%GITEXE%" add . --verbose

 echo .
 call :GET_DT
 call :LOGDEBUG "CREATE TIMESTAMP '%DT%'"
 "%GITEXE%" commit -a -m "First commit '%dt%'" --verbose

 echo .
 git branch -M main --verbose

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITREMOTEADD
 call :LOGLINE2
 call :LOGCALLSTART %0
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
 
 call :LOGINFO " GIT -  '๐ ' - "
 @echo on
 @echo .
 "%GITEXE%" remote --verbose remove origin
 @echo .
 @echo off

 call :LOGINFO " GIT -  '๐ ' - 'https://github.com/%~1/%~2.git' "
 @echo on
 @echo .
 "%GITEXE%" remote --verbose add origin https://github.com/%~1/%~2.git
 @echo off
 @echo .

 call :LOGINFO " GIT -     - "
 @echo on
 @echo .
 "%GITEXE%" branch --verbose -a
 @echo .
 @echo off

 call :LOGCALLEND %0 "%ERRORLEVEL%"
goto :eof

rem ==========
:GITAUTOCOMMIT
 rem call :LOGLINE2
 call :LOGCALLSTART "%~0"
 call :LOGINFO "GIT ADD AUTO COMMIT ..."
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :LOGDEBUG "ADD ALL FILES ..."

 echo .
 "%GITEXE%" add . --verbose
 echo .

 call :GET_DT
 rem call :LOGDEBUG "CREATE TIMESTAMP '%DT%'"
 
 for /f "tokens=1* delims==" %%a in ('"whoami.exe"') do ( set hostuser=%%a )
 call :LOGINFO2 "  :           '!hostuser!'"

 if "%~1" == "" (
  rem set COMMITTXT=The autocommit has been added to '%dt%'
  set COMMITTXT=The autocommit has been added to '%dt%' from '!hostuser!'
  call :LOGINFO "COMMITTXT '!COMMITTXT!'"
 ) else (
  set COMMITTXT=Commit '%~1' has been added to '%dt%' from '!hostuser!'
  call :LOGINFO "COMMITTXT '!COMMITTXT!'"
 )

 echo .
 "%GITEXE%" commit -a -m "!COMMITTXT!" --verbose
 rem @echo ERRORLEVEL = %ERRORLEVEL%
 echo .

 rem call :LOGDEBUG "GIT STATUS ..."
 rem "%GITEXE%" status --verbose

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "!MEMERRORLEVEL!"
 exit /b %MEMERRORLEVEL%
goto :eof


rem ==========
:GITAUTOPUSH
 rem call :LOGLINE2
 call :LOGCALLSTART "%~0"
 call :LOGINFO "GIT AUTO PUSH REMOTE ..."

 echo off
 rem for /f "tokens=2 delims=:." %%a in ('"%SystemRoot%\System32\chcp.com"') do ( echo %%a )
 rem "%GITEXE%" branch"
 set BRANCH=
 for /f "tokens=1*" %%a in ('"git branch"') do ( 
  call :LOGDEBUG "GIT BRANCH '%%a' '%%b'"
  if "%%a"=="*" (
   rem echo Debug2 %%a,%%b 
    set BRANCH=%%b
    call :LOGINFO2 "BRANCH = '!BRANCH!'"
    echo .
    "%GITEXE%" push --set-upstream origin !BRANCH! --verbose
    set MEMERRORLEVEL=!ERRORLEVEL!
    echo .
  )
 )

 echo off
 rem call :LOGDEBUG "ERRORLEVEL %ERRORLEVEL%"
 rem echo %ERRORLEVEL%

 echo off

 if "!MEMERRORLEVEL!" == "128" (
 echo BRANCH = '!BRANCH!'
 echo ERRORLEVEL = %ERRORLEVEL%
 echo MEMERRORLEVEL = !MEMERRORLEVEL!
 if not "!BRANCH!"=="master" ( 
   echo .
   "%GITEXE%" push --set-upstream origin --verbose 
   echo .
  )
  echo off
  rem if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
  rem call :LOGDEBUG "ERRORLEVEL %ERRORLEVEL%"
 )

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITAUTOPULL
 rem call :LOGLINE2
 call :LOGCALLSTART "%~0"
 call :LOGINFO "GIT PULL ..."
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 echo .
 "%GITEXE%" pull --verbose
 echo .

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITAUTOCOMMITPUSH
 rem call :LOGLINE2
 call :LOGCALLSTART "%~0"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :LOGWARNING "%~0 - START"

 call :LOGWARNING "%~0 -  1"
 call :GITAUTOCOMMIT
 if %ERRORLEVEL% GTR 0 ( goto :GITAUTOCOMMITPUSH1)
 rem call :LOGLINE2

 call :LOGWARNING "%~0 -  2"
 call :GITAUTOPUSH
 rem call :LOGLINE2

 call :LOGWARNING "%~0 - END"

:GITAUTOCOMMITPUSH1
 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof


rem ==========
:GITHUBAUTH
 call :LOGCALLSTART "%~0"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 echo .
 echo "%GHEXE%" auth status
 call :GITHUBAUTHSTATUS
 echo .

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITHUBAUTHSWITCH
 call :LOGCALLSTART "%~0"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 echo .
 echo "%GHEXE%" auth switch
 "%GHEXE%" auth switch 
 echo .

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof


rem ==========
:GITHUBAUTHSTATUS
 call :LOGCALLSTART "%~0"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 rem echo .
 rem "%GHEXE%" auth status

 echo .
 echo "%GHEXE%" auth status

 set count1=1
 set gstatus1=0
 set gstatus2=0
 set gstatus3=0

 for /f "tokens=1,2,3,4,5,6,7,8,9* delims= " %%a in ('"%GHEXE%" auth status --hostname github.com') do ( 
  rem echo -
  rem echo a='%%a' b='%%b' c='%%c' d='%%d' e='%%e' f='%%f' g='%%g' h='%%h'

  if !count1!==1 (
   set gstatus1=%%a
  )

  if !count1! GTR 1 (

   rem echo .1
   if "%%b"=="Logged" (
   rem echo .2
    if "%%e"=="!gstatus1!" (
     rem echo .3
     set gstatus2=%%g
    )
   )

   if "%%b"=="Active" (
     rem echo .4
     if "%%d"=="true" (
      rem echo .5
      call ::LOGWARNING "Active account   '!gstatus1!' USERNAME '!gstatus2!'"
      set gstatus3=1
     ) else  (
      rem echo .6
      call ::LOGWARNING "NoActive account '!gstatus1!' USERNAME '!gstatus2!'"
     )
   )

  )

  rem echo count1=!count1!
  rem echo gstatus1=!gstatus1!
  rem echo gstatus2=!gstatus2!

  set /a count1=!count1!+1
 )

 echo .
 echo gstatus3=!gstatus3!
 if !gstatus3!==1 (
  set ERRORLEVEL=0
 ) else (
  set ERRORLEVEL=1
 )

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITHUBAUTHREFRESH
 call :LOGCALLSTART "%~0"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :GITHUBAUTH
 rem echo ERRORLEVEL=%ERRORLEVEL%
 if %ERRORLEVEL% EQU 0 (
  echo .
  gh auth refresh --hostname github.com --scopes delete_repo
  echo .
 )

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITHUBAUTHLOGIN
 call :LOGCALLSTART "%~0"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :GITHUBAUTH
 rem echo ERRORLEVEL=%ERRORLEVEL%
 if %ERRORLEVEL% EQU 1 (
  echo .
  gh auth login --git-protocol https --hostname github.com --web --scopes delete_repo
  echo .
 ) else (
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGWARNING " GITHUB ใฆฅ  ข แจแโฅฌฅ"
  call :LOGWARNING "------------------------------------------------------------------------------------------"
 )

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITHUBAUTHLOGOUT
 call :LOGCALLSTART "%~0"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :GITHUBAUTH
 rem echo ERRORLEVEL=%ERRORLEVEL%
 if %ERRORLEVEL% EQU 0 (
  echo .
  gh auth logout
  echo .
 ) else (
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGWARNING " GITHUB ใฆฅ ข๋่ซจ จง แจแโฅฌ๋"
  call :LOGWARNING "------------------------------------------------------------------------------------------"
 )

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITHUBCREATE
 call :LOGLINE2
 call :LOGINFO "CREATE REMOTE REPO ON GITHUB"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 if "%~1"=="" (
  call :LOGERROR "ARG1 = NULL"
  call :LOGDEBUG "call :GITHUBCREATE RepoName"
  set errorlevel=1
  goto FAILURE
 )

 call :GITHUBAUTH
 rem echo ERRORLEVEL=%ERRORLEVEL%
 if %ERRORLEVEL% EQU 0 (

  rem call :LOGINFO "CREATE REMOTE REPO '%OWNER%/%1' ON GITHUB AND PUSH"
  call :LOGINFO "CREATE REMOTE REPO '%~1' ON GITHUB AND PUSH"
  echo .
  rem Create a new GitHub repository.
  rem gh repo create [<name>] [flags]
  rem --private                Make the new repository private
  rem --public                 Make the new repository public
  rem "%GHEXE%" repo create --public --description "My Repo 'mywingit%~1'" -y
  rem "%GHEXE%" repo create %OWNER%/%1 --private --source=. --remote=origin
  rem "%GHEXE%" repo create %OWNER%/%1 --private --source=. --remote=origin --push
  "%GHEXE%" repo create "%~1" --private --source=. --remote=origin --push
  echo .

  call :LOGINFO "REPO '%~1' EDIT DESCRIPTION"
  echo .
  rem Edit repository settings.
  rem gh repo edit [<repository>] [flags]
  rem --description string       Description of the repository
  rem t OWNER/REPO -d "new Description"
  rem "%GHEXE%" repo edit %OWNER%/%1 --description "My Repo '%1'"
  "%GHEXE%" repo edit %~1 --description "My Repo '%1'"

  echo .
 )

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITHUBDELETE
 call :LOGCALLSTART %0
 call :LOGINFO "DELETE REMOTE REPO ON GITHUB"
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 if "%~1"=="" (
  call :LOGERROR "ARG1 = NULL"
  call :LOGDEBUG "call :GITHUBDELETE RepoName"
  set errorlevel=1
  goto FAILURE
 )

 call :GITHUBAUTH
 rem echo ERRORLEVEL=%ERRORLEVEL%
 if %ERRORLEVEL% EQU 0 (

 call :LOGINFO "  '%~1' ON GITHUB"

 echo .
 "%GHEXE%" repo delete "%~1" --yes
 echo .

)

 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:GITHUBDELETE1
 call :LOGLINE2
 call :LOGCALLSTART %0
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

 rem [remote "origin"]
 rem url = https://github.com/VArtamonov/SPB.SDK.FIRST.git
 rem for /f "tokens=1* delims==" %%a in ('"git remote get-url origin"') do (set REPOURL1=%%a) 
 echo .
 "%GHEXE%" repo delete !REPOURL1! --yes

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
 call :LOGCALLEND %0 "%ERRORLEVEL%"
goto :eof

rem ==========
:GITHUBDELETE2
 call :LOGLINE2
 call :LOGCALLSTART %0
 rem call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :GETPARENTFOLDER
 call :LOGINFO " : '!PARENTFOLDER!'"
 call :LOGINFO "  '!PARENTFOLDER!' ON GITHUB"

 echo .
 rem [remote "origin"]
 rem url = https://github.com/VArtamonov/SPB.SDK.FIRST.git
 for /f "tokens=1* delims==" %%a in ('"git remote get-url origin"') do ( set REPOURL2=%%a ) 
 if not "!REPOURL2!" == "" (
  echo . REPOURL2=!REPOURL2!
  echo .
  "%GHEXE%" auth status
  echo .
  "%GHEXE%" repo delete !REPOURL2! --yes
  echo .
  call :LOGINFO " GIT -  '๐ ' - "
  @echo on
  @echo .
  "%GITEXE%" remote --verbose remove origin
  @echo .
  @echo off
 ) else (
  echo .
  call :LOGINFO " GIT -  '๐ ' - "
 )

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )

 call :LOGCALLEND %0 "%ERRORLEVEL%"

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

rem ==========
:AUTOSCANGIT
 call :LOGLINE2
 call :LOGDEBUG "CALL %0 %1 %2 %3 %4 %5"
 call :LOGINFO2 "    '%CD%'..."
 echo off

 set scan=
 call :SCANDIR "%ROOTDIR%"
 call :LOGLINE2
 call :LOGINFO "SCAN='!scan!'"

 set autoscanini=%~dp1%~n1.ini
 call :LOG " '%autoscanini%'"
 echo ;%autoscanini% > %autoscanini%
 for /d %%i in (!scan!) do (
  call :LOG " '%%~i'"
  echo %%~i >> %autoscanini%
 )

 rem call :RUNGITCMD "!scan!"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:AUTOSCANRUN
 call :LOGLINE2
 call :LOGDEBUG "CALL 0='%0' 1='%1' 2='%2' 3='%3' 4='%4' 5='%5'"
 call :LOGINFO2 "      ..."
 echo off

 if "%~1"=="" (
  call :LOGERROR "ARG1 = NULL"
  set errorlevel=1
  goto FAILURE
 )

 if "%~2"=="" (
  call :LOGERROR "ARG2 = NULL"
  call :LOGWARNING "ARG2 = 'commit' 'push' "
  set errorlevel=1
  goto FAILURE
 )

 set autoscanini=%~dp1%~n1.ini
 call :LOGDEBUG " '%autoscanini%'"
 if exist %autoscanini% (
  call :LOGINFO " '%autoscanini%' - OK"
 
  for /F "usebackq eol=; tokens=1" %%a in (!autoscanini!) do (
   call :LOGDEBUG "%%a"

   if "%~2"=="commit" (     
    cd %%a
    call :LOGINFO "=============================================================================================================="
    call :LOGINFO " Run GIT '%%a' "
    call run_git.cmd.auto.commit.cmd "%file_log%"      
   )

   if "%~2"=="push" (     
    cd %%a
    call :LOGINFO "=============================================================================================================="
    call :LOGINFO " Run GIT '%%a' "
    call run_git.cmd.auto.push.cmd "%file_log%"      
   )

 )


 ) else (
  call :LOGERROR " '%autoscanini%' - "
  set errorlevel=1
)

 rem call :RUNGITCMD "!scan!"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

:SCANDIR
rem call :LOGDEBUG "CALL '%0' '%1' %2 %3 %4 %5"
rem echo %~1
cd "%~1"
echo off
rem echo .
for /f "tokens=*" %%i in ('"dir /a:d-s /b"') do (
  rem echo %%i
  if "%%i" == ".git" (
   rem echo [2K %~1\\.git - OK   
   rem echo .
   rem echo [1F
   call :LOGINFO " '%~1' - OK"
   rem echo scan=!scan!
    if "!scan!" == "" ( 
	set scan="%~1" 
     ) else (
	set scan=!scan!,"%~1"
	)
  ) else (
  if exist "%~1\%%i" (
   echo .1
   echo [1F[0K Scan '%~1\%%i'[1F
   call :SCANDIR "%~1\%%i"
   cd ..
  )                                                         
 )
)

echo off
goto :eof

:RUNGITCMD
call :LOGLINE2
call :LOGDEBUG "CALL %0 %1 %2 %3 %4 %5"
for /d %%i in (%~1) do (
  if exist %%i (
    if exist %%i\.git (
      cd %%i
      rem echo .
      rem echo [2K Run GIT '%%i'
      rem echo ========== '%~0' Run GIT '%%i' ==========  >> "%file_log%"
      call :LOGINFO "=============================================================================================================="
      call :LOGINFO " Run GIT '%%i' "
      call run_git.cmd.auto.commit.cmd "%file_log%"      
    )
  )
)
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
call :LOGCALLSTART "%~0"
call :LOGDEBUG "'%~0' '%~1' '%~2' '%~3' '%~4' '%~5' '%~6'"

if "%~1"=="" (
 call :LOGERROR "ARG1 = NULL"
 goto FINDFILE2
)

if "%~2"=="" (
 call :LOGERROR "ARG2 = NULL"
 goto FINDFILE2
)

rem call :LOGINFO "FIND '%~1' ..."
for %%i in ("%~1") do (set %~2=%%~$PATH:i)

if not "!%~2!" == "" (
 rem echo "!%~2!"
 goto FINDFILE1
)
 
 if not "%~3"=="" (
  for /D %%k in (%3 %4 %5 %6 %7 %8 %9) do (
   rem echo '%~1'
   set z1=%%~k\%~1
   rem echo !z1!
   if exist !z1! (
    set %~2=!z1!
    goto FINDFILE1
    )
   )
  )

call :LOGERROR "'%~1' no found"
set ERRORLEVEL=101
goto :FINDFILEEND

:FINDFILE1
call :LOG "FOUND %~2 = '!%~2!'"
set ERRORLEVEL=0

:FINDFILEEND
 echo off
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
 exit /b %MEMERRORLEVEL%
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
call :LOGINFO "DIR '%~1' ..."
if not exist "%~1" (
 call :LOGINFO2 "CREATE dir '%~1' ..."
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

set ScrColunEnd=120

rem ==========
rem                             ------------------------------------------------------------------------------------------
:LOGLINE0
echo [0mภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
goto :eof

:LOGLINE1
echo [0mฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
goto :eof                                                                                                                    
                                                                                                                             
:LOGLINE2                                                                                                                    
echo [0mรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
goto :eof                                                                                                                    

rem รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด

:LOGLINE3
echo [0mร[95mฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ[0mด[0m
goto :eof

:LOGLINE4
echo [0mร[93mฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ[0mด[0m
goto :eof

rem ==========
:LOG
call :LOGSTR  "     " "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%[0m[!colnum!Gณ" "[97m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGINFO
call :LOGSTR  "INFO " "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%[0m[!colnum!Gณ" "[92m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGINFO2
call :LOGSTR  "INFO " "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%[0m[!colnum!Gณ" "[93m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGWARNING
call :LOGSTR  "WARN " "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%[0m[!colnum!Gณ" "[95m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGDEBUG
 if defined DEBUG (
  rem echo DEBUG='!DEBUG!'
  if !DEBUG! EQU 1 (
   call :LOGSTR  "DEBUG" "%~1"
   rem echo '!dt!' '!tlogstr1!' '!tlogstr2!'
   call :LOGSCR  "ณ!dt!ณ!tlogstr1!ณ!tlogstr2![0m[!colnum!Gณ" "[94m"
   call :LOGFILE "!dt! !tlogstr1! !tlogstr2!"
  )
 )
goto :eof

rem ==========
:LOGERROR
call :LOGSTR  "ERROR" "%~1"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%[0m[!colnum!Gณ" "[91m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGTEST
call :LOGSTR  "TEST " "%~1"
rem call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%" "[96m"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%[0m[!colnum!Gณ" "[96m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGCALLSTART
rem call :LOGCALLSTART %1
@echo off
rem call :LOGDEBUG "'%~0' '%~1' '%~2' '%~3' '%~4' '%~5' '%~6'"
if not "%~1"=="" (
   if "%~2"=="" (
    call :LOGDEBUG "START: '%~1' - OK"
   ) else (
    call :LOGINFO "START: '%~1' - OK"
   )

 ) else (
  call :LOGERROR "'%~0' - CALL ERROR 1"
 )
@echo off
goto :eof

rem ==========
:LOGCALLEND
rem call :LOGCALLEND %1 %2
@echo off
rem call :LOGDEBUG "'%~0' '%~1' '%~2' '%~3' '%~4' '%~5' '%~6'"
if not "%~1"=="" (
 rem @echo .
 if not "%~2"=="" (
  rem @echo .                                                                                                                    f
  if not "%~2"=="0" ( 
   rem @echo .
    call :LOGERROR "'%~1' - ERRORLEVEL '%~2'" 
    call :LOGERROR "END: '%~1'"
   ) else (

   if "%~3"=="" (
    call :LOGDEBUG "END: '%~1' - OK"
   ) else (
    call :LOGINFO "'%~1' - ERRORLEVEL '%~2'" 
    call :LOGINFO "END: '%~1' - OK"
   )

  ) 
 ) else (
 call :LOGERROR "'%~0' - CALL ERROR 2"
)
) else (
 call :LOGERROR "'%~0' - CALL ERROR 1"
)
@echo off
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
@echo off
if "%~2"=="" (
 echo %~1[0m
 ) else (
 echo %~2%~1[0m
)
@echo off
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
call :LOGSCR "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

:LOGSTART
rem set colnum=150
set colnum=130
call :LOGSTR  "     " "%~1"
call :LOGFILE "%dt%       ------------------------------------------------------------------------------------------"
call :LOGSCR  "ณ%dt%ณ%tlogstr1%ณ%tlogstr2%[!colnum!Gณ"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ABBALibraryCmdLogEnd
goto :eof

rem ---------------------------------------------------------------------------------------
rem ABBALibraryCmdInstallStart

:CMDINSTALL
 echo off
 rem echo .
 rem echo [32mStart '%~0' ...[0m
 call :LOGLINE2
 call :LOGCALLSTART %0
 call :LOGINFO " "
 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 rem echo "%~0"
 rem echo "%USERPROFILE%\.spbcmd\%~0"

 set filenamecmdfull=%~dpnx1
 set filenamecmd=%~nx1
 set pathcmd=%USERPROFILE%\.spbcmd

 REM echo .. "%~dp0"
 REM echo .. "!pathcmd!"
 call :LOGINFO "PROGRAMM PATH = [93m'%~dp1'[0m"
 call :LOGINFO "PROGRAMM INSTALL PATH = [93m'!pathcmd!'[0m"

 if "%~dp0" == "!pathcmd!\" (
  echo [31mError install path '%~dp0' [0m
  echo .
  echo [32mEnd '%~0' ...[0m
  exit /b 2
  goto :eof
 )

 rem echo .
 call :LOGLINE2
 call :LOGINFO "   - 'PATH'"
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
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGWARNING "---                                                    ---"
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  echo .
  timeout 5 /nobreak
  pause
  echo off
  rem exit 2
  rem goto :eof
 ) else (
  call :LOGINFO " = '%pathcmd%'"
)

 rem tasklist.exe /fo csv /nh /fi "imagename eq far.exe"
 rem @for /f %%i in ('set "x=%~f0"^& call wmic process where "CommandLine like '%%%%x:\=\\%%%%'" get ProcessId^| findstr [0-9]') do @set PID=%%i& call echo %%PID%%& pause>nul& exit /b
 
 echo off
 rem exit 2
 rem goto :eof

 rem echo .
 call :LOGLINE2
 rem echo '!filenamecmdfull!'
 rem echo '!pathcmd!\!filenamecmd!'
 rem echo Install to '!pathcmd!'
 call :LOGINFO "   '!pathcmd!'"

 call :CREATEDIR "!pathcmd!"

 rem if not exist !pathcmd! (
 rem  call :LOGWARNING "  '!pathcmd!'"
 rem   md !pathcmd!
 rem  )


 rem echo .
 rem echo Copy '!filenamecmdfull!' to '!pathcmd!\!filenamecmd!'
 call :LOGINFO "  '!filenamecmdfull!'  '!pathcmd!\!filenamecmd!'"
 echo .
 echo on
 copy /y "!filenamecmdfull!" "!pathcmd!\!filenamecmd!"
 @echo off
 echo .

 rem dir run_git.cmd.*.cmd
 rem run_git.cmd.install.cmd 
 set XCOPYEXCLUDE=%~dp0!filenamecmd!.install.list-of-excluded-files.txt
 echo run_git.cmd.install.cmd > !XCOPYEXCLUDE!

 rem echo Copy "%~dp0!filenamecmd!.*.cmd" to "!pathcmd!"
 call :LOGLINE2
 call :LOGINFO "  '%~dp0!filenamecmd!.*.cmd'  '!pathcmd!'"
 echo .
 @echo on
 xcopy "%~dp0!filenamecmd!.*.cmd" "!pathcmd!" /Y /F /EXCLUDE:!XCOPYEXCLUDE!
 @echo off
 echo .

 call :LOGLINE2
 set  pathcmd21=%~dp0GitCopyFiles
 set  pathcmd22=!pathcmd!\GitCopyFiles
 call :LOGINFO "  '!pathcmd21!\*.*'"
 call :LOGINFO "                  '!pathcmd22!'"
 call :CREATEDIR "!pathcmd22!"
 echo .
 @echo on
 xcopy "!pathcmd21!\*.*" "!pathcmd22!" /Y /F /EXCLUDE:!XCOPYEXCLUDE!
 @echo off
 echo .

 set  pathcmd23=%~dp0
 call :LOGINFO "  '!pathcmd23!'"
 echo .
 @echo on
 copy /y "!pathcmd23!ProjectClean.cmd" "!pathcmd!"
 @echo off
 echo .
 
 rem echo .
 rem echo Copy '.mygitini' to '!pathcmd!\.mygitini'
 rem copy /y ".mygitini" "%USERPROFILE%\.mygitini"

 rem echo .
 rem echo ๋ขฎค แฏจแช  ไ ฉซฎข จ ฏฎคช โ ซฎฃฎข ข ช โ ซฎฃฅ !pathcmd! ...
 rem cd !pathcmd!
 rem dir /w

 rem del !XCOPYEXCLUDE!

 rem echo .
 rem echo [32mEnd '%~0' ...[0m

 rem echo .
 if not defined pathcmd1 (
  timeout 5 /nobreak
  pause
 )

call :LOGCALLEND "%0" "%ERRORLEVEL%"
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


rem ==========
rem run_rclone.test.check.cmd
rem                 ^^^^^ 
:GETCMDVAR
set cmdvar1=%~x1
set CMDVAR=%cmdvar1:~1,10%
exit /b 0
goto :eof
rem ==========
rem run_rclone.test.check.cmd
rem ^^^^^^^^^^^^^^^
:GETCMDVARINI
rem echo :GETCMDVARINI '%~1'
set cmdvar1=%~n1
call :GETCMDVARINI1 "%cmdvar1%"
rem echo :GETCMDVARINI !cmdvar1!
set CMDVARINI=!cmdvar1!
exit /b 0
goto :eof
:GETCMDVARINI1
rem echo :GETCMDVARINI1 '%~1'
set cmdvar1=%~n1
exit /b 0
goto :eof


rem ==========
:CALLANSI
rem ฏเ ขซ๏๎้จฅ ฏฎแซฅคฎข โฅซ์ญฎแโจ ANSI
rem ฎขฎชใฏญฎแโ์ แจฌขฎซฎข ESC จ [ ญ ง๋ข ๎โ CSI จซจ Control Sequence Introducer
rem ESC (ASCII: 27 / 0x1B / 033
rem [nK EL  - Erase in Line - ค ซ๏ฅโ ็ แโ์ แโเฎชจ. 
rem 				แซจ n เ ขญฎ ญใซ๎ (จซจ ฎโแใโแโขใฅโ), ฎ็จ้ ฅโ ขแ๑ ฎโ ชใเแฎเ  คฎ ชฎญๆ  แโเฎชจ.
rem 				แซจ n เ ขญฎ ฅคจญจๆฅ, ฎ็จ้ ฅโ ขแ๑ ฎโ ชใเแฎเ  คฎ ญ ็ ซ  แโเฎชจ.
rem 				แซจ n เ ขญฎ คขใฌ, ฎ็จ้ ฅโ ขแ๎ แโเฎชใ. ฎซฎฆฅญจฅ ชใเแฎเ  ญฅ ฌฅญ๏ฅโแ๏.
rem [nF CPL - Cursor Previous Line - ฅเฅฌฅ้ ฅโ ชใเแฎเ ข ญ ็ ซฎ n-ฎฉ (ฏฎ ใฌฎซ็ ญจ๎ 1-ฉ) แโเฎชจ แขฅเๅใ ฎโญฎแจโฅซ์ญฎ โฅชใ้ฅฉ.
rem [nE CNL - Cursor Next Line - ฅเฅฌฅ้ ฅโ ชใเแฎเ ข ญ ็ ซฎ n-ฎฉ (ฏฎ ใฌฎซ็ ญจ๎ 1-ฉ) แโเฎชจ แญจงใ ฎโญฎแจโฅซ์ญฎ โฅชใ้ฅฉ.
rem [nG Cursor Horizontal Absolute ฅเฅฌฅ้ ฅโ ชใเแฎเ ข แโฎซกฅๆ n.

goto :eof

exit /b 0
goto :eof
