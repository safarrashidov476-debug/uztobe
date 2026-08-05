#!/bin/bash
# Ilova nomini "uztove" qilish va paket nomini o‘zgartirishga yordam berish
# Diqqat: To‘liq applicationId o‘zgartirish murakkab. Bu skript asosan ko‘rinadigan nomni o‘zgartiradi.

set -e

echo "==> uztove nomiga o‘zgartirish boshlandi..."

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

# 1. Ko‘rinadigan app nomi
STRINGS="app/src/main/res/values/strings.xml"
if [ -f "$STRINGS" ]; then
  echo "  - app_name → uztove"
  # app_name mavjud bo‘lsa almashtirish, bo‘lmasa qo‘shish
  if grep -q 'name="app_name"' "$STRINGS"; then
    sed -i 's/<string name="app_name">[^<]*<\/string>/<string name="app_name">uztove<\/string>/' "$STRINGS"
  else
    # resources ichiga qo‘shish
    sed -i 's/<\/resources>/<string name="app_name">uztove<\/string>\n<\/resources>/' "$STRINGS"
  fi
fi

# 2. build.gradle da applicationId ni o‘zgartirish (ixtiyoriy, xavfliroq)
BUILD_GRADLE="app/build.gradle"
if [ -f "$BUILD_GRADLE" ]; then
  echo "  - applicationId ni uz.tove.app ga o‘zgartirishga harakat..."
  # Faqat comment sifatida ko‘rsatamiz yoki ehtiyotkorlik bilan
  if grep -q 'applicationId' "$BUILD_GRADLE"; then
    # Backup
    cp "$BUILD_GRADLE" "$BUILD_GRADLE.bak"
    sed -i 's/applicationId\s*"org\.schabi\.newpipe"/applicationId "uz.tove.app"/' "$BUILD_GRADLE" || true
    sed -i 's/applicationId\s*"org.schabi.newpipe"/applicationId "uz.tove.app"/' "$BUILD_GRADLE" || true
    echo "    Eslatma: applicationId o‘zgartirilgan bo‘lishi mumkin. Agar build xato bersa, .bak fayldan qaytaring."
  fi
fi

# 3. AndroidManifest da label
MANIFEST="app/src/main/AndroidManifest.xml"
if [ -f "$MANIFEST" ]; then
  echo "  - AndroidManifest label tekshiruvi..."
  # odatda @string/app_name ishlatiladi, shuning uchun strings.xml yetarli
fi

echo "==> Nom o‘zgartirish yakunlandi."
echo "    Ilova endi 'uztove' deb ko‘rinadi."
echo "    Paket nomi to‘liq o‘zgarmagan bo‘lishi mumkin – bu normal."
