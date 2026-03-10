import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../widgets/atoms/app_button.dart';
import '../../../../widgets/atoms/app_text.dart';
import '../../../../widgets/organisms/app_nav_bars.dart';

/// صفحة الإعدادات
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'الإعدادات'),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          _SettingsSection(
            title: 'المظهر',
            items: [
              _SettingsItem(
                icon: Icons.dark_mode_rounded,
                title: 'الوضع الليلي',
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    // TODO: تغيير الثيم
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          _SettingsSection(
            title: 'اللغة',
            items: [
              _SettingsItem(
                icon: Icons.language_rounded,
                title: 'اللغة الحالية',
                subtitle: 'العربية',
                onTap: () {
                  // TODO: تغيير اللغة
                },
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          _SettingsSection(
            title: 'حول التطبيق',
            items: [
              _SettingsItem(
                icon: Icons.info_outline_rounded,
                title: 'الإصدار',
                subtitle: '1.0.0',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.sm,
            vertical: AppSizes.xs,
          ),
          child: AppText(
            title,
            variant: AppTextVariant.labelLarge,
            color: AppColors.textSecondary,
          ),
        ),
        Card(
          child: Column(children: items),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: AppText(title, variant: AppTextVariant.bodyLarge),
      subtitle: subtitle != null
          ? AppText(
              subtitle!,
              variant: AppTextVariant.bodySmall,
              color: AppColors.textSecondary,
            )
          : null,
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_left_rounded) : null),
      onTap: onTap,
    );
  }
}
