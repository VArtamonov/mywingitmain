@rem run_git.cmd
@echo off
chcp 866 >nul
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

title mygit

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

set MAINTITLE=%~n0 - è‡Æ£‡†¨¨† §´Ô „Ø‡†¢´•≠®Ô ‡•ØÆß®‚Æ‡®Ô¨®.

rem ---------------------------------------------------------------------------------------
call :LOGLINE1
call :LOGSTART "START '%~0'"
call :LOGINFO "LOG FILE - '%file_log%'"
call :LOGDEBUG "MAINTITLE = '%MAINTITLE%'"
title %MAINTITLE%
call :LOGINFO "íÖäìôÖâ äÄíÄãéÉ: '%CD%'"
call :LOGINFO "ëãìóÄâçéÖ ÑÖëüíàóçéÖ óàëãé: %RANDOM%"
call :LOGCALLSTART "%~0"

if defined DEBUG (
 call :LOGLINE2
 rem set DEBUG=1
 rem echo .DEBUG=%DEBUG%
 call :LOGINFO2		"DEBUG = '%DEBUG%'"

 if "%DEBUG%"=="1" (
  call :LOGINFO2 "êÖÜàå éíãÄÑäà - ÇäãûóÖç"
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
  call :LOGINFO2 "êÖÜàå éíãÄÑäà - éíäãûóÖç"
 )

) else (
 rem echo .DEBUG NO DEFINED
 call :LOGDEBUG		"DEBUG NO DEFINED"
)

call :LOGLINE2
rem root dir
set ROOTDIR=%CD%
call :LOG "ROOTDIR = '!ROOTDIR!' ..."
call :CHANGEDIR "%ROOTDIR%"

call :LOGLINE2
call :LOGINFO2 "èéàëä ìíàãàí"
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

call :LOGLINE2
call :LOGTEST "èêéÇÖêäÄ '%~n0%~x0' ≠• 'run_git.cmd'"
if not "%~n0%~x0"=="run_git.cmd" (
 call :LOGTEST "èêéÇÖêäÄ - OK"
 call :RUNAUTOCMD "%~n0%~x0"
 if %ERRORLEVEL% GTR 0 ( goto :FAILURE )
 if errorlevel 0 ( goto :END )
)

if "%~1" == "" (
 rem call :gitinfo
  call :LOGLINE2
  call :LOGWARNING " ------------------------------------------------------------------------------------------"
  call :LOGWARNING " ---                               çÖí äéåÄçÑõ                                          ---"
  call :LOGWARNING " --- ÇÇÖÑàíÖ:                                                                           ---"
  call :LOGWARNING " --- %~n0 help                                                                       ---"
  call :LOGWARNING " --- Ñãü ÇõÇéÑÄ ëèêÄÇäà èé äéåÄçÑÄå                                                     ---"
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
rem call :LOG "ëéáÑÄçàÖ îÄâã '%file_name_ini%'"
rem call :GITGETCONFIG
rem call :LOGDEBUG "ÇÇÖÑàíÖ çÄáÇÄçàÖ êÖèéáàíéêàü:"
rem set /p REPONAME=
rem set REPONAME=!PARENTFOLDER!
rem call :LOG "çÄáÇÄçàÖ êÖèéáàíéêàü:"
rem call :LOG "REPONAME = !REPONAME!"
rem call :LOG "áÄèàëú Ç îÄâã '%file_name_ini%'"
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
 goto :end
)

if not exist .git (
 if not "%~1" == "gitinit" (
  call :LOGLINE3
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGWARNING " Ç ùíéâ èÄèäÖ éíëìíëíÇìÖí êÖèéáàíéêàâ "
  call :LOGWARNING " çÖéÅïéÑàåé ÖÉé ëéáÑÄíú "
  call :LOGWARNING " äéåÄçÑéâ 'run_git.cmd.git.init.cmd' "
  call :LOGWARNING " àãà äéåÄçÑéâ 'run_git.cmd gitinit' "
  call :LOGWARNING "------------------------------------------------------------------------------------------" 
  call :LOGLINE3
  goto :FAILURE
 )
)

rem call :gitinfo

call :LOGLINE2
call :GETPARENTFOLDER
call :LOGINFO "ÇÖêïçàâ äÄíÄãéÉ: '!PARENTFOLDER!'"
set REPONAME=!PARENTFOLDER!
call :LOGINFO "REPONAME: '!REPONAME!'"

call :LOGLINE2
call :LOGINFO2 "RUN COMMAND '%1' ..."

