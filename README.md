# Flutter Template - النموذج الذهبي لتطبيقات الموبايل

قالب Flutter متكامل يعتمد على هندسة برمجية نظيفة وقابلة للتوسع. مبني بالكامل للغة العربية مع دعم RTL الكامل.

---

## 🏗️ هيكل المشروع

```
lib/
├── main.dart                        # نقطة الدخول - تهيئة .env والـ DI
├── app/
│   └── app.dart                     # MaterialApp مع الثيم والتوجيه والـ RTL
├── core/                            # طبقة النواة
│   ├── config/
│   │   └── app_config.dart          # إعدادات من .env (Zero Hard-coding)
│   ├── constants/
│   │   └── app_constants.dart       # الأحجام والألوان والمفاتيح
│   ├── di/
│   │   └── service_locator.dart     # حقن التبعيات (GetIt)
│   ├── error/
│   │   ├── exceptions.dart          # استثناءات طبقة البيانات
│   │   └── failures.dart            # أخطاء طبقة Domain (Either)
│   ├── extensions/
│   │   ├── context_extensions.dart  # امتدادات BuildContext
│   │   └── string_extensions.dart   # امتدادات String
│   ├── network/
│   │   ├── dio_client.dart          # HTTP مع Interceptors
│   │   └── network_info.dart        # فحص الاتصال
│   ├── router/
│   │   ├── app_router.dart          # GoRouter مع Deep Links
│   │   └── route_names.dart         # أسماء المسارات المركزية
│   ├── storage/
│   │   └── local_storage.dart       # Hive + FlutterSecureStorage
│   ├── theme/
│   │   └── app_theme.dart           # الثيم الفاتح والداكن
│   └── utils/
│       ├── validators.dart          # التحقق من المدخلات
│       └── responsive_utils.dart    # أدوات الاستجابة
├── l10n/
│   └── arb/
│       └── app_ar.arb               # ترجمات العربية
├── features/
│   ├── splash/                      # صفحة البداية
│   ├── home/                        # الصفحة الرئيسية (Clean Architecture)
│   │   ├── data/                    # طبقة البيانات
│   │   │   ├── datasources/         # Remote + Local
│   │   │   ├── models/              # JSON serialization
│   │   │   └── repositories/        # Offline-First implementation
│   │   ├── domain/                  # طبقة Domain (Business Logic)
│   │   │   ├── entities/            # الكيانات النقية
│   │   │   ├── repositories/        # Abstract contracts
│   │   │   └── usecases/            # Use Cases (Single Responsibility)
│   │   └── presentation/            # طبقة العرض
│   │       ├── bloc/                # BLoC (Events/States)
│   │       ├── pages/               # الصفحات
│   │       └── widgets/             # Widgets الخاصة بالميزة
│   ├── settings/                    # الإعدادات
│   └── error/                       # صفحات الأخطاء (404, Error)
└── widgets/                         # نظام المكونات الذرية
    ├── atoms/                       # الوحدات الصغيرة
    │   ├── app_text.dart            # النص
    │   ├── app_button.dart          # الأزرار
    │   ├── app_image.dart           # الصور (Cached + Lazy)
    │   └── app_loading_indicator.dart # مؤشرات التحميل
    ├── molecules/                   # التركيبات المتوسطة
    │   ├── app_card.dart            # البطاقة
    │   ├── app_text_field.dart      # حقل الإدخال
    │   └── app_error_widget.dart    # عارض الخطأ
    └── organisms/                   # الكيانات الكاملة
        └── app_nav_bars.dart        # AppBar + BottomNavBar
```

---

## 📋 المتطلبات

- Flutter ≥ 3.3.0
- Dart ≥ 3.3.0

---

## 🚀 البدء السريع

### 1. نسخ ملف البيئة
```bash
cp .env.example .env
# عدّل القيم حسب بيئتك
```

### 2. تثبيت التبعيات
```bash
flutter pub get
```

### 3. توليد ملفات الترجمة
```bash
flutter gen-l10n
```

### 4. تشغيل التطبيق
```bash
flutter run
```

---

## 🏛️ المبادئ المعمارية

| المبدأ | التطبيق |
|--------|---------|
| **Clean Architecture** | Domain / Data / Presentation |
| **Zero Hard-coding** | ملف `.env` + `AppConfig` |
| **DRY** | مكونات ذرية + خدمات مشتركة |
| **Offline-First** | Hive + استراتيجية Cache |
| **RTL + i18n** | Arabic ARB + `flutter_localizations` |
| **Deep Links** | GoRouter مع `redirect` ذكي |
| **Responsive** | `flutter_screenutil` + breakpoints |

---

## 📦 التبعيات الرئيسية

| الحزمة | الغرض |
|--------|-------|
| `flutter_bloc` | إدارة الحالة (BLoC Pattern) |
| `go_router` | التوجيه المتقدم + Deep Links |
| `get_it` | حقن التبعيات |
| `dio` | HTTP client |
| `hive_flutter` | قاعدة بيانات محلية |
| `flutter_secure_storage` | تخزين آمن للتوكن |
| `flutter_dotenv` | متغيرات البيئة |
| `cached_network_image` | تخزين الصور مؤقتاً |
| `flutter_screenutil` | واجهة استجابية |
| `dartz` | Either/Option (Functional) |
| `equatable` | مقارنة الكائنات |

---

## 🧪 الاختبارات

```bash
flutter test
```

---

## 🌍 إضافة لغة جديدة

1. أنشئ ملف `lib/l10n/arb/app_en.arb`
2. أضف `const Locale('en')` إلى `supportedLocales` في `app.dart`
3. شغّل `flutter gen-l10n`

---

## 🔗 الروابط العميقة (Deep Links)

**مثال:** فتح تصنيف بمعرّف `123`:
```
myapp://app.example.com/deep/categories/123
```

يُعاد التوجيه تلقائياً إلى: `/home/categories/123`

---

## 📁 متغيرات البيئة (.env)

```env
API_BASE_URL=https://api.example.com/v1
API_KEY=your_api_key
APP_NAME=اسم التطبيق
DEEP_LINK_SCHEME=myapp
DEEP_LINK_HOST=app.example.com
APP_ENV=development
```

> ⚠️ لا تضع قيماً حقيقية في `.env` المُرفق مع الكود في بيئة الإنتاج. استخدم CI/CD لتوليد ملف البيئة.