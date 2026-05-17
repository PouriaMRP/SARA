# MemorialApp — یادگاری ساده

این پروژه یک اپلیکیشن اندروید بسیار ساده است که یک پیام فارسی را نمایش می‌دهد. برای ساخت فایل `apk` می‌توانید از Android Studio استفاده کنید یا از خط فرمان با Gradle (نیاز به Android SDK و Java دارد).

روش پیشنهادی (Android Studio):

1. Android Studio را باز کنید.
2. از منو `File` → `Open`، شاخهٔ پروژه (این پوشه) را انتخاب کنید.
3. اجازه دهید Gradle و SDK دانلود شوند.
4. از `Build` → `Build Bundle(s) / APK(s)` → `Build APK(s)` استفاده کنید. خروجی در `app/build/outputs/apk/` قرار می‌گیرد.


خط فرمان (در صورتی که Gradle و Android SDK راه‌اندازی شده باشند):

```bash
# در ویندوز، داخل پوشه پروژه اجرا کنید:
gradlew assembleRelease
```

اگر نمی‌خواهی محلی ابزارها را نصب کنی، من یک workflow برای GitHub Actions اضافه کردم تا با آپلود پروژه در GitHub، CI به‌صورت خودکار `apk` را بسازد و artifact را برای دانلود تولید کند. برای استفاده:

1. یک مخزن جدید در GitHub ایجاد کن و این پوشه را در آن push کن.
2. به تب `Actions` برو و workflow `Build APK` را اجرا کن یا صبر کن وقتی `main`/`master` را push کردی اجرا شود.
3. پس از اجرا، در قسمت job artifacts خروجی `app-apk` را دانلود کن (فایل APK داخل `app/build/outputs/apk/`).

برای ساخت Release امضاشده خودکار (بدون نیاز به نصب محلی ابزارها):

1. یک مخزن در GitHub بساز و این پوشه را push کن (دستورالعمل‌های گیت بالاتر).
2. در Settings -> Secrets مخزن، چهار secret جدید اضافه کن:
	- `KEYSTORE_BASE64`: محتوای base64 فایل keystore (`release-keystore.jks`) — می‌توانی فایل keystore را محلی با `scripts/generate-keystore.ps1` بسازی و خروجی base64 را در فایل `release-keystore.jks.base64.txt` می‌بینی.
	- `KEYSTORE_PASSWORD`: رمز keystore
	- `KEY_ALIAS`: نام alias (مثلاً `releasekey`)
	- `KEY_PASSWORD`: رمز کلید (معمولاً همان رمز keystore)
3. پس از push، workflow `Build Release APK (signed)` اجرا می‌شود؛ artifact با نام `app-release-apk` حاوی `app-release.apk` آماده دانلود است.

اگر دوست داری من تمام این مراحل را برایت انجام بدهم (ایجاد مخزن و push)، آدرس مخزن یا دسترسی موقت GitHub را بده؛ در غیر این صورت همین دستورالعمل‌ها را دنبال کن و هر جا مشکلی بود من کمک می‌کنم.


نکته‌ها:
- برای نصب مستقیم روی گوشی، گزینهٔ `minSdk` در `app/build.gradle` روی `16` تنظیم شده تا با اکثر دستگاه‌ها سازگار باشد.
- اگر می‌خواهید من برای ساخت `apk` از راه دور (مثلاً در یک سرور CI) کمک کنم، به من بگویید تا فایل‌های تنظیمی اضافی را اضافه کنم.