if "%~1" == "gitinfo" (
 call :gitinfo
 goto :end
)

if "%~1" == "gitinit" (
 call :LOGDEBUG "ëéáÑÄçàÖ à àçàñàÄãàáÄñàü êÖèéáàíéêàü"

 call :GETPARENTFOLDER
 call :LOGINFO "ÇÖêïçàâ äÄíÄãéÉ: '!PARENTFOLDER!'"

 call :GETGITHUBOWNER
 call :LOGINFO "REPONAME: '!REPONAME!'"
 set REPONAME=!PARENTFOLDER!

 call :GITINIT

 set OWNER=
 call :GETGITHUBOWNER 
 call :LOGINFO "REPONAME: '!REPONAME!'"
 call :LOGINFO "OWNER:    '!OWNER!'"

 call :GITHUBCREATE !REPONAME!

 call :GITINITFILES "%~dp0%~n0%~x0" "%ROOTDIR%"

 call :GITAUTOCOMMIT
 call :GITREMOTEADD !OWNER! !REPONAME!

 goto :end
)

rem call :LOGINFO "àåü èéãúáéÇÄíÖãü: '%GITUSERNAME%'"

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
rem ùíé çìÜçé

rem call :GETPARENTFOLDER
rem call :GETGITHUBOWNER 
rem call :LOGINFO "REPONAME: '!REPONAME!'"
rem call :LOGINFO "OWNER:    '!OWNER!'"
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
 rem call :LOGWARNING "òÄÉ 1"
 rem call :GITAUTOCOMMIT %3
 rem call :LOGWARNING "òÄÉ 2"
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

if "%~1" == "githubcreate2" (
 call :GITHUBCREATE !REPONAME!
 goto :end
)

if "%~1" == "githubdelete2" (
 call :GITHUBDELETE2
 goto :end
)

if "%~1" == "githubdelete" (
 call :GITHUBDELETE %2
 goto :end
)

rem --------------------------------------------------------------------------------------------------------------
rem ùíé èéäÄ çÖ çìÜçé

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

call :LOGERROR "çÖàáÇÖëíçÄü äéåÄçÑÄ '%~1'"
set errorlevel=1
goto FAILURE

rem ABBAProgrammMainEnd1


:END
set MEMERRORLEVEL=!ERRORLEVEL!
call :LOGLINE2
rem call :LOGDEBUG "ERRORLEVEL %ERRORLEVEL%"
rem call :LOGINFO "END '%~0' ..."
call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
call :LOGLINE0
exit /b %MEMERRORLEVEL%
goto :eof

rem ABBAProgrammMainEnd2
set MEMERRORLEVEL=!ERRORLEVEL!
:FAILURE
call :LOGLINE2
rem call :LOGDEBUG "ERRORLEVEL %ERRORLEVEL%"
rem call :LOGERROR "END '%~0' ..."
call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
call :LOGLINE0
exit /b %MEMERRORLEVEL%
goto :eof
rem ABBAProgrammEnd

:END2
endlocal
exit /b /0
goto :eof

