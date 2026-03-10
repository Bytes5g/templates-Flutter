/// نوع النتيجة - Either pattern بدون مكتبات خارجية
/// يُمثّل نتيجة العملية: إما فشل (Left) أو نجاح (Right)
library;

import '../errors/failures.dart';

/// يُمثّل قيمة من نوع واحد فقط: Left أو Right
sealed class Either<L, R> {
  const Either();
}

/// يُمثّل الفشل
final class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;
}

/// يُمثّل النجاح
final class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;
}

/// نوع مختصر للنتائج المعتادة
typedef AppResult<T> = Either<AppFailure, T>;

/// دوال مساعدة
extension EitherExtensions<L, R> on Either<L, R> {
  bool get isLeft  => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  L get left  => (this as Left<L, R>).value;
  R get right => (this as Right<L, R>).value;

  /// تحويل القيمة في Right
  Either<L, T> map<T>(T Function(R value) transform) =>
      switch (this) {
        Left(:final value)  => Left(value),
        Right(:final value) => Right(transform(value)),
      };

  /// تطبيق دالة على Right أو Left
  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) =>
      switch (this) {
        Left(:final value)  => onLeft(value),
        Right(:final value) => onRight(value),
      };
}

/// إنشاء Left بشكل مختصر
AppResult<T> left<T>(AppFailure failure) => Left(failure);

/// إنشاء Right بشكل مختصر
AppResult<T> right<T>(T value) => Right(value);
