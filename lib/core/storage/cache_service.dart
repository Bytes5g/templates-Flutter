/// خدمة الكاش المحلي باستخدام Hive
library;

import 'package:hive_flutter/hive_flutter.dart';
import '../config/app_config.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';

/// خدمة التخزين المؤقت الذكي
class CacheService {
  CacheService._();

  static Box? _cacheBox;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    _cacheBox = await Hive.openBox(HiveBoxes.cache);
  }

  static Box get _box {
    if (_cacheBox == null || !_cacheBox!.isOpen) {
      throw StateError('CacheService غير مُهيَّأ. استدعِ initialize() أولاً.');
    }
    return _cacheBox!;
  }

  /// حفظ بيانات مع طابع زمني
  static Future<void> set(String key, dynamic value) async {
    try {
      await _box.put('data_$key', value);
      await _box.put('ts_$key', DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      AppLogger.error('خطأ في حفظ الكاش للمفتاح: $key', e);
    }
  }

  /// قراءة البيانات إن لم تنتهِ صلاحيتها
  static T? get<T>(String key, {bool allowStale = false}) {
    try {
      final timestamp = _box.get('ts_$key') as int?;
      if (timestamp == null) return null;

      final age = DateTime.now().millisecondsSinceEpoch - timestamp;
      final maxAge = AppConfig.cacheMaxAge * 1000;
      final maxStale = AppConfig.cacheMaxStale * 1000;

      if (!allowStale && age > maxAge) return null;
      if (allowStale && age > maxStale) return null;

      return _box.get('data_$key') as T?;
    } catch (e) {
      AppLogger.error('خطأ في قراءة الكاش للمفتاح: $key', e);
      return null;
    }
  }

  /// حذف مفتاح محدد
  static Future<void> remove(String key) async {
    await _box.delete('data_$key');
    await _box.delete('ts_$key');
  }

  /// مسح الكاش المنتهي
  static Future<void> clearExpired() async {
    final keys = _box.keys.where((k) => k.toString().startsWith('ts_')).toList();
    final now = DateTime.now().millisecondsSinceEpoch;
    final maxStale = AppConfig.cacheMaxStale * 1000;

    for (final key in keys) {
      final ts = _box.get(key) as int?;
      if (ts != null && (now - ts) > maxStale) {
        final dataKey = key.toString().replaceFirst('ts_', 'data_');
        await _box.delete(key);
        await _box.delete(dataKey);
      }
    }
  }

  /// مسح كامل الكاش
  static Future<void> clearAll() async {
    await _box.clear();
  }

  /// هل البيانات موجودة وغير منتهية؟
  static bool isValid(String key) => get(key) != null;
}