rem ==========
:help
 call :LOGLINE2
 call :LOGCALLSTART "%0"
 call :LOGINFO "à·ØÆ´ÏßÆ¢†≠®•: "
 call :LOGINFO "    '%~1' [äéåÄçÑõ] [èÄêÄåÖíê] "
 call :LOGINFO " "
 call :LOGINFO "äÆ¨†≠§Î: "
 call :LOGINFO "    create folder       - ·Æß§†≠®• ´Æ™†´Ï≠Æ£Æ ‡•ØÆß®‚Æ‡®Ô ¢ ™†‚†´Æ£• folder"
 call :LOGINFO "                          ¢ ™†‚†´Æ£ ™ÆØ®‡„•‚ ¢·• ≠•Æ°ÂÆ§®¨Æ•, ØÆ·´• ·Æß§†≠®Ô ¢·• ¢ÎßÆ¢Î ≠†§Æ §•´†‚Ï ®ß folder "
 call :LOGINFO "    createmaster        - ·Æß§†≠®• £´†¢≠Æ£Æ ‡•ØÆß®‚Æ‡®Ô ≠† GitHub, §´Ô Â‡†≠•≠®Ô Ì‚®Â „‚®´®‚ "
 call :LOGINFO " "
 call :LOGINFO " äÆ¨†≠§Î ‡†°Æ‚† · ‡•ØÆß®‚Æ‡®Ô¨®:"
 call :LOGINFO "    gitinit             - ·Æß§†≠®•® ® ®≠®≠Ê®†´®ß†Ê®Ô ‡•ØÆß®‚Æ‡®Ô ¢ ‚•™„È•© Ø†Ø™• "
 call :LOGINFO "    autopush            - Æ‚Ø‡†¢´Ô•‚ ¢·• ®ß¨•≠•≠®Ô ¢ „§†´•≠≠Î© ‡•ØÆß®‚Æ‡®Ô ≠† GitHub "
 call :LOGINFO "    autocommit		- †¢‚Æ™Æ¨¨®‚ ¢ ‚•™„È•© §†‚Æ© ® ¢‡•¨•≠®¨ "
 call :LOGINFO "    remoteadd           - §Æ°†¢´•≠®• „§†´Ò≠≠ÎÂ ‡•ØÆß®‚Æ‡®•¢"
 call :LOGINFO "    gitbranch           - ™Æ¨†≠§† §´Ô „Ø‡†¢´•≠®Ô ¢•‚™†¨® ¢ ‡•ØÆß®‚Æ‡®® Git"
 call :LOGINFO " "
 call :LOGINFO " äÆ¨†≠§Î §´Ô GitHub:"
 call :LOGINFO "    createhub           - ·Æß§†≠®• „§†´•≠≠Æ£Æ ‡•ØÆß®‚Æ‡®Ô ≠† GitHub, §´Ô Â‡†≠•≠®Ô ·Æß§†≠≠Æ£Æ "
 call :LOGINFO "    githubcreate        - ·Æß§†≠®• „§†´•≠≠Æ£Æ ‡•ØÆß®‚Æ‡®Ô ≠† GitHub, §´Ô Â‡†≠•≠®Ô ·Æß§†≠≠Æ£Æ "
 call :LOGINFO "    githubdelete        - „§†´•≠®• ‡•ØÆß®‚Æ‡®Ô ≠† GitHub"
 call :LOGINFO " "
 call :LOGINFO "    info                - à≠‰Æ‡¨†Ê®Ô, ™Æ¨†≠§† ØÆ „¨Æ´Á†≠®Ó "
 call :LOGINFO "    help                - èÆ™†ß†‚Ï Ì‚„ ·Ø‡†¢™„ ® ¢Î©‚® "
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
 call :LOGWARNING " Ç êÄáêÄÅéíäÖ "
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
  call :LOGERROR "çÖÇÖêçÄü äéåÄçÑÄ '!CMDVAR!' ..."
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
 call :LOGINFO "èéàëä ìíàãàí"
 call :FINDGIT
 call :FINDGITHUBCLI
 call :LOGINFO2 "ëäÄçàêéÇÄçàÖ èÄèéä ë êÖèéáàíéêàüåà '%CD%'..."
 
 for /d %%i in (*) do (
  cd %%i
  if exist .git (
    rem call :LOGINFO2 "èÄèäÄ:                      '%CD%\%%i'"
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
 call :LOGINFO2 "àçîéêåÄñàü é êÖèéáàíéêàà"

 call :GETPARENTFOLDER
 set REPONAME=!PARENTFOLDER!
 call :LOGINFO2 "çÄáÇÄçàÖ:                   '!REPONAME!'"

 call :GETGITHUBOWNER 
 if not defined OWNER goto :FAILURE
 call :LOGINFO2  "ÇãÄÑÖãÖñ:                   '%OWNER%'"

 call :LOGLINE2 
 call :LOGINFO2 "GIT CONFIG GLOBAL"
 for /f "tokens=1* delims==" %%a in ('"git config --global --get user.name"') do ( call :LOGINFO2 "àåü èéãúáéÇÄíÖãü:           '%%a'")
 for /f "tokens=1* delims==" %%a in ('"git config --global --get user.email"') do ( call :LOGINFO2 "ùã.èéóíÄ:                   '%%a'")

 if exist .git (
  call :LOGLINE2 
  call :LOGINFO2 "GIT CONFIG LOCAL"
  for /f "tokens=1* delims==" %%a in ('"git config --local --get user.name"') do ( call :LOGINFO2 "àåü èéãúáéÇÄíÖãü:           '%%a'")
  for /f "tokens=1* delims==" %%a in ('"git config --local --get user.email"') do ( call :LOGINFO2 "ùã.èéóíÄ:                   '%%a'")

  call :LOGLINE2 
  call :LOGINFO2 "GIT CONFIG WORKTREE"
  for /f "tokens=1* delims==" %%a in ('"git config --worktree --get user.name"') do ( call :LOGINFO2 "àåü èéãúáéÇÄíÖãü:           '%%a'")
  for /f "tokens=1* delims==" %%a in ('"git config --worktree --get user.email"') do ( call :LOGINFO2 "ùã.èéóíÄ:                   '%%a'")

  call :LOGLINE2 
  call :LOGINFO2 "GIT CONFIG"
  for /f "tokens=1* delims==" %%a in ('"git config --get user.name"') do ( call :LOGINFO2 "àåü èéãúáéÇÄíÖãü:           '%%a'")
  for /f "tokens=1* delims==" %%a in ('"git config --get user.email"') do ( call :LOGINFO2 "ùã.èéóíÄ:                   '%%a'")


  call :LOGLINE2 
  call :LOGINFO2 "GIT ÄÑêÖëÄ Ñãü óíÖçàü à áÄèàëà, èêàÇüáÄççõÖ ä êÖèéáàíéêàû:"
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
  call :LOGWARNING " Ç ùíéâ èÄèäÖ éíëìíëíÇìÖí êÖèéáàíéêàâ "
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGLINE3
 )

 rem for /f "tokens=1* delims==" %%a in ('"git config --get remote.origin.url"')	do ( call :LOGINFO2 "URL:                        '%%a'")
 rem for /f "tokens=1* delims==" %%a in ('"git rev-parse --abbrev-ref HEAD"')	do ( call :LOGINFO2 "çÄáÇÄçàÖ íÖäìôÖâ ÇÖíäà:     '%%a'")

 rem call :GITCONFIGSAFEDIRECTORY

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

:info
 call :LOGLINE2
 call :LOGCALLSTART %0
 rem call :LOGCALLEND %0 0
 rem call :LOGDEBUG "'%0' '%1' '%2'"
 call :LOGINFO2 "àçîéêåÄñàü"
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

 call :LOGINFO2 "éíéÅêÄáàíú ÄäíàÇçìû ìóÖíçìû áÄèàëú à ëéëíéüçàÖ ÄìíÖçíàîàäÄñàà çÄ ïéëíàçÉÖ GitHub."
 echo .
 "%GHEXE%" auth status
 echo .

 if exist .git (
 call :LOGINFO2 "GIT ÄÑêÖëÄ Ñãü óíÖçàü à áÄèàëà, èêàÇüáÄççõÖ ä êÖèéáàíéêàû:"
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
  call :LOGWARNING " Ç ùíéâ èÄèäÖ éíëìíëíÇìÖí êÖèéáàíéêàâ "
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

call :LOGDEBUG "èêéÇÖêäÄ '%mygitini%'"
if exist %mygitini% (
 call :LOG "áÄÉêìáäÄ äéçîàÉÄ àá '%mygitini%'"
 call :READINIFILE2 %mygitini%
 if "%ERRORLEVEL%"=="0" (
  goto GITREADINIFILEOK
 )
) 

call :LOG "èêéÇÖêäÄ '!file_name!.ini'"
if exist !file_name!.ini (
 call :LOG "áÄÉêìáäÄ äéçîàÉÄ àá '!file_name!.ini'"
 call :READINIFILE !file_name!
 if "%ERRORLEVEL%"=="0" (
  goto GITREADINIFILEOK
 )
)

call :LOGLINE2
rem call :LOGERROR "ERRORLEVEL %ERRORLEVEL%"
call :LOGDEBUG "çÖéÅïéÑàåé ëéáÑÄíú îÄâã '!file_name!.ini'"

call :GITGETCONFIG
call :LOGDEBUG "àëèéãúáìâíÖ äéåÄçÑì createini"

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
 rem call :LOGINFO  "ÇãÄÑÖãÖñ = '%OWNER%'"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:CREATEGITHUBOWNER
 call :LOGDEBUG "CALL '%0'"
 rem call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"
 if "%OWNER%" == "" ( 
  call :LOGWARNING "----------------------------------------------------------------------------------------------------"
  call :LOGWARNING " çÖéÅïéÑàåé ìëíÄçéÇàíú ÇãÄÑÖãúñÄ êÖèéáàíéêàü Ñãü GitHub èÖêÖÑ áÄèìëäéå 'GIT INIT'"
  call :LOGWARNING " äéåÄçÑéâ 'git config github.name "ÇãÄÑÖãÖñ"' "
  call :LOGWARNING "----------------------------------------------------------------------------------------------------" 

  set mygitini=%~dp0%.mygitini
  call :GITREADINIFILE
  call :LOG "ÇõÅéê ÇãÄÑÖãñÄ:"
  set cint=1
  for /f "tokens=1* delims==" %%a in ('"set OWNER"') do (
   set %%a=%%b
   echo . !cint!.	'%%b'
   set /a cint=!cint!+1
  )

  echo.
  Set /p choice="Ç†Ë ¢Î°Æ‡: "
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
 call :LOGINFO "ëéáÑÄçàÖ îÄâãéÇ Ç êÖèéáàíéêàà ..."
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
 call :LOGCALLSTART %0
 call :LOGINFO "ëéáÑÄçàÖ à àçàñàÄãàáÄñàü êÖèéáàíéêàü ..."

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

 "%GITEXE%" init
 "%GITEXE%" add . --verbose

 call :GET_DT
 call :LOGDEBUG "CREATE TIMESTAMP '%DT%'"
 "%GITEXE%" commit -a -m "First commit '%dt%'" --verbose

 git branch -M main --verbose

 call :LOGDEBUG "GIT BRANCH LIST"
 git branch

 call :LOGCALLEND %0 "%ERRORLEVEL%"
goto :eof

rem ==========
:GITREMOTEADD
 call :LOGLINE2
 call :LOGCALLSTART %0
 call :LOGINFO "ÑéÅÄÇãÖçàÖ ìÑÄãççõï êÖèéáàíéêàÖÇ ..."
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
 
 call :LOGINFO "äéåÄçÑÄ GIT - ìÑÄãÖçàÖ 'ìÑÄãççéÉé êÖèéáàíéêàü' - îàäë"
 @echo on
 @echo .
 "%GITEXE%" remote --verbose remove origin
 @echo .
 @echo off

 call :LOGINFO "äéåÄçÑÄ GIT - ÑéÅÄÇãÖçàÖ 'ìÑÄãççéÉé êÖèéáàíéêàü' - 'https://github.com/%~1/%~2.git' "
 @echo on
 @echo .
 "%GITEXE%" remote --verbose add origin https://github.com/%~1/%~2.git
 @echo off
 @echo .

 call :LOGINFO "äéåÄçÑÄ GIT - ÇõÇéÑ ÇëÖï ÇÖíéä êÖèéáàíéêàü - îàäë"
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
 set MEMERRORLEVEL=!ERRORLEVEL!
 if not "%MEMERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %MEMERRORLEVEL%" )
 call :LOGCALLEND "%~0" "%MEMERRORLEVEL%"
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

 call :LOGWARNING "%~0 - òÄÉ 1"
 call :GITAUTOCOMMIT
 rem call :LOGLINE2

 call :LOGWARNING "%~0 - òÄÉ 2"
 call :GITAUTOPUSH
 rem call :LOGLINE2

 call :LOGWARNING "%~0 - END"

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

 echo .
 rem Create a new GitHub repository.
 rem gh repo create [<name>] [flags]
 rem --private                Make the new repository private
 rem --public                 Make the new repository public
 rem "%GHEXE%" repo create --public --description "My Repo 'mywingit%~1'" -y
 "%GHEXE%" repo create %OWNER%/%1 --private --source=. --remote=origin 

 echo .
 rem Edit repository settings.
 rem gh repo edit [<repository>] [flags]
 rem --description string       Description of the repository
 rem t OWNER/REPO -d "new Description"
 "%GHEXE%" repo edit %OWNER%/%1 --description "My Repo '%1'"

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

rem ==========
:GITHUBDELETE
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
 for /f "tokens=1* delims==" %%a in ('"git remote get-url origin"') do (set REPOURL1=%%a) 
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
 call :LOGINFO "ÇÖêïçàâ äÄíÄãéÉ: '!PARENTFOLDER!'"
 call :LOGINFO "ìÑÄãÖçàÖ êÖèéáàíéêàü '!PARENTFOLDER!' ON GITHUB"

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
  call :LOGINFO "äéåÄçÑÄ GIT - ìÑÄãÖçàÖ 'ìÑÄãççéÉé êÖèéáàíéêàü' - îàäë"
  @echo on
  @echo .
  "%GITEXE%" remote --verbose remove origin
  @echo .
  @echo off
 ) else (
  echo .
  call :LOGINFO "äéåÄçÑÄ GIT - ìÑÄãÖçàÖ 'ìÑÄãççéÉé êÖèéáàíéêàü' - èêéèìëä"
 )

 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )

 call :LOGCALLEND %0 "%ERRORLEVEL%"

goto :eof

rem ==========
:GITBRANCH
 call :LOGLINE2
 call :LOGINFO "ù‚Æ ™Æ¨†≠§† §´Ô „Ø‡†¢´•≠®Ô ¢•‚™†¨® ¢ ‡•ØÆß®‚Æ‡®® Git"
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
  call :LOGDEBUG "óíÖçàÖ îÄâãÄ '%BRANCHINI%'"
  for /f "usebackq eol=; tokens=1,2 delims=, " %%a in (%BRANCHINI%) do ( 
   rem echo %%a,%%b
   if "%%a"=="BRANCHNAME" ( 
	set BRANCHNAME=%%b
   ) else if "%%a"=="BRANCHNUMBER" ( 
	set BRANCHNUMBER=%%b
   )
  )
 ) else (
  call :LOGDEBUG "ëéáÑÄçàÖ îÄâãÄ '%BRANCHINI%'"
  call :LOGDEBUG "áÄèàëú Ç îÄâã '%BRANCHINI%'"
  echo ; > %BRANCHINI%
  echo BRANCHNAME,test >> %BRANCHINI%
  echo BRANCHNUMBER,0 >> %BRANCHINI%
  call :LOGDEBUG "èéÇíéêçõâ ÇõáéÇ %0"
  call :GITBRANCH %~1 %~2
  echo off
  if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
  exit /b 0
 )

 echo off
 call :LOGDEBUG "BRANCHNAME   = '!BRANCHNAME!'"
 call :LOGDEBUG "BRANCHNUMBER = '!BRANCHNUMBER!'"

 if "%1"=="new" (
  call :LOGDEBUG "äéåÄçÑÄ %1"
  set /a BRANCHNUMBER=!BRANCHNUMBER!+1
  call :GITBRANCHSAVE

  call :LOGINFO "ëéáÑÄíú çéÇìû ÇÖíäì '!BRANCHNAME!!BRANCHNUMBER!' à èÖêÖäãûóàíúëü çÄ çÖ"
  "%GITEXE%" checkout -b !BRANCHNAME!!BRANCHNUMBER!
  goto GITBRANCH1
 )

 call :LOGDEBUG "'%0' '%1' '%2' '%3' '%4' '%5' '%6'"

 call :LOGDEBUG "è‡Æ·¨Æ‚‡•‚Ï ·Ø®·Æ™ ¢·•Â ¢•‚Æ™ ¢ ‚•™„È•¨ ‡•ØÆß®‚Æ‡®®:"
 echo .
 "%GITEXE%" branch
 echo .
 
