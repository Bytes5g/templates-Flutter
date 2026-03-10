/// Cubit إدارة حالة التطبيق (لغة، ثيم)
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../l10n/app_locale.dart';

/// حالة إعدادات التطبيق
class AppSettingsState {
  const AppSettingsState({
    required this.locale,
    required this.themeMode,
  });

  final Locale locale;
  final ThemeMode themeMode;

  AppSettingsState copyWith({Locale? locale, ThemeMode? themeMode}) =>
      AppSettingsState(
        locale: locale ?? this.locale,
        themeMode: themeMode ?? this.themeMode,
      );
}

/// Cubit إدارة إعدادات التطبيق
class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit()
      : super(const AppSettingsState(
          locale: AppLocale.defaultLocale,
          themeMode: ThemeMode.system,
        )) {
    _loadSavedSettings();
  }

  Future<void> _loadSavedSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode  = prefs.getString(StorageKeys.appLocale);
    final themeValue  = prefs.getInt(StorageKeys.appTheme);
    emit(state.copyWith(
      locale: localeCode != null ? Locale(localeCode) : AppLocale.defaultLocale,
      themeMode: themeValue != null
          ? ThemeMode.values[themeValue]
          : ThemeMode.system,
    ));
  }

  Future<void> changeLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.appLocale, locale.languageCode);
    emit(state.copyWith(locale: locale));
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(StorageKeys.appTheme, themeMode.index);
    emit(state.copyWith(themeMode: themeMode));
  }
}
