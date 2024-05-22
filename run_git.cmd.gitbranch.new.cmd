@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

set file_log=%~dp0%~n0.log
set file_name=%~n0
set file_ini=%~dp0%run_git.cmd.gitbranch.ini
run_git.cmd gitbranchnew  %file_log% %file_ini%
