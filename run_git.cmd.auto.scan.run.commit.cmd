@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

rem set file_log=%~dp0%~n0.log
set file_log=%cd%\%~n0.log
set file_name=%~n0

if "%~1"=="" (
 rem set file_log=%~dp0%~n0.log
 set file_log=%cd%\%~n0.log
) else (
 set file_log=%~1
)

call run_git.cmd autoscanrun "%file_log%" commit

set MEMERRORLEVEL=!ERRORLEVEL!
if "%MEMERRORLEVEL%"=="1" ( echo [91m.2 ERROR:[0m ERRORLEVEL = %ERRORLEVEL% - [%0] )
if "%MEMERRORLEVEL%"=="0" ( echo [93m.2 INFO:[0m ERRORLEVEL = %ERRORLEVEL%  - [%0] )
exit /b %MEMERRORLEVEL%
goto :eof
