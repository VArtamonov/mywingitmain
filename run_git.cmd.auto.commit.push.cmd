@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

rem set file_log=%~dp0%~n0.log
rem set file_name=%~n0

if "%~1"=="" (
 rem set file_log=%~dp0%~n0.log
 set file_log=%cd%\%~n0.log
) else (
 set file_log=%~1
)

set DEBUG=0

echo .1

call run_git.cmd autocommit "%file_log%"
echo .2 - '%ERRORLEVEL%'

call run_git.cmd autopush "%file_log%"
echo .3 - '%ERRORLEVEL%'

exit /b
