import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/core/utils/either.dart';
import 'package:flutter_template/core/errors/failures.dart';

void main() {
  group('Either', () {
    test('Left يُمثّل الفشل', () {
      final result = left<String>(const NetworkFailure());
      expect(result.isLeft, isTrue);
      expect(result.isRight, isFalse);
      expect(result.left, isA<NetworkFailure>());
    });

    test('Right يُمثّل النجاح', () {
      final result = right<String>('بيانات');
      expect(result.isRight, isTrue);
      expect(result.isLeft, isFalse);
      expect(result.right, equals('بيانات'));
    });

    test('fold يُطبّق الدالة الصحيحة', () {
      final success = right<int>(42);
      final value = success.fold(
        (_) => -1,
        (v) => v * 2,
      );
      expect(value, equals(84));

      final failure = left<int>(const ServerFailure());
      final errorValue = failure.fold(
        (f) => -1,
        (v) => v,
      );
      expect(errorValue, equals(-1));
    });

    test('map يُحوّل Right فقط', () {
      final success = right<int>(5);
      final mapped = success.map((v) => v * 3);
      expect(mapped.right, equals(15));

      final failure = left<int>(const NetworkFailure());
      final mappedFailure = failure.map((v) => v * 3);
      expect(mappedFailure.isLeft, isTrue);
    });
  });

  group('AppFailure', () {
    test('NetworkFailure لها رسالة افتراضية', () {
      const failure = NetworkFailure();
      expect(failure.message, isNotEmpty);
    });

    test('ValidationFailure تحتوي على رسالة مخصصة', () {
      const failure = ValidationFailure(message: 'البريد الإلكتروني مطلوب');
      expect(failure.message, equals('البريد الإلكتروني مطلوب'));
    });

    test('AppFailure تتساوى بحسب القيم', () {
      const f1 = NetworkFailure();
      const f2 = NetworkFailure();
      expect(f1, equals(f2));
    });
  });
}
