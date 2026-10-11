#!/bin/bash
echo "Building APK for Smart Debt Messenger..."
chmod +x gradlew || true
./gradlew assembleDebug
echo "APK built successfully at app/build/outputs/apk/debug/app-debug.apk"
