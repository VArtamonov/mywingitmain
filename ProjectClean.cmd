@echo off
chcp 866 >nul
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

echo [93m. 1 INFO:[0m - [%0]

echo --------------------------------------------------------------------------------------------------
set p=obj,bin,.vs,OutputPath,artifacts,__pycache__
echo . 2 Удаление всех '%p%' ...
for /r %%a in (%p%) do (
 rem echo %%a
 echo .
 echo [1F[0K Scan '%%a'[1F
 if exist "%%a" (
  echo . Delete '%%a'
  rd /s /q "%%a"
 )
)
echo .
echo [1F[0K[92m. Удаление завершено[0m[1F

echo [1E.
echo --------------------------------------------------------------------------------------------------
echo . 3 Удаление всех логов *.log ...
for /r %%a in (*.log) do (
 rem echo %%a
 echo .
 echo [1F[0K Scan '%%a'[1F
 if exist "%%a" (
  echo . Delete '%%a'
  del /f /q "%%a"
 )
)
echo .
echo [1F[0K[92m. Удаление завершено[0m[1F

echo [1E.
set MEMERRORLEVEL=!ERRORLEVEL!
if !MEMERRORLEVEL! GTR 1 ( echo [91m. 9 ERROR:[0m ERRORLEVEL = !MEMERRORLEVEL! - [%0] )
if !MEMERRORLEVEL! EQU 0 ( echo [93m. 9 INFO:[0m ERRORLEVEL = !MEMERRORLEVEL!  - [%0] )
exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:CALLANSI
rem Управляющие последовательности ANSI
rem Совокупность символов ESC и [ называют CSI или Control Sequence Introducer
rem ESC (ASCII: 27 / 0x1B / 033
rem [nK EL  - Erase in Line - Удаляет часть строки. 
rem 				Если n равно нулю (или отсутствует), очищает всё от курсора до конца строки.
rem 				Если n равно единице, очищает всё от курсора до начала строки.
rem 				Если n равно двум, очищает всю строку. Положение курсора не меняется.
rem [nF CPL - Cursor Previous Line - Перемещает курсор в начало n-ой (по умолчанию 1-й) строки сверху относительно текущей.
rem [nE CNL - Cursor Next Line - Перемещает курсор в начало n-ой (по умолчанию 1-й) строки снизу относительно текущей.
rem [nG Cursor Horizontal Absolute Перемещает курсор в столбец n.
goto :eof

exit /b 0
goto :eof
