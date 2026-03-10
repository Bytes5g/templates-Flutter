/// القوالب - BlocStateBuilder: معالج موحد لحالات BLoC
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/errors/failures.dart';
import '../../bloc/app_states.dart';
import '../atoms/app_loading_indicator.dart';
import '../molecules/error_view.dart';

/// قالب بناء حالات BLoC بشكل موحد - يمنع تكرار كود switch/case
class BlocStateBuilder<B extends BlocBase<AppState<T>>, T>
    extends StatelessWidget {
  const BlocStateBuilder({
    super.key,
    required this.onSuccess,
    this.onLoading,
    this.onError,
    this.onInitial,
    this.onRetry,
    this.onGoHome,
  });

  final Widget Function(T data) onSuccess;
  final Widget Function()? onLoading;
  final Widget Function(AppFailure failure)? onError;
  final Widget Function()? onInitial;
  final VoidCallback? onRetry;
  final VoidCallback? onGoHome;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, AppState<T>>(
      builder: (context, state) {
        return switch (state) {
          InitialState<T>() => onInitial?.call() ?? const AppLoadingPage(),
          LoadingState<T>() => onLoading?.call() ?? const AppLoadingPage(),
          SuccessState<T>(:final data) => onSuccess(data),
          FailureState<T>(:final failure, :final cachedData) =>
            cachedData != null
                ? onSuccess(cachedData)
                : onError?.call(failure) ??
                    ErrorView(
                      failure: failure,
                      onRetry: onRetry,
                      onGoHome: onGoHome,
                    ),
          LoadingMoreState<T>(:final currentData) => onSuccess(currentData),
        };
      },
    );
  }
}
