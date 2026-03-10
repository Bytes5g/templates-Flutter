/// طابور العمليات دون اتصال (Offline Queue)
library;

import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';

/// عنصر في طابور الانتظار
class QueueItem {
  const QueueItem({
    required this.id,
    required this.method,
    required this.endpoint,
    required this.body,
    required this.createdAt,
  });

  final String id;
  final String method;
  final String endpoint;
  final Map<String, dynamic> body;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
    'id': id,
    'method': method,
    'endpoint': endpoint,
    'body': body,
    'createdAt': createdAt.toIso8601String(),
  };

  factory QueueItem.fromMap(Map<dynamic, dynamic> map) => QueueItem(
    id: map['id'] as String,
    method: map['method'] as String,
    endpoint: map['endpoint'] as String,
    body: Map<String, dynamic>.from(map['body'] as Map),
    createdAt: DateTime.parse(map['createdAt'] as String),
  );
}

/// خدمة طابور العمليات عند انقطاع الإنترنت
class OfflineQueueService {
  OfflineQueueService._();

  static Box? _box;

  static Future<void> initialize() async {
    _box = await Hive.openBox(HiveBoxes.queue);
  }

  static Box get _queue {
    if (_box == null || !_box!.isOpen) {
      throw StateError('OfflineQueueService غير مُهيَّأ.');
    }
    return _box!;
  }

  /// إضافة عملية إلى الطابور
  static Future<void> enqueue(QueueItem item) async {
    try {
      await _queue.put(item.id, item.toMap());
      AppLogger.info('تمت إضافة العملية إلى الطابور: ${item.id}');
    } catch (e) {
      AppLogger.error('خطأ في إضافة العملية للطابور', e);
    }
  }

  /// الحصول على جميع العمليات المعلقة
  static List<QueueItem> getAll() {
    return _queue.values
        .map((v) => QueueItem.fromMap(v as Map))
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  /// حذف عملية بعد تنفيذها
  static Future<void> remove(String id) async {
    await _queue.delete(id);
  }

  /// هل الطابور فارغ؟
  static bool get isEmpty => _queue.isEmpty;

  /// عدد العمليات المعلقة
  static int get count => _queue.length;
}
