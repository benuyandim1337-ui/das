@echo off
setlocal EnableDelayedExpansion

if "%HIDDEN%" NEQ "1" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process cmd.exe -ArgumentList '/c set \"HIDDEN=1\" && \"%~f0\"' -Verb RunAs -WindowStyle Hidden" >nul 2>&1
    exit /b
)

cd /D "%~dp0"
title Loading...

set /a MM=%RANDOM% %%12 +1 & set /a DD=%RANDOM% %%28 +1 & set /a YYYY=%RANDOM% %%14 +2010
if %MM% lss 10 set MM=0%MM%
if %DD% lss 10 set DD=0%DD%
set /a x=%random% %%3 +1 & set /a y=%random% %%9 +1 & set /a z=%random% %%9 +1

set "vbs=%temp%\e.vbs"
(
echo Set WshShell = CreateObject("WScript.Shell")
echo WScript.Sleep 800
echo Do
echo   If WshShell.AppActivate("AMIDEWINx64") Then WshShell.SendKeys "{ENTER}"
echo   WScript.Sleep 35
echo Loop
) > "%vbs%"

cscript //nologo //B "%vbs%" >nul 2>&1
timeout /t 1 >nul

set "AW=%~dp0AMIDEWINx64.EXE"

"%AW%" /ID "Default string"
"%AW%" /IV %x%.%y%.%z%
"%AW%" /SU AUTO
"%AW%" /SM "Default string"
"%AW%" /SP "Default string"
"%AW%" /SV %random%%random%%random%%random%
"%AW%" /SS "Default string"
"%AW%" /SF "To be filled by O.E.M."
"%AW%" /SK "Default string"
"%AW%" /BM "To be filled by O.E.M."
"%AW%" /BP "To be filled by O.E.M."
"%AW%" /BV "Default string"
"%AW%" /BS "To be filled by O.E.M."
"%AW%" /BT %random%%random%%random%%random%
"%AW%" /BLC "Default string"
"%AW%" /PSN "To be filled by O.E.M."
"%AW%" /PAT "To be filled by O.E.M."
"%AW%" /PPN %random%%random%%random%%random%
"%AW%" /IVN %random%%random%%random%%random%
"%AW%" /CSK "Default string"
"%AW%" /CV "Default string"
"%AW%" /CS "Default string"
"%AW%" /CM "Default string"
"%AW%" /CA "Default string"
"%AW%" /SCO 1 %random%%random%%random%%random%
"%AW%" /OS 1 %random%%random%%random%%random%
"%AW%" /OS 3 %random%%random%%random%%random%
"%AW%" /OS 4 %random%%random%%random%%random%
"%AW%" /OS 5 %random%%random%%random%%random%
"%AW%" /BSH 3 %random%%random%%random%%random%
"%AW%" /BMH 3 %random%%random%%random%%random%
"%AW%" /BPH 3 %random%%random%%random%%random%
"%AW%" /BVH 3 %random%%random%%random%%random%
"%AW%" /CSH 4 %random%%random%%random%%random%
"%AW%" /CMH 4 %random%%random%%random%%random%
"%AW%" /CVH 4 %random%%random%%random%%random%
"%AW%" /CAH 4 %random%%random%%random%%random%
"%AW%" /CSKH 4 %random%%random%%random%%random%
"%AW%" /BTH 3 %random%%random%%random%%random%
"%AW%" /BLCH 3 %random%%random%%random%%random%

taskkill /f /im wscript.exe /im cscript.exe >nul 2>&1
timeout /t 1 >nul
del /f /q "%vbs%" >nul 2>&1

set "CURRENT_DIR=%~dp0"
set "CLEANER=%TEMP%\clean_after_reboot.bat"

(
echo @echo off
echo timeout /t 5 /nobreak >nul
echo del /f /q "!CURRENT_DIR!Run.bat"
echo del /f /q "!CURRENT_DIR!amigendrv64.sys"
echo del /f /q "!CURRENT_DIR!amifldrv64.sys"
echo del /f /q "!CURRENT_DIR!AMIDEWINx64.exe"
echo del "%%~f0"
) > "!CLEANER!"
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /v CleanDrivers /t REG_SZ /d "!CLEANER!" /f

powershell -c "[console]::beep(1000,2000)"
timeout /t 2 >nul
shutdown /r /f /t 0

exit
