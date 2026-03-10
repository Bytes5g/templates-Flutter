import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('email', () {
      test('يقبل البريد الإلكتروني الصحيح', () {
        expect(Validators.email('test@example.com'), isNull);
        expect(Validators.email('user.name+tag@sub.domain.org'), isNull);
      });

      test('يرفض البريد الإلكتروني الفارغ', () {
        expect(Validators.email(''), isNotNull);
        expect(Validators.email(null), isNotNull);
      });

      test('يرفض البريد الإلكتروني غير الصحيح', () {
        expect(Validators.email('invalid'), isNotNull);
        expect(Validators.email('no@dots'), isNotNull);
        expect(Validators.email('@domain.com'), isNotNull);
      });
    });

    group('password', () {
      test('يقبل كلمة المرور الصحيحة', () {
        expect(Validators.password('Password1'), isNull);
        expect(Validators.password('MyP@ssword123'), isNull);
      });

      test('يرفض كلمة المرور القصيرة', () {
        expect(Validators.password('Pass1'), isNotNull);
      });

      test('يرفض كلمة المرور بدون أحرف كبيرة', () {
        expect(Validators.password('password1'), isNotNull);
      });

      test('يرفض كلمة المرور بدون أرقام', () {
        expect(Validators.password('PasswordOnly'), isNotNull);
      });

      test('يرفض كلمة المرور الفارغة', () {
        expect(Validators.password(''), isNotNull);
        expect(Validators.password(null), isNotNull);
      });
    });

    group('required', () {
      test('يقبل القيم غير الفارغة', () {
        expect(Validators.required('نص'), isNull);
        expect(Validators.required('0'), isNull);
      });

      test('يرفض القيم الفارغة', () {
        expect(Validators.required(''), isNotNull);
        expect(Validators.required('   '), isNotNull);
        expect(Validators.required(null), isNotNull);
      });

      test('يستخدم اسم الحقل المخصص في الرسالة', () {
        final error = Validators.required('', fieldName: 'البريد الإلكتروني');
        expect(error, contains('البريد الإلكتروني'));
      });
    });

    group('compose', () {
      test('يُطبّق جميع validators بالترتيب', () {
        final validator = Validators.compose([
          Validators.required,
          (v) => v!.length < 3 ? 'قصير جداً' : null,
        ]);

        expect(validator(null), isNotNull);
        expect(validator(''), isNotNull);
        expect(validator('ab'), equals('قصير جداً'));
        expect(validator('abc'), isNull);
      });
    });
  });
}
