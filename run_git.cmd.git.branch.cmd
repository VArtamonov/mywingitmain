@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0

if "%~1"=="" (
 rem set file_log=%~dp0%~n0.log
 set file_log=%cd%\%~n0.log
) else (
 set file_log=%~1
)

set file_ini=%~dp0%run_git.cmd.gitbranch.ini

rem run_git.cmd gitbranch %file_log% %file_ini%

call run_git.cmd gitbranch %file_log%

exit /b
