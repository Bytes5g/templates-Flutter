import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/core/extensions/string_extensions.dart';

void main() {
  group('StringExtensions', () {
    group('isBlank', () {
      test('يُرجع true للنص الفارغ', () {
        expect(''.isBlank, isTrue);
        expect('   '.isBlank, isTrue);
      });

      test('يُرجع false للنص غير الفارغ', () {
        expect('نص'.isBlank, isFalse);
        expect(' a '.isBlank, isFalse);
      });
    });

    group('isValidEmail', () {
      test('يتحقق من صحة البريد', () {
        expect('test@example.com'.isValidEmail, isTrue);
        expect('invalid'.isValidEmail, isFalse);
      });
    });

    group('truncate', () {
      test('يقتطع النص الطويل', () {
        expect('مرحباً بالعالم'.truncate(5), 'مرحب...');
      });

      test('يُرجع النص كما هو إذا كان قصيراً', () {
        expect('قصير'.truncate(10), 'قصير');
      });
    });

    group('NullableStringExtensions', () {
      test('isNullOrEmpty يعمل صحيحاً', () {
        expect((null as String?).isNullOrEmpty, isTrue);
        expect(''.isNullOrEmpty, isTrue);
        expect('نص'.isNullOrEmpty, isFalse);
      });

      test('orDefault يُرجع القيمة الافتراضية عند الحاجة', () {
        expect((null as String?).orDefault('افتراضي'), 'افتراضي');
        expect(''.orDefault('افتراضي'), 'افتراضي');
        expect('قيمة'.orDefault('افتراضي'), 'قيمة');
      });
    });
  });
}