:GITBRANCH1
 echo off
 if not "%ERRORLEVEL%"=="0" ( call :LOGDEBUG "'%0' - ERRORLEVEL %ERRORLEVEL%" )
goto :eof

:GITBRANCHSAVE
 call :LOGDEBUG "áÄèàëú çéÇõï ÑÄççõï Ç îÄâã '%BRANCHINI%'"
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
  call :LOGDEBUG "call %0 [≠†®¨•≠Æ¢†≠®• ¢•‚™®]"
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
 call :LOGINFO2 "ëäÄçàêéÇÄçàÖ èÄèéä ë êÖèéáàíéêàüåà '%CD%'..."
 echo off

 set scan=
 call :SCANDIR "%ROOTDIR%"
 call :LOGLINE2
 call :LOGINFO "SCAN='!scan!'"

 set autoscanini=%~dp1%~n1.ini
 call :LOG "èêéÇÖêäÄ '%autoscanini%'"
 echo ;%autoscanini% > %autoscanini%
 for /d %%i in (!scan!) do (
  call :LOG "áÄèàëú '%%~i'"
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
 call :LOGINFO2 "ëäÄçàêéÇÄçàÖ èÄèéä ë êÖèéáàíéêàüåà à áÄèìëä ..."
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
 call :LOGDEBUG "èêéÇÖêäÄ '%autoscanini%'"
 if exist %autoscanini% (
  call :LOGINFO "èêéÇÖêäÄ '%autoscanini%' - OK"
 
  for /F "usebackq eol=; tokens=1" %%a in (!autoscanini!) do (
   call :LOGDEBUG "%%a"

   if "%~2"=="commit" (     
    cd %%a
    call :LOGINFO "=============================================================================================================="
    call :LOGINFO "äÄíÄãéÉ Run GIT '%%a' "
    call run_git.cmd.auto.commit.cmd "%file_log%"      
   )

   if "%~2"=="push" (     
    cd %%a
    call :LOGINFO "=============================================================================================================="
    call :LOGINFO "äÄíÄãéÉ Run GIT '%%a' "
    call run_git.cmd.auto.push.cmd "%file_log%"      
   )

 )


 ) else (
  call :LOGERROR "èêéÇÖêäÄ '%autoscanini%' - çÖí"
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
   call :LOGINFO "äÄíÄãéÉ '%~1' - OK"
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
      call :LOGINFO "äÄíÄãéÉ Run GIT '%%i' "
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
		call :LOGINFO "óíÖçàÖ îÄâãÄ '!MYINI!' ..."
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
		call :LOGINFO "óíÖçàÖ îÄâãÄ '!MYINI2!' ..."
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
echo ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
goto :eof

:LOGLINE1
echo ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
goto :eof                                                                                                                    
                                                                                                                             
:LOGLINE2                                                                                                                    
echo √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
goto :eof                                                                                                                    

rem √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥

:LOGLINE3
echo [0m√[95mƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ[0m¥[0m
goto :eof

:LOGLINE4
echo [0m√[93mƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ[0m¥[0m
goto :eof

rem ==========
:LOG
call :LOGSTR  "     " "%~1"
call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%[0m[120G≥" "[97m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGINFO
call :LOGSTR  "INFO " "%~1"
call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%[0m[120G≥" "[92m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGINFO2
call :LOGSTR  "INFO " "%~1"
call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%[0m[120G≥" "[93m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGWARNING
call :LOGSTR  "WARN " "%~1"
call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%[0m[120G≥" "[95m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGDEBUG
 if defined DEBUG (
  if "%DEBUG%"== "0" goto :eof
  call :LOGSTR  "DEBUG" "%~1"
  call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%[0m[120G≥" "[94m"
  call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
 )
goto :eof

rem ==========
:LOGERROR
call :LOGSTR  "ERROR" "%~1"
call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%[0m[120G≥" "[91m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGTEST
call :LOGSTR  "TEST " "%~1"
rem call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%" "[96m"
call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%[0m[120G≥" "[96m"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

rem ==========
:LOGCALLSTART
rem call :LOGCALLSTART %1
@echo off
if not "%~1"=="" (
 rem @echo .
  call :LOGINFO2 "START '%~1' - OK"
 ) else (
  call :LOGERROR "'%~0' - CALL ERROR 1"
 )
@echo off
goto :eof

rem ==========
:LOGCALLEND
rem call :LOGCALLEND %1 %2
@echo off
if not "%~1"=="" (
 rem @echo .
 if not "%~2"=="" (
  rem @echo .                                                                                                                    f
  if not "%~2"=="0" ( 
   rem @echo .
    call :LOGERROR "'%~1' - ERRORLEVEL '%~2'" 
    call :LOGERROR "END '%~1'"
   ) else (
  call :LOGINFO2 "END '%~1' - OK"
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
call :LOGSCR "≥%dt%≥%tlogstr1%≥%tlogstr2%"
call :LOGFILE "%dt% %tlogstr1% %tlogstr2%"
goto :eof

:LOGSTART
call :LOGSTR  "     " "%~1"
call :LOGFILE "%dt%       ------------------------------------------------------------------------------------------"
call :LOGSCR  "≥%dt%≥%tlogstr1%≥%tlogstr2%[120G≥"
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
 call :LOGINFO "ìëíÄçéÇäÄ èêéÉêÄååõ"
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
 call :LOGINFO "èêéÇÖêäÄ èÖêÖåÖççéâ éäêìÜÖçàü - 'PATH'"
 echo off
 for %%G in ("%path:;=" "%") do (
  rem echo %%G
  if "%pathcmd%" == %%G (
    set pathcmd1=%%G
  )
 )

 if not defined pathcmd1 (
  echo . ÑÆ°†¢´•≠®• ¢ PATH Ø„‚® '%pathcmd%' §Æ ™Æ¨†≠§
  rem setx path "%path%;%pathcmd%" -- ≠• ®·ØÆ´ÏßÆ¢†‚Ï Æ£‡†≠®Á•≠®• 1024 ·®¨¢Æ´†
  echo on
  rem powershell -version 5 -Command { $PATH=[Environment]::GetEnvironmentVariable("PATH") & $my_path = "%pathcmd%"; [Environment]::SetEnvironmentVariable("PATH", "$PATH;$my_path", "User") }
  powershell -version 5 -Command "& { $PATH=[Environment]::GetEnvironmentVariable('PATH'); [Environment]::SetEnvironmentVariable('PATH', $PATH+';%pathcmd%', 'User'); }"
  echo off
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  call :LOGWARNING "---                      çÖéÅïéÑàåé èÖêÖáÄÉêìáàíú äéåèúûíÖê                            ---"
  call :LOGWARNING "------------------------------------------------------------------------------------------"
  echo .
  timeout 5 /nobreak
  pause
  echo off
  rem exit 2
  rem goto :eof
 ) else (
  call :LOGINFO "ìëíÄçéÇãÖç = '%pathcmd%'"
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
 call :LOGINFO "ìëíÄçéÇäÄ Ç èÄèäì '!pathcmd!'"

 call :CREATEDIR "!pathcmd!"

 rem if not exist !pathcmd! (
 rem  call :LOGWARNING "ëéáÑÄçàÖ äÄíÄãéÉÄ '!pathcmd!'"
 rem   md !pathcmd!
 rem  )


 rem echo .
 rem echo Copy '!filenamecmdfull!' to '!pathcmd!\!filenamecmd!'
 call :LOGINFO "äéèàêéÇÄçàÖ îÄâãÄ '!filenamecmdfull!' Ç '!pathcmd!\!filenamecmd!'"
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
 call :LOGINFO "äéèàêéÇÄçàÖ îÄâãéÇ '%~dp0!filenamecmd!.*.cmd' Ç '!pathcmd!'"
 echo .
 @echo on
 xcopy "%~dp0!filenamecmd!.*.cmd" "!pathcmd!" /Y /F /EXCLUDE:!XCOPYEXCLUDE!
 @echo off
 echo .

 call :LOGLINE2
 set  pathcmd21=%~dp0GitCopyFiles
 set  pathcmd22=!pathcmd!\GitCopyFiles
 call :LOGINFO "äéèàêéÇÄçàÖ îÄâãéÇ '!pathcmd21!\*.*'"
 call :LOGINFO "                 Ç '!pathcmd22!'"
 call :CREATEDIR "!pathcmd22!"
 echo .
 @echo on
 xcopy "!pathcmd21!\*.*" "!pathcmd22!" /Y /F /EXCLUDE:!XCOPYEXCLUDE!
 @echo off
 echo .

 set  pathcmd23=%~dp0
 call :LOGINFO "äéèàêéÇÄçàÖ îÄâãéÇ '!pathcmd23!'"
 echo .
 @echo on
 copy /y "!pathcmd23!ProjectClean.cmd" "!pathcmd!"
 @echo off
 echo .
 
 rem echo .
 rem echo Copy '.mygitini' to '!pathcmd!\.mygitini'
 rem copy /y ".mygitini" "%USERPROFILE%\.mygitini"

 rem echo .
 rem echo ÇÎ¢Æ§ ·Ø®·™† ‰†©´Æ¢ ® ØÆ§™†‚†´Æ£Æ¢ ¢ ™†‚†´Æ£• !pathcmd! ...
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
rem êéÑàíÖãúëäÄü èÄèäÄ
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
rem ìØ‡†¢´ÔÓÈ®• ØÆ·´•§Æ¢†‚•´Ï≠Æ·‚® ANSI
rem ëÆ¢Æ™„Ø≠Æ·‚Ï ·®¨¢Æ´Æ¢ ESC ® [ ≠†ßÎ¢†Ó‚ CSI ®´® Control Sequence Introducer
rem ESC (ASCII: 27 / 0x1B / 033
rem [nK  ì§†´Ô•‚ Á†·‚Ï ·‚‡Æ™®. Ö·´® n ‡†¢≠Æ §¢„¨, ÆÁ®È†•‚ ¢·Ó ·‚‡Æ™„. èÆ´Æ¶•≠®• ™„‡·Æ‡† ≠• ¨•≠Ô•‚·Ô.
rem [nF  è•‡•¨•È†•‚ ™„‡·Æ‡ ¢ ≠†Á†´Æ n-Æ© (ØÆ „¨Æ´Á†≠®Ó 1-©) ·‚‡Æ™® ·¢•‡Â„ Æ‚≠Æ·®‚•´Ï≠Æ ‚•™„È•©.
rem [nG Cursor Horizontal Absolute è•‡•¨•È†•‚ ™„‡·Æ‡ ¢ ·‚Æ´°•Ê n.
goto :eof

exit /b 0
goto :eof
