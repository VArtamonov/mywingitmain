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
rem call run_git.cmd autocommit "%file_log%"
call run_git.cmd autocommitpush "%file_log%"
if errorlevel 1 ( echo [91m.2 ERROR:[0m ERRORLEVEL = %ERRORLEVEL% )
if errorlevel 0 ( echo [92m.2 INFO:[0m ERRORLEVEL = %ERRORLEVEL% )

exit /b 0
goto :eof
