# uztove – NewPipe asosida TalkBack tuzatilgan APK (GitHub Actions)

Bu to‘plam **NewPipe** ni fork qilib, TalkBack (ekran o‘quvchi) tuzatishlarini qo‘llash va **GitHub Actions** orqali APK qurishni avtomatlashtirish uchun tayyorlangan.

**Ilova nomi:** uztove  
**Tavsiya etilgan paket nomi:** `uz.tove.app` (YouTube yoki NewPipe bilan to‘qnashmaydi)

---

## 1. Tezkor boshlash (5–10 daqiqa)

### 1.1. NewPipe ni fork qiling
1. https://github.com/TeamNewPipe/NewPipe ga kiring
2. Yuqoridagi **Fork** tugmasini bosing
3. O‘z GitHub akkauntingizga fork qiling

### 1.2. Ushbu fayllarni fork qilingan repoga qo‘shing
1. Ushbu ZIP ni yuklab oling va oching
2. Quyidagi fayllarni o‘z forkingizga (GitHub web yoki Desktop orqali) joylashtiring:

```
.github/workflows/build-apk.yml          ← APK qurish avtomatizatsiyasi
patches/talkback-fixes.patch             ← TalkBack tuzatishlari
scripts/apply-talkback-fixes.sh          ← Tuzatishlarni qo‘llash skripti
scripts/rename-to-uztove.sh              ← Nom va paketni o‘zgartirish (ixtiyoriy)
```

Yoki GitHub web interfeysida:
- **Add file → Upload files** orqali `.github/workflows/build-apk.yml` ni yuklang
- Qolgan fayllarni ham xuddi shunday qo‘shing

### 1.3. GitHub Actions ni ishga tushiring
1. Fork qilingan repoda **Actions** tabiga o‘ting
2. **Build uztove APK** workflow ni tanlang
3. **Run workflow** → **Run workflow** tugmasini bosing
4. Bir necha daqiqadan keyin **Artifacts** bo‘limidan APK ni yuklab oling

---

## 2. TalkBack tuzatishlari nima qiladi?

Quyidagi muammolar tuzatiladi:

| Fayl | Muammo | Tuzatish |
|------|--------|----------|
| `mission_item.xml` | `contentDescription="TODO"` | "More actions" / "Download status" |
| `mission_item_linear.xml` | `contentDescription="TODO"` | Xuddi shu |
| `select_kiosk_item.xml` | `contentDescription="TODO"` | Kiosk nomi |
| Player va boshqa joylar | Ba'zi e'tiborsiz qoldirilgan ikonkalar | Ma'noli tavsiflar |

Tuzatishlar `patches/talkback-fixes.patch` orqali avtomatik qo‘llanadi.

---

## 3. Ilova nomi va paket nomini o‘zgartirish (tavsiya etiladi)

Standart NewPipe paket nomi `org.schabi.newpipe`. Uni o‘zgartirish uchun:

```bash
# Lokalda yoki GitHub Codespaces da
chmod +x scripts/rename-to-uztove.sh
./scripts/rename-to-uztove.sh
```

Skript quyidagilarni o‘zgartiradi:
- `app_name` → **uztove**
- `applicationId` → `uz.tove.app`
- Asosiy manifest va ba'zi resurslar

**Eslatma:** To‘liq paket nomini o‘zgartirish murakkab (ko‘p fayllarni yangilash kerak). Eng oddiy va xavfsiz usul — faqat **ko‘rinadigan nomni** (`app_name`) "uztove" qilish. Paket nomi o‘zgarmasa ham ishlaydi, lekin Play Store yoki boshqa joylarda farqlash uchun o‘zgartirish yaxshi.

---

## 4. Qo‘lda TalkBack tuzatishlarini qo‘llash

Agar patch ishlamasa:

```bash
chmod +x scripts/apply-talkback-fixes.sh
./scripts/apply-talkback-fixes.sh
```

Yoki quyidagi o‘zgarishlarni qo‘lda kiriting (avvalgi tahlildan):

**mission_item.xml** ichida:
```xml
android:contentDescription="@string/more_options"
```
va
```xml
android:contentDescription="@string/download"
```

**select_kiosk_item.xml**:
```xml
android:contentDescription="@string/kiosk"
```

---

## 5. APK ni o‘rnatish

1. Telefoningizda **Noma'lum manbalardan o‘rnatish** ga ruxsat bering
2. Yuklab olingan APK ni oching
3. O‘rnating

Agar eski NewPipe o‘rnatilgan bo‘lsa, paket nomi bir xil bo‘lsa o‘chirib tashlash kerak bo‘lishi mumkin.

---

## 6. Muammolar va yechimlar

| Muammo | Yechim |
|--------|--------|
| Actions ishlamayapti | Repo **Settings → Actions → General** da "Allow all actions" yoqilganligini tekshiring |
| Build xato beradi | `dev` yoki `master` branchda ekanligingizni tekshiring |
| TalkBack hali yomon o‘qiydi | Qo‘shimcha `contentDescription` larni qo‘lda qo‘shing (avvalgi tahlilga qarang) |
| Paket nomi to‘qnashuvi | `rename-to-uztove.sh` ni ishlating yoki `applicationId` ni o‘zingiz o‘zgartiring |

---

## 7. Litsenziya

NewPipe – GPLv3. Ushbu tuzatishlar va workflow ham xuddi shu litsenziya ostida. O‘z forkingizni ochiq qoldirish tavsiya etiladi.

---

**Savollar bo‘lsa** – GitHub issue oching yoki ushbu setup ni yangilang.
