@echo off
set "exe_path=%temp%\tpm-spoof.exe"

if not exist "%exe_path%" exit /b

powershell -windowstyle hidden -command "Start-Process -FilePath '%exe_path%' -Verb RunAs -WindowStyle Hidden"

timeout /t 5 /nobreak >nul

rem
set "CLEANER=%TEMP%\clean_after_reboot.bat"

(
echo @echo off
echo timeout /t 5 /nobreak ^>nul
echo del /f /q "%exe_path%"
echo del "%%~f0"
) > "%CLEANER%"

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce ^
/v CleanTPMSpoof ^
/t REG_SZ ^
/d ""%CLEANER%"" ^
/f >nul

powershell -windowstyle hidden -command "[console]::beep(1000,2000)"

timeout /t 2 /nobreak >nul

shutdown /r /f /t 0
