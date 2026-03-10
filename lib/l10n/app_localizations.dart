/// ملف التوطين المُولَّد تلقائياً من ملفات .arb
/// لا تعدّل هذا الملف يدوياً
library;

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// الفئة الأساسية للتوطين
abstract class AppLocalizations {
  AppLocalizations(this.localeName);

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  // ─── النصوص ───
  String get appName;
  String get loading;
  String get retry;
  String get cancel;
  String get confirm;
  String get save;
  String get edit;
  String get delete;
  String get search;
  String get filter;
  String get back;
  String get next;
  String get previous;
  String get done;
  String get yes;
  String get no;
  String get close;
  String get share;
  String get home;
  String get categories;
  String get profile;
  String get settings;
  String get notifications;
  String get login;
  String get register;
  String get logout;
  String get email;
  String get password;
  String get forgotPassword;
  String get loginButton;
  String get errorTitle;
  String get errorGeneral;
  String get errorNetwork;
  String get errorOffline;
  String get errorNotFound;
  String get errorServer;
  String get errorUnauthorized;
  String get offlineBannerMessage;
  String offlineQueueMessage(int count);
  String get emptyTitle;
  String get emptyDescription;
  String emptySearchDescription(String query);
  String get page404Title;
  String get page404Description;
  String get goHome;
  String get searchHint;
  String searchResultsFor(String query);
  String get seeAll;
  String get viewDetails;
  String get readMore;
  String get showLess;
  String get language;
  String get languageArabic;
  String get languageEnglish;
  String get theme;
  String get themeLight;
  String get themeDark;
  String get themeSystem;
  String validationRequired(String field);
  String get validationEmail;
  String get validationPasswordLength;
  String get validationPasswordUppercase;
  String get validationPasswordNumber;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  return switch (locale.languageCode) {
    'ar' => AppLocalizationsAr(),
    'en' => AppLocalizationsEn(),
    _    => AppLocalizationsAr(),
  };
}
