@echo off
chcp 866 >nul
setlocal
setlocal enableextensions
setlocal enabledelayedexpansion

echo [93m.1 INFO:[0m - [%0]

echo --------------------------------------------------------------------------------------------------
set p=obj,bin,.vs,OutputPath,artifacts,__pycache__,.pytest_cache
echo [93m.2 �������� ��� ����� '%p%' ...[0m
for /r %%a in (%p%) do (
 rem echo %%a
 set aa=%%a
 set bb=!aa:~0,70!
 echo .
 echo [1F[0KScan '!bb!'[1F
 if exist "%%a" (
  echo .2 Delete '%%a'
  rd /s /q "%%a"
 )
)
echo [0K[92m.2 �������� �����襭�[0m

echo [1E.
echo --------------------------------------------------------------------------------------------------
set p2=.DS_Store
echo [93m.3 �������� ��� 䠩���  '%p2%'...[0m
for /r %%a in (%p%) do (
 rem echo %%a
 set aa=%%a
 set bb=!aa:~0,70!
 echo .
 echo [1F[0KScan '!bb!'[1F
 if exist "%%a" (
  echo .3 Delete '%%a'
  del /f /q "%%a"
 )
)
echo [0K[92m.3 �������� �����襭�[0m

echo [1E.
echo --------------------------------------------------------------------------------------------------
echo [93m.4 �������� ��� ����� *.log ...[0m
for /r %%a in (*.log) do (
 rem echo %%a
 echo .
 echo [1F[0K Scan '%%a'[1F
 if exist "%%a" (
  echo .4 Delete '%%a'
  del /f /q "%%a"
 )
)
echo .
echo .
echo [0K[92m4. �������� �����襭�[0m

echo [1E.
set MEMERRORLEVEL=!ERRORLEVEL!
if !MEMERRORLEVEL! GTR 1 ( echo [91m. 9 ERROR:[0m ERRORLEVEL = !MEMERRORLEVEL! - [%0] )
if !MEMERRORLEVEL! EQU 0 ( echo [93m. 9 INFO:[0m ERRORLEVEL = !MEMERRORLEVEL!  - [%0] )
exit /b %MEMERRORLEVEL%
goto :eof

rem ==========
:CALLANSI
rem ��ࠢ���騥 ��᫥����⥫쭮�� ANSI
rem �����㯭���� ᨬ����� ESC � [ ���뢠�� CSI ��� Control Sequence Introducer
rem ESC (ASCII: 27 / 0x1B / 033
rem [nK EL  - Erase in Line - ������ ���� ��ப�. 
rem 				�᫨ n ࠢ�� ��� (��� ���������), ��頥� ��� �� ����� �� ���� ��ப�.
rem 				�᫨ n ࠢ�� ������, ��頥� ��� �� ����� �� ��砫� ��ப�.
rem 				�᫨ n ࠢ�� ���, ��頥� ��� ��ப�. ��������� ����� �� �������.
rem [nF CPL - Cursor Previous Line - ��६�頥� ����� � ��砫� n-�� (�� 㬮�砭�� 1-�) ��ப� ᢥ��� �⭮�⥫쭮 ⥪�饩.
rem [nE CNL - Cursor Next Line - ��६�頥� ����� � ��砫� n-�� (�� 㬮�砭�� 1-�) ��ப� ᭨�� �⭮�⥫쭮 ⥪�饩.
rem [nG Cursor Horizontal Absolute ��६�頥� ����� � �⮫��� n.
goto :eof

exit /b 0
goto :eof
