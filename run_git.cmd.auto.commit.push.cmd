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

echo [93m.1 INFO:[0m - [%0]
set DEBUG=0
call run_git.cmd autocommitpush "%file_log%"

set MEMERRORLEVEL=!ERRORLEVEL!
if !MEMERRORLEVEL! GTR 1 ( echo [91m.2 ERROR:[0m ERRORLEVEL = !MEMERRORLEVEL! - [%0] )
if !MEMERRORLEVEL! EQU 0 ( echo [93m.2 INFO:[0m ERRORLEVEL = !MEMERRORLEVEL!  - [%0] )
exit /b %MEMERRORLEVEL%
goto :eof
