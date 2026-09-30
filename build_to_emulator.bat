@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

set "TARGET_DEVICE=emulator-5554"
if not "%~1"=="" set "TARGET_DEVICE=%~1"

echo ===================================================
echo   Building and Deploying to %TARGET_DEVICE%
echo ===================================================

echo [1/3] Compiling release APK...
call flutter build apk --release
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Flutter build failed!
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [2/3] Installing APK onto %TARGET_DEVICE%...
call adb -s %TARGET_DEVICE% install -r "build\app\outputs\flutter-apk\app-release.apk"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Installation failed! Please check if %TARGET_DEVICE% is online.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [3/3] Starting Salah Companion...
call adb -s %TARGET_DEVICE% shell monkey -p com.rymthos.salahcompanion -c android.intent.category.LAUNCHER 1

echo.
echo [SUCCESS] App built, installed, and launched!
pause
