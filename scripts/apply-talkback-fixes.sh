#!/bin/bash
# TalkBack (contentDescription) tuzatishlarini qo‘llash skripti
# NewPipe forkida ishlatish uchun

set -e

echo "==> TalkBack accessibility tuzatishlari qo‘llanilmoqda..."

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

# 1. mission_item.xml – TODO larni tozalash
MISSION_ITEM="app/src/main/res/layout/mission_item.xml"
if [ -f "$MISSION_ITEM" ]; then
  echo "  - $MISSION_ITEM"
  sed -i 's/android:contentDescription="TODO"/android:contentDescription="@string\/more_options"/g' "$MISSION_ITEM"
fi

# 2. mission_item_linear.xml
MISSION_LINEAR="app/src/main/res/layout/mission_item_linear.xml"
if [ -f "$MISSION_LINEAR" ]; then
  echo "  - $MISSION_LINEAR"
  sed -i 's/android:contentDescription="TODO"/android:contentDescription="@string\/more_options"/g' "$MISSION_LINEAR"
fi

# 3. select_kiosk_item.xml
KIOSK_ITEM="app/src/main/res/layout/select_kiosk_item.xml"
if [ -f "$KIOSK_ITEM" ]; then
  echo "  - $KIOSK_ITEM"
  sed -i 's/android:contentDescription="TODO"/android:contentDescription="@string\/kiosk"/g' "$KIOSK_ITEM" || \
  sed -i 's/android:contentDescription="TODO"/android:contentDescription="@string\/trending"/g' "$KIOSK_ITEM"
fi

# 4. Umumiy TODO contentDescription larni topib almashtirish
echo "  - Barcha qolgan TODO contentDescription larni qidirish..."
find app/src/main/res/layout -name "*.xml" -type f -print0 2>/dev/null | while IFS= read -r -d '' file; do
  if grep -q 'contentDescription="TODO"' "$file" 2>/dev/null; then
    echo "    Found TODO in $file → more_options"
    sed -i 's/android:contentDescription="TODO"/android:contentDescription="@string\/more_options"/g' "$file"
  fi
done

# 5. Ba'zi muhim player elementlariga qo‘shimcha tavsif (agar yo‘q bo‘lsa)
# (player.xml da ko‘p narsa allaqachon bor, shuning uchun faqat xavfsiz qo‘shimchalar)

echo "==> TalkBack tuzatishlari yakunlandi."
echo "    Keyingi qadam: GitHub Actions orqali APK quring yoki lokalda ./gradlew assembleDebug"
