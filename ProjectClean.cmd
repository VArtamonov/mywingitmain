@echo off
chcp 866 >nul

setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

echo .
rem echo %~dp0%~n0%~x0
echo Run '%~n0%~x0'
echo .

echo -------------------------------------------------
for /r %%a in (obj,bin,.vs) do (
 if exist "%%a" (
  echo %%a
  rem del /f /s /q "%%a"
  rd /s /q "%%a"
 )
)

echo .
echo Удаление всех логов *.log ...
del /s /q *.log
echo .
timeout 2 /nobreak
pause
