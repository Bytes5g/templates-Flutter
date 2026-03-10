/// مساعدات التحقق من صحة البيانات
library;

/// طبقة التحقق من صحة المدخلات على مستوى الواجهة
class Validators {
  Validators._();

  /// التحقق من البريد الإلكتروني
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value.trim())) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  /// التحقق من كلمة المرور
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 8) {
      return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'يجب أن تحتوي على حرف كبير على الأقل';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'يجب أن تحتوي على رقم على الأقل';
    }
    return null;
  }

  /// التحقق من الحقول المطلوبة
  static String? required(String? value, {String fieldName = 'هذا الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    return null;
  }

  /// التحقق من رقم الهاتف (الخليجي)
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    // يقبل الأرقام الخليجية: +966xxxxxxxxx أو 05xxxxxxxx
    final regex = RegExp(r'^(\+966|0)?[5][0-9]{8}$');
    if (!regex.hasMatch(value.replaceAll(' ', ''))) {
      return 'رقم الهاتف غير صحيح';
    }
    return null;
  }

  /// التحقق من طول النص
  static String? Function(String?) minLength(int min) => (String? value) {
    if (value != null && value.isNotEmpty && value.length < min) {
      return 'يجب أن يكون $min حرف على الأقل';
    }
    return null;
  };

  static String? Function(String?) maxLength(int max) => (String? value) {
    if (value != null && value.length > max) {
      return 'يجب ألا يتجاوز $max حرف';
    }
    return null;
  };

  /// تجميع عدة validators
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) =>
      (String? value) {
        for (final validator in validators) {
          final error = validator(value);
          if (error != null) return error;
        }
        return null;
      };
}
