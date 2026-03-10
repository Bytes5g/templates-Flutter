/// التوطين العربي
library;

import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

/// توطين اللغة العربية
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr() : super('ar');

  @override String get appName => 'نموذج Flutter';
  @override String get loading => 'جاري التحميل...';
  @override String get retry => 'إعادة المحاولة';
  @override String get cancel => 'إلغاء';
  @override String get confirm => 'تأكيد';
  @override String get save => 'حفظ';
  @override String get edit => 'تعديل';
  @override String get delete => 'حذف';
  @override String get search => 'بحث';
  @override String get filter => 'تصفية';
  @override String get back => 'رجوع';
  @override String get next => 'التالي';
  @override String get previous => 'السابق';
  @override String get done => 'تم';
  @override String get yes => 'نعم';
  @override String get no => 'لا';
  @override String get close => 'إغلاق';
  @override String get share => 'مشاركة';
  @override String get home => 'الرئيسية';
  @override String get categories => 'التصنيفات';
  @override String get profile => 'الملف الشخصي';
  @override String get settings => 'الإعدادات';
  @override String get notifications => 'الإشعارات';
  @override String get login => 'تسجيل الدخول';
  @override String get register => 'إنشاء حساب';
  @override String get logout => 'تسجيل الخروج';
  @override String get email => 'البريد الإلكتروني';
  @override String get password => 'كلمة المرور';
  @override String get forgotPassword => 'نسيت كلمة المرور؟';
  @override String get loginButton => 'دخول';
  @override String get errorTitle => 'حدث خطأ';
  @override String get errorGeneral => 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
  @override String get errorNetwork => 'تعذّر الاتصال بالخادم. تحقق من اتصالك بالإنترنت.';
  @override String get errorOffline => 'لا يوجد اتصال بالإنترنت.';
  @override String get errorNotFound => 'المحتوى المطلوب غير موجود.';
  @override String get errorServer => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';
  @override String get errorUnauthorized => 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.';
  @override String get offlineBannerMessage => 'أنت غير متصل بالإنترنت. يتم عرض البيانات المخزنة مؤقتاً.';
  @override String offlineQueueMessage(int count) =>
      intl.Intl.pluralLogic(count, locale: 'ar',
        zero: 'لا توجد عمليات معلقة',
        one: 'عملية واحدة معلقة سترسل عند عودة الاتصال',
        two: 'عمليتان معلقتان ستُرسلان عند عودة الاتصال',
        few: '$count عمليات معلقة ستُرسل عند عودة الاتصال',
        many: '$count عملية معلقة ستُرسل عند عودة الاتصال',
        other: '$count عملية معلقة',
      );
  @override String get emptyTitle => 'لا يوجد محتوى';
  @override String get emptyDescription => 'لم يتم العثور على أي محتوى. تحقق لاحقاً.';
  @override String emptySearchDescription(String query) =>
      'لم يتم العثور على نتائج لـ "$query".';
  @override String get page404Title => 'الصفحة غير موجودة';
  @override String get page404Description => 'الرابط الذي أدخلته غير موجود أو تم تغييره.';
  @override String get goHome => 'العودة للرئيسية';
  @override String get searchHint => 'ابحث هنا...';
  @override String searchResultsFor(String query) => 'نتائج البحث عن: $query';
  @override String get seeAll => 'عرض الكل';
  @override String get viewDetails => 'عرض التفاصيل';
  @override String get readMore => 'اقرأ المزيد';
  @override String get showLess => 'إظهار أقل';
  @override String get language => 'اللغة';
  @override String get languageArabic => 'العربية';
  @override String get languageEnglish => 'English';
  @override String get theme => 'المظهر';
  @override String get themeLight => 'فاتح';
  @override String get themeDark => 'داكن';
  @override String get themeSystem => 'النظام';
  @override String validationRequired(String field) => '$field مطلوب';
  @override String get validationEmail => 'صيغة البريد الإلكتروني غير صحيحة';
  @override String get validationPasswordLength => 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
  @override String get validationPasswordUppercase => 'كلمة المرور يجب أن تحتوي على حرف كبير';
  @override String get validationPasswordNumber => 'كلمة المرور يجب أن تحتوي على رقم';
}
