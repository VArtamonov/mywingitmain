@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

rem set file_log=%~dp0%~n0.log
rem set file_name=%~n0

if "%~1"=="" (
 set file_log=%~dp0%~n0.log
) else (
 set file_log=%~1
)

run_git.cmd autocommit "%file_log%"
exit /b
