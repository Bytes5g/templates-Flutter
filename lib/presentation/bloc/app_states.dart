/// حالات BLoC العامة - نمط موحد للحالات
library;

import 'package:equatable/equatable.dart';
import '../../core/errors/failures.dart';

/// حالة BLoC الأساسية
sealed class AppState<T> extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

/// حالة أولية
final class InitialState<T> extends AppState<T> {
  const InitialState();
}

/// حالة التحميل
final class LoadingState<T> extends AppState<T> {
  const LoadingState({this.previousData});

  /// البيانات السابقة (للتحميل التدريجي)
  final T? previousData;

  @override
  List<Object?> get props => [previousData];
}

/// حالة النجاح
final class SuccessState<T> extends AppState<T> {
  const SuccessState(this.data, {this.isStale = false});

  final T data;
  final bool isStale; // بيانات قديمة من الكاش

  @override
  List<Object?> get props => [data, isStale];
}

/// حالة الفشل
final class FailureState<T> extends AppState<T> {
  const FailureState(this.failure, {this.cachedData});

  final AppFailure failure;
  final T? cachedData; // بيانات مخزنة قديمة عند الفشل

  @override
  List<Object?> get props => [failure, cachedData];
}

/// حالة التحميل التدريجي (Pagination)
final class LoadingMoreState<T> extends AppState<T> {
  const LoadingMoreState(this.currentData);

  final T currentData;

  @override
  List<Object?> get props => [currentData];
}
