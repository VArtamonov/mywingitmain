@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0

if "%~1"=="" (
 set file_log=%~dp0%~n0.log
) else (
 set file_log=%~1
)

run_git.cmd autopush "%file_log%"
exit /b
