#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# سكربت بناء تطبيق أندرويد APK مباشرة على الهاتف باستخدام Termux
# تطبيق: Smart Debt Messenger (com.smartdebt.app)
# ==============================================================================

set -e

echo "📱 ======================================================"
echo "   جاري بدء بناء تطبيق: Smart Debt Messenger"
echo "   الإصدار: 1.0.0 (v1)"
echo "========================================================="

# 1. التحقق من تثبيت بيئة العمل والحزم الأساسية
echo "📦 1/4 التحقق من تثبيت OpenJDK 17 و Gradle..."
pkg update -y
pkg install -y openjdk-17 gradle git aapt zipalign || true

# 2. إعطاء صلاحيات التشغيل لـ Gradle Wrapper
echo "⚙️ 2/4 ضبط صلاحيات ملفات البناء..."
chmod +x gradlew || true
chmod +x build.sh || true

# 3. بناء تطبيق أندرويد بصيغة APK (Debug)
echo "🔨 3/4 جاري تجميع ملف الـ APK عبر Gradle..."
./gradlew assembleDebug --stacktrace

# 4. مسار ملف الـ APK النهائي
APK_PATH="app/build/outputs/apk/debug/app-debug.apk"

if [ -f "$APK_PATH" ]; then
    echo "🎉 ======================================================"
    echo "   ✅ تم بناء ملف الـ APK بنجاح تام!"
    echo "   📍 المسار: $APK_PATH"
    echo "========================================================="
    
    # محاولة فتح ملف الـ APK لتثبيته فوراً على الهاتف إذا كانت أدوات Termux متوفرة
    if command -v termux-open &> /dev/null; then
        echo "📲 جاري فتح ملف الـ APK للتثبيت المباشر على الهاتف..."
        termux-open "$APK_PATH"
    else
        echo "💡 يمكنك نسخ ملف الـ APK إلى مجلد التنزيلات (Downloads) عبر الأمر:"
        echo "   cp $APK_PATH /sdcard/Download/Smart Debt Messenger.apk"
    fi
else
    echo "❌ تعذر العثور على ملف APK الناتج. يرجى مراجعة سجل الأخطاء أعلاه."
    exit 1
fi
