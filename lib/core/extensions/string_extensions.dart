/// امتدادات String للعمليات الشائعة
extension StringExtensions on String {
  /// هل النص فارغ أو يحتوي مسافات فقط؟
  bool get isBlank => trim().isEmpty;

  /// هل النص غير فارغ؟
  bool get isNotBlank => !isBlank;

  /// هل هو بريد إلكتروني صالح؟
  bool get isValidEmail {
    final regex = RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(trim());
  }

  /// هل هو رقم هاتف عربي صالح؟
  bool get isValidArabicPhone {
    final regex = RegExp(r'^(\+966|00966|05)\d{8,9}$');
    return regex.hasMatch(trim());
  }

  /// هل هو رقم صالح؟
  bool get isNumeric => double.tryParse(this) != null;

  /// اقتطاع النص مع إضافة ... إذا تجاوز الحد
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  /// تحويل إلى أحرف كبيرة (للنصوص الإنجليزية)
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// إزالة المسافات الزائدة
  String get trimmed => trim().replaceAll(RegExp(r'\s+'), ' ');
}

/// امتدادات String? للتعامل مع القيم القابلة للإلغاء
extension NullableStringExtensions on String? {
  /// هل القيمة null أو فارغة؟
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// هل القيمة null أو فارغة أو مسافات فقط؟
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  /// إرجاع قيمة افتراضية إذا كانت null أو فارغة
  String orDefault(String defaultValue) =>
      isNullOrEmpty ? defaultValue : this!;
}
