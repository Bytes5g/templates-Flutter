import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../widgets/atoms/app_text.dart';

/// صفحة البداية - تُظهر شعار التطبيق ثم تنتقل للرئيسية
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() {
    Future.delayed(AppDurations.splash, () {
      if (mounted) {
        context.go(RouteNames.home);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // شعار التطبيق
                Container(
                  width: AppSizes.xxxl * 2,
                  height: AppSizes.xxxl * 2,
                  decoration: BoxDecoration(
                    color: AppColors.textOnPrimary.withOpacity(0.15),
                    borderRadius:
                        BorderRadius.circular(AppSizes.radiusXl),
                  ),
                  child: const Icon(
                    Icons.flutter_dash_rounded,
                    size: AppSizes.iconXl * 2,
                    color: AppColors.textOnPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.xl),
                // اسم التطبيق
                const AppText(
                  'تطبيقي',
                  variant: AppTextVariant.hero,
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: AppSizes.sm),
                // الشعار
                AppText(
                  'قالب Flutter الاحترافي',
                  variant: AppTextVariant.titleMedium,
                  color: AppColors.textOnPrimary.withOpacity(0.8),
                ),
                const SizedBox(height: AppSizes.xxl),
                // مؤشر التحميل
                SizedBox(
                  width: AppSizes.iconXl,
                  height: AppSizes.iconXl,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.textOnPrimary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
