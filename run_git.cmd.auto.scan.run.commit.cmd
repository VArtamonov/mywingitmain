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

run_git.cmd autoscanrun "%file_log%" commit
exit /b
