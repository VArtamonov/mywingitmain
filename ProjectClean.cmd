@echo off
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

echo .
echo -------------------------------------------------
set p=obj,bin,.vs,OutputPath,artifacts
echo Удаление всех '%p%' ...
for /r %%a in (%p%) do (
 if exist "%%a" (
  echo %%a
  rem del /f /s /q "%%a"
  rd /s /q "%%a"
 )
)

echo .
echo -------------------------------------------------
echo Удаление всех логов *.log ...
del /s /q *.log

echo .
