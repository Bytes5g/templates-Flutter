import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('required', () {
      test('يُرجع خطأ للقيمة الفارغة', () {
        expect(Validators.required(''), isNotNull);
        expect(Validators.required(null), isNotNull);
        expect(Validators.required('   '), isNotNull);
      });

      test('يُرجع null للقيمة الصالحة', () {
        expect(Validators.required('قيمة'), isNull);
      });
    });

    group('email', () {
      test('يُرجع خطأ للبريد غير الصالح', () {
        expect(Validators.email('invalid'), isNotNull);
        expect(Validators.email('invalid@'), isNotNull);
        expect(Validators.email('@domain.com'), isNotNull);
      });

      test('يُرجع null للبريد الصالح', () {
        expect(Validators.email('test@example.com'), isNull);
        expect(Validators.email('user.name+tag@domain.co'), isNull);
      });
    });

    group('phone', () {
      test('يُرجع خطأ للهاتف غير الصالح', () {
        expect(Validators.phone('123'), isNotNull);
        expect(Validators.phone('abc'), isNotNull);
      });

      test('يُرجع null للهاتف الصالح', () {
        expect(Validators.phone('+966501234567'), isNull);
        expect(Validators.phone('0501234567'), isNull);
      });
    });

    group('minLength', () {
      test('يُرجع خطأ إذا كان النص أقصر من الحد', () {
        final validator = Validators.minLength(5);
        expect(validator('abc'), isNotNull);
      });

      test('يُرجع null إذا كان النص بالطول المطلوب', () {
        final validator = Validators.minLength(3);
        expect(validator('abc'), isNull);
        expect(validator('abcdef'), isNull);
      });
    });

    group('compose', () {
      test('يُطبّق validators بالترتيب ويُرجع أول خطأ', () {
        final validator = Validators.compose([
          Validators.required,
          Validators.email,
        ]);
        expect(validator(''), isNotNull); // required يفشل أولاً
        expect(validator('invalid'), isNotNull); // email يفشل
        expect(validator('test@example.com'), isNull);
      });
    });

    group('url', () {
      test('يُرجع null للـ URL الصالح', () {
        expect(Validators.url('https://example.com'), isNull);
        expect(Validators.url('http://test.org/path?q=1'), isNull);
      });

      test('يُرجع خطأ للـ URL غير الصالح', () {
        expect(Validators.url('not-a-url'), isNotNull);
        expect(Validators.url('ftp://'), isNotNull);
      });

      test('يُرجع null للقيمة الفارغة (اختياري)', () {
        expect(Validators.url(''), isNull);
        expect(Validators.url(null), isNull);
      });
    });
  });
}
