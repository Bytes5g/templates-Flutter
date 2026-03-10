/// إعداد التدويل
library;

import 'package:flutter/material.dart';

/// الدول المدعومة
class AppLocale {
  AppLocale._();

  static const Locale arabic  = Locale('ar');
  static const Locale english = Locale('en');

  static const List<Locale> supported = [arabic, english];

  /// اللغة الافتراضية
  static const Locale defaultLocale = arabic;

  /// هل هذه لغة RTL؟
  static bool isRtl(Locale locale) =>
      locale.languageCode == 'ar' || locale.languageCode == 'he' || locale.languageCode == 'fa';
}
