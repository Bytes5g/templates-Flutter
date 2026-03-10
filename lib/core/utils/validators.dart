/// أدوات التحقق من صحة المدخلات
/// مرجعية موحدة لجميع عمليات التحقق في التطبيق (DRY)
class Validators {
  Validators._();

  /// التحقق من حقل مطلوب
  static String? required(String? value, [String message = 'هذا الحقل مطلوب']) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  /// التحقق من صحة البريد الإلكتروني
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final regex = RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    );
    if (!regex.hasMatch(value.trim())) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  /// التحقق من رقم الهاتف (يدعم أرقام خليجية وعربية)
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    final regex = RegExp(r'^(\+?\d{7,15})$');
    if (!regex.hasMatch(value.replaceAll(' ', ''))) {
      return 'رقم الهاتف غير صالح';
    }
    return null;
  }

  /// التحقق من الحد الأدنى لعدد الأحرف
  static String? Function(String?) minLength(int min) {
    return (String? value) {
      if (value == null || value.length < min) {
        return 'يجب أن يكون على الأقل $min أحرف';
      }
      return null;
    };
  }

  /// التحقق من الحد الأقصى لعدد الأحرف
  static String? Function(String?) maxLength(int max) {
    return (String? value) {
      if (value != null && value.length > max) {
        return 'يجب أن لا يتجاوز $max أحرف';
      }
      return null;
    };
  }

  /// دمج عدة validators في سلسلة (Compose)
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }

  /// التحقق من أن القيمة رقم موجب
  static String? positiveNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'القيمة مطلوبة';
    final number = double.tryParse(value);
    if (number == null) return 'يجب أن تكون قيمة رقمية';
    if (number <= 0) return 'يجب أن تكون قيمة موجبة';
    return null;
  }

  /// التحقق من URL
  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(
      r'^(https?|ftp)://[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
    );
    if (!regex.hasMatch(value.trim())) return 'الرابط غير صالح';
    return null;
  }
}
