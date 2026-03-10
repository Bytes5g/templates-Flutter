/// القوالب - AppScaffold: الهيكل الأساسي للصفحات
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';
import '../molecules/offline_banner.dart';

/// قالب الهيكل الأساسي لجميع الصفحات
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.showOfflineBanner = true,
    this.padding,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool showOfflineBanner;
  final EdgeInsetsGeometry? padding;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          (title != null
              ? AppBar(
                  title: Text(title!),
                  actions: actions,
                )
              : null),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Column(
        children: [
          // شريط الإشعار عند انقطاع الاتصال
          if (showOfflineBanner) const OfflineBanner(),
          // المحتوى الرئيسي
          Expanded(
            child: padding != null
                ? Padding(padding: padding!, child: body)
                : body,
          ),
        ],
      ),
    );
  }
}
