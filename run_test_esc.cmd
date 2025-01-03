@echo off
chcp 866 >nul
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

echo [93m.1 INFO:[0m - [%0]
call :ECHOGAP1
echo .........................
echo [1F[0KScan

@echo off
echo [24E

set MEMERRORLEVEL=!ERRORLEVEL!
if !MEMERRORLEVEL! GTR 1 ( echo [91m.2 ERROR:[0m ERRORLEVEL = !MEMERRORLEVEL! - [%0] )
if !MEMERRORLEVEL! EQU 0 ( echo [93m.2 INFO:[0m ERRORLEVEL = !MEMERRORLEVEL!  - [%0] )
exit /b !MEMERRORLEVEL!
goto :eof

rem ========================================
:ECHOGAP1
   echo +----------------------------------------------------------------------------------------------------------------------+
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo .
   echo +----------------------------------------------------------------------------------------------------------------------+
   echo [22F
goto :eof
