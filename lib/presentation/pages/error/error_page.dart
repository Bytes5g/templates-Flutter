/// صفحة الخطأ العام
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../core/errors/failures.dart';
import '../../widgets/molecules/error_view.dart';
import '../../widgets/templates/app_scaffold.dart';

/// صفحة الخطأ العام
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.errorMessage, this.failure});

  final String? errorMessage;
  final AppFailure? failure;

  @override
  Widget build(BuildContext context) {
    final resolvedFailure = failure ??
        UnexpectedFailure(message: errorMessage ?? 'حدث خطأ غير متوقع.');

    return AppScaffold(
      showOfflineBanner: false,
      body: ErrorView(
        failure: resolvedFailure,
        onGoHome: () => context.go(AppRoutes.home),
      ),
    );
  }
}
