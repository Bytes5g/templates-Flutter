# نموذج Flutter قابل للتوسع (Golden Template)

نموذج Flutter احترافي متكامل يُطبّق أفضل الممارسات الهندسية للتطبيقات متعددة المنصات.

## 🏗️ الهندسة البرمجية

### هيكلية الطبقات (Clean Architecture)

```
lib/
├── core/                        # النواة المشتركة
│   ├── config/                  # تكوين البيئة من .env (بدون hard-coding)
│   ├── constants/               # ثوابت التطبيق (مفاتيح، أبعاد، مسارات)
│   ├── di/                      # حقن التبعيات (get_it)
│   ├── errors/                  # طبقة الأخطاء الموحدة (Failures + Exceptions)
│   ├── network/                 # عميل Dio + مراقب الشبكة
│   ├── storage/                 # Hive (كاش) + SharedPreferences
│   ├── theme/                   # ثيم Material 3 + RTL
│   └── utils/                   # Either، Validators، Logger، ScreenHelper
├── data/                        # طبقة البيانات
│   ├── datasources/
│   │   ├── remote/              # مصدر بيانات API (Dio)
│   │   └── local/               # مصدر بيانات محلي (Hive)
│   ├── models/                  # نماذج JSON + توليد تلقائي (json_serializable)
│   └── repositories/            # تنفيذ Offline-First
├── domain/                      # طبقة المجال (خالصة)
│   ├── entities/                # كيانات Equatable
│   ├── repositories/            # واجهات المستودعات (عقود)
│   └── usecases/                # حالات الاستخدام (DRY pattern)
├── presentation/                # طبقة العرض
│   ├── bloc/                    # BLoC + Cubit لإدارة الحالة
│   └── widgets/
│       ├── atoms/               # AppText, AppButton, AppImage, AppTextField
│       ├── molecules/           # ContentCard, CategoryChip, ErrorView, OfflineBanner
│       ├── organisms/           # ContentListView, CategoryTreeView
│       └── templates/           # AppScaffold, BlocStateBuilder
├── l10n/                        # التوطين: عربي + إنجليزي (ARB)
└── router/                      # GoRouter + DeepLinkHandler
```

## ✅ المتطلبات المُنفَّذة

### 1. هيكلية المكونات الذرية (Atomic Widgets)
- **Atoms**: `AppText`, `AppButton`, `AppImage`, `AppTextField`, `AppLoadingIndicator`
- **Molecules**: `ContentCard`, `CategoryChip`, `ErrorView`, `EmptyView`, `OfflineBanner`
- **Organisms**: `ContentListView`, `CategoryTreeView`
- **Templates**: `AppScaffold`, `BlocStateBuilder`

### 2. فصل الاهتمامات وإدارة الحالة (BLoC)
- فصل تام بين منطق الأعمال والبيانات والعرض
- `CategoryBloc`, `NetworkCubit`, `AppSettingsCubit`
- حالات موحدة: `InitialState`, `LoadingState`, `SuccessState`, `FailureState`

### 3. حظر القيم الثابتة (Zero Hard-coding)
- جميع القيم تأتي من ملفات `.env`
- `AppConfig` يُحكم القراءة ويُرفع استثناء إن غابت قيمة
- `AppDimensions`, `AppFonts`, `AppRoutes` لكل الثوابت

### 4. مبدأ DRY
- `_fetchWithCache` نمط موحد في جميع Repositories
- `BlocStateBuilder` يعالج جميع حالات BLoC
- `UseCase` الأساسي يُطبَّق مرة واحدة ويُرث

### 5. التدويل (i18n) مع دعم RTL
- ملفات `.arb` للعربية والإنجليزية
- اللغة الافتراضية: العربية
- `Directionality` يُطبَّق تلقائياً

### 6. التوجيه المتقدم والروابط العميقة
- `GoRouter` مع Named Routes
- `DeepLinkHandler` يستقبل ويحوّل الروابط الخارجية
- دعم Universal Links (iOS) وApp Links (Android)

### 7. الأداء والتخزين المحلي (Offline-First)
- `CacheService` مع صلاحية ذكية
- `OfflineQueueService` لتخزين العمليات دون اتصال
- Lazy Loading مع SliverList/SliverGrid
- صور محسّنة: WebP، ضغط، CachedNetworkImage، Shimmer

### 8. معالجة الأخطاء
- `AppFailure` هرمي مع اقتراحات ذكية
- `ErrorMapper` يحوّل أي استثناء
- `OfflineBanner` يظهر تلقائياً

### 9. التجاوبية الكاملة
- `ScreenHelper` لكل أحجام الشاشات
- تخطيط مختلف للموبايل واللوحي والسطح

## 🚀 بدء الاستخدام

```bash
# إعداد البيئة
cp .env .env.local
# عدّل القيم في .env

# تثبيت المكتبات
flutter pub get

# توليد الكود
flutter pub run build_runner build --delete-conflicting-outputs

# تشغيل التطبيق
flutter run

# الاختبارات
flutter test
```

## 📦 المكتبات الرئيسية

| المكتبة | الغرض |
|---------|--------|
| `flutter_bloc` | إدارة الحالة |
| `go_router` | التوجيه + Deep Links |
| `dio` | عميل HTTP |
| `hive_flutter` | تخزين محلي |
| `get_it` | حقن التبعيات |
| `cached_network_image` | صور مُحسَّنة |
| `flutter_dotenv` | ملفات `.env` |
| `connectivity_plus` | مراقبة الشبكة |
| `equatable` | مقارنة الكيانات |
| `shimmer` | تأثير التحميل |

## 🔒 الأمان

- ملفات `.env` مُستثناة من Git
- API Keys من البيئة فقط
- تحقق من صحة المدخلات (`Validators`)
