import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/app_config.dart';
import '../constants/app_constants.dart';
import '../error/exceptions.dart';

/// خدمة التخزين المحلي - تجمع بين Hive (بيانات) وFlutterSecureStorage (بيانات حساسة)
class LocalStorage {
  late Box<dynamic> _box;
  final FlutterSecureStorage _secureStorage;

  LocalStorage(this._secureStorage);

  /// تهيئة قاعدة البيانات المحلية
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<dynamic>(AppConfig.hiveBoxName);
  }

  // ---- بيانات عادية (Hive) ----

  /// حفظ كائن JSON
  Future<void> saveJson(String key, Map<String, dynamic> data) async {
    try {
      final withTimestamp = {
        ...data,
        '_cached_at': DateTime.now().millisecondsSinceEpoch,
      };
      await _box.put(key, jsonEncode(withTimestamp));
    } catch (e) {
      throw CacheException(message: 'فشل حفظ البيانات: $e');
    }
  }

  /// قراءة كائن JSON
  Map<String, dynamic>? getJson(String key) {
    try {
      final raw = _box.get(key) as String?;
      if (raw == null) return null;
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// حفظ قائمة JSON
  Future<void> saveJsonList(String key, List<Map<String, dynamic>> data) async {
    try {
      final payload = {
        'items': data,
        '_cached_at': DateTime.now().millisecondsSinceEpoch,
      };
      await _box.put(key, jsonEncode(payload));
    } catch (e) {
      throw CacheException(message: 'فشل حفظ القائمة: $e');
    }
  }

  /// قراءة قائمة JSON
  List<Map<String, dynamic>>? getJsonList(String key) {
    try {
      final raw = _box.get(key) as String?;
      if (raw == null) return null;
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final items = decoded['items'] as List<dynamic>?;
      return items?.cast<Map<String, dynamic>>();
    } catch (e) {
      return null;
    }
  }

  /// هل انتهت صلاحية التخزين المؤقت؟
  bool isCacheExpired(String key) {
    try {
      final raw = _box.get(key) as String?;
      if (raw == null) return true;
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final cachedAt = decoded['_cached_at'] as int?;
      if (cachedAt == null) return true;
      final ttl = Duration(hours: AppConfig.cacheTtlHours);
      final cached = DateTime.fromMillisecondsSinceEpoch(cachedAt);
      return DateTime.now().difference(cached) > ttl;
    } catch (e) {
      return true;
    }
  }

  /// حفظ قيمة بسيطة
  Future<void> setValue<T>(String key, T value) async {
    await _box.put(key, value);
  }

  /// قراءة قيمة بسيطة
  T? getValue<T>(String key) => _box.get(key) as T?;

  /// حذف مفتاح
  Future<void> remove(String key) async => _box.delete(key);

  /// مسح كل البيانات المخزنة مؤقتاً
  Future<void> clearAll() async => _box.clear();

  // ---- بيانات حساسة (FlutterSecureStorage) ----

  /// حفظ بيانات حساسة (توكن، كلمة مرور)
  Future<void> saveSecure(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// قراءة بيانات حساسة
  Future<String?> getSecure(String key) async {
    return _secureStorage.read(key: key);
  }

  /// حذف بيانات حساسة
  Future<void> removeSecure(String key) async {
    await _secureStorage.delete(key: key);
  }

  // ---- اختصارات للمفاتيح الشائعة ----

  Future<void> saveToken(String token) =>
      saveSecure(AppStorageKeys.userToken, token);

  Future<String?> getToken() => getSecure(AppStorageKeys.userToken);

  Future<void> removeToken() => removeSecure(AppStorageKeys.userToken);

  Future<void> saveThemeMode(String mode) =>
      setValue(AppStorageKeys.themeMode, mode);

  String getThemeMode() =>
      getValue<String>(AppStorageKeys.themeMode) ?? 'system';

  Future<void> saveLanguageCode(String code) =>
      setValue(AppStorageKeys.languageCode, code);

  String getLanguageCode() =>
      getValue<String>(AppStorageKeys.languageCode) ?? 'ar';
}
