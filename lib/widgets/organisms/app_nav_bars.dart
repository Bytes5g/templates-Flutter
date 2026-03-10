import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../atoms/app_text.dart';

/// كائن عنصر التنقل السفلي
class AppBottomNavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;

  const AppBottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}

/// كيان شريط التنقل السفلي (Organism Widget)
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavItem> items;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: items
          .map(
            (item) => NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.activeIcon ?? item.icon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}

/// شريط العنوان المخصص (Organism Widget)
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBack;
  final Widget? bottom;
  final double height;

  const AppAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.showBack = true,
    this.bottom,
    this.height = AppSizes.appBarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? AppText(
              title!,
              variant: AppTextVariant.titleLarge,
              fontWeight: FontWeight.w600,
            )
          : null,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: showBack,
      bottom: bottom as PreferredSizeWidget?,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        bottom != null
            ? height + kTextTabBarHeight
            : height,
      );
}
