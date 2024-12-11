@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0

rem run_git.cmd install %file_log%

echo .
echo Удаление всех логов *.log ...
del /s /q *.log
echo .

exit /b
