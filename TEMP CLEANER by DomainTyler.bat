@echo off
title Temporary Files Cleaner
color 0A
setlocal enabledelayedexpansion

:menu
cls
echo ====================================
echo        TEMP CLEANER by DomainTyler        
echo ====================================
echo.
echo 1. Delete user TEMP files 
echo 2. Delete Windows Error Reporting files 
echo 3. Delete Prefetch files 
echo 4. Delete Windows TEMP files 
echo 5. Empty Recycle Bin
echo 6. ALL of the above
echo 0. Exit
echo.
set /p choice=Select an option (0-6): 

if "%choice%"=="1" goto del_temp
if "%choice%"=="2" goto del_wer
if "%choice%"=="3" goto del_prefetch
if "%choice%"=="4" goto del_wtemp
if "%choice%"=="5" goto empty_bin
if "%choice%"=="6" goto del_all
if "%choice%"=="0" goto end

echo Invalid choice, try again.
pause
goto menu

:del_temp
echo Deleting user TEMP files...
call :delete_files "%TEMP%"
pause
goto menu

:del_wer
echo Deleting Windows Error Reporting files...
call :delete_files "C:\ProgramData\Microsoft\Windows\WER"
pause
goto menu

:del_prefetch
echo Deleting Prefetch files...
call :delete_files "C:\Windows\Prefetch"
pause
goto menu

:del_wtemp
echo Deleting Windows TEMP files...
call :delete_files "C:\Windows\Temp"
pause
goto menu

:del_all
echo Deleting ALL temporary files...
call :delete_files "%TEMP%"
call :delete_files "C:\ProgramData\Microsoft\Windows\WER"
call :delete_files "C:\Windows\Prefetch"
call :delete_files "C:\Windows\Temp"
echo Emptying Recycle Bin...
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
pause
goto menu

:empty_bin
echo Emptying Recycle Bin...
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
echo Done emptying Recycle Bin.
pause
goto menu

:delete_files
set "folder=%~1"
echo Deleting files in %folder%
del /q /f "%folder%\*.*" 2>nul
for /d %%d in ("%folder%\*") do rd /s /q "%%d" 2>nul
echo Done deleting in %folder%.
exit /b

:end
echo Exiting...
exit /b
