/// الجزيئات - ErrorView: عرض الأخطاء مع اقتراحات ذكية
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../core/errors/failures.dart';
import '../atoms/app_button.dart';
import '../atoms/app_text.dart';

/// جزيء عرض الخطأ
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.failure,
    this.onRetry,
    this.onGoHome,
    this.showSuggestions = true,
  });

  final AppFailure failure;
  final VoidCallback? onRetry;
  final VoidCallback? onGoHome;
  final bool showSuggestions;

  @override
  Widget build(BuildContext context) {
    final config = _getErrorConfig(failure);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة الخطأ
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: config.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                config.icon,
                size: AppDimensions.iconXl,
                color: config.color,
              ),
            ),

            const SizedBox(height: AppDimensions.spaceLg),

            // عنوان الخطأ
            AppText(
              config.title,
              variant: AppTextVariant.headlineMedium,
              align: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: AppDimensions.spaceSm),

            // رسالة الخطأ
            AppText(
              failure.message,
              variant: AppTextVariant.bodyMedium,
              align: TextAlign.center,
              color: Theme.of(context).colorScheme.outline,
            ),

            // اقتراحات ذكية
            if (showSuggestions && config.suggestions.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.spaceMd),
              ...config.suggestions.map((suggestion) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spaceXs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: AppDimensions.iconXs,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(width: AppDimensions.spaceXs),
                    AppText(
                      suggestion,
                      variant: AppTextVariant.bodySmall,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ],
                ),
              )),
            ],

            const SizedBox(height: AppDimensions.spaceXl),

            // أزرار الإجراءات
            if (onRetry != null)
              AppButton(
                label: 'إعادة المحاولة',
                onPressed: onRetry,
                icon: Icons.refresh,
              ),

            if (onGoHome != null) ...[
              const SizedBox(height: AppDimensions.spaceSm),
              AppButton(
                label: 'العودة للرئيسية',
                onPressed: onGoHome,
                variant: AppButtonVariant.outlined,
              ),
            ],
          ],
        ),
      ),
    );
  }

  _ErrorConfig _getErrorConfig(AppFailure failure) {
    return switch (failure) {
      OfflineFailure() => _ErrorConfig(
        title: 'لا يوجد اتصال',
        icon: Icons.wifi_off_rounded,
        color: const Color(0xFFF39C12),
        suggestions: [
          'تحقق من اتصالك بالإنترنت',
          'يتم عرض البيانات المحفوظة',
          'سيتم التحديث تلقائياً عند عودة الاتصال',
        ],
      ),
      NetworkFailure() => _ErrorConfig(
        title: 'خطأ في الاتصال',
        icon: Icons.cloud_off_rounded,
        color: const Color(0xFFE74C3C),
        suggestions: ['تحقق من اتصالك بالإنترنت', 'حاول مرة أخرى'],
      ),
      NotFoundFailure() => _ErrorConfig(
        title: 'غير موجود',
        icon: Icons.search_off_rounded,
        color: const Color(0xFF95A5A6),
        suggestions: ['ربما تم نقل هذا المحتوى', 'جرّب البحث عنه'],
      ),
      AuthFailure() => _ErrorConfig(
        title: 'انتهت الجلسة',
        icon: Icons.lock_outline_rounded,
        color: const Color(0xFF3498DB),
        suggestions: ['يرجى تسجيل الدخول مجدداً'],
      ),
      ServerFailure() => _ErrorConfig(
        title: 'خطأ في الخادم',
        icon: Icons.dns_outlined,
        color: const Color(0xFFE74C3C),
        suggestions: ['المشكلة من جانبنا', 'حاول مرة أخرى لاحقاً'],
      ),
      _ => _ErrorConfig(
        title: 'حدث خطأ',
        icon: Icons.error_outline_rounded,
        color: const Color(0xFFE74C3C),
        suggestions: ['حاول مرة أخرى'],
      ),
    };
  }
}

class _ErrorConfig {
  const _ErrorConfig({
    required this.title,
    required this.icon,
    required this.color,
    this.suggestions = const [],
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<String> suggestions;
}
