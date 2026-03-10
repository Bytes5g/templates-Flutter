/// التخزين الآمن للبيانات الحساسة باستخدام SharedPreferences
/// في الإنتاج يُستبدل بـ flutter_secure_storage
library;

import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';

/// خدمة التخزين الآمن لرموز المصادقة
class SecureStorage {
  SecureStorage._();

  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get _instance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// حفظ رمز المصادقة
  static Future<void> saveToken(String token) async {
    try {
      final prefs = await _instance;
      await prefs.setString(StorageKeys.authToken, token);
    } catch (e) {
      AppLogger.error('خطأ في حفظ رمز المصادقة', e);
    }
  }

  /// قراءة رمز المصادقة
  static Future<String?> getToken() async {
    try {
      final prefs = await _instance;
      return prefs.getString(StorageKeys.authToken);
    } catch (e) {
      AppLogger.error('خطأ في قراءة رمز المصادقة', e);
      return null;
    }
  }

  /// حفظ رمز التحديث
  static Future<void> saveRefreshToken(String token) async {
    try {
      final prefs = await _instance;
      await prefs.setString(StorageKeys.refreshToken, token);
    } catch (e) {
      AppLogger.error('خطأ في حفظ رمز التحديث', e);
    }
  }

  /// قراءة رمز التحديث
  static Future<String?> getRefreshToken() async {
    try {
      final prefs = await _instance;
      return prefs.getString(StorageKeys.refreshToken);
    } catch (e) {
      AppLogger.error('خطأ في قراءة رمز التحديث', e);
      return null;
    }
  }

  /// حذف جميع بيانات المصادقة
  static Future<void> clearAuth() async {
    try {
      final prefs = await _instance;
      await prefs.remove(StorageKeys.authToken);
      await prefs.remove(StorageKeys.refreshToken);
    } catch (e) {
      AppLogger.error('خطأ في مسح بيانات المصادقة', e);
    }
  }
}
