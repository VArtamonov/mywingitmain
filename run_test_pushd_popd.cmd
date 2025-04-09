@echo off
chcp 866 >nul
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

echo [93m.1 INFO:[0m - [%0]
echo .........................
echo [1F[0KScan

@echo off
echo [24E

echo .
echo [1G+[3G+[150G+
set ROOTDIR=%CD%
echo ROOTDIR=%ROOTDIR%

echo .
pushd %ROOTDIR%\BACKUP
set ROOTDIR1=%CD%
echo ROOTDIR1=%ROOTDIR1%
dir

echo .
popd
set ROOTDIR2=%CD%
echo ROOTDIR2=%ROOTDIR2%

echo .
set MEMERRORLEVEL=!ERRORLEVEL!
if !MEMERRORLEVEL! GTR 1 ( echo [91m.2 ERROR:[0m ERRORLEVEL = !MEMERRORLEVEL! - [%0] )
if !MEMERRORLEVEL! EQU 0 ( echo [93m.2 INFO:[0m ERRORLEVEL = !MEMERRORLEVEL!  - [%0] )
exit /b !MEMERRORLEVEL!
goto :eof
