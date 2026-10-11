@echo off
echo Building APK for Smart Debt Messenger...
call gradlew.bat assembleDebug
echo APK built successfully at app/build/outputs/apk/debug/app-debug.apk
pause
