import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../widgets/atoms/app_loading_indicator.dart';
import '../../../../widgets/atoms/app_text.dart';
import '../../../../widgets/molecules/app_error_widget.dart';
import '../../../../widgets/organisms/app_nav_bars.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/category_list_widget.dart';
import '../widgets/item_grid_widget.dart';

/// الصفحة الرئيسية
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeInitialized()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'الرئيسية',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(RouteNames.settings),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() || HomeLoading() => const AppLoadingIndicator(
                message: 'جارٍ التحميل...',
              ),
            HomeError() => AppErrorWidget(
                title: 'حدث خطأ',
                message: state.message,
                icon: state.isNetworkError
                    ? Icons.wifi_off_rounded
                    : Icons.error_outline_rounded,
                onRetry: () =>
                    context.read<HomeBloc>().add(const HomeRetried()),
              ),
            HomeLoaded() => _HomeContent(state: state),
            HomeSearching() => const AppLoadingIndicator(
                message: 'جارٍ البحث...',
              ),
            HomeSearchResult() => _SearchResults(state: state),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final HomeLoaded state;
  const _HomeContent({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // إشعار البيانات المخزنة مؤقتاً
        if (state.isFromCache)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.xs,
            ),
            color: AppColors.warning.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.warning,
                ),
                const SizedBox(width: AppSizes.xs),
                AppText(
                  'يتم عرض بيانات مخزنة مسبقاً',
                  variant: AppTextVariant.caption,
                  color: AppColors.warning,
                ),
              ],
            ),
          ),

        // قائمة التصنيفات الأفقية
        if (state.categories.isNotEmpty)
          CategoryListWidget(
            categories: state.categories,
            selectedCategory: state.selectedCategory,
            onCategoryTap: (cat) => context.read<HomeBloc>().add(
                  CategorySelected(cat),
                ),
          ),

        // قائمة العناصر
        Expanded(
          child: state.selectedCategory == null
              ? _EmptySelectionPrompt()
              : ItemGridWidget(
                  items: state.items,
                  isLoadingMore: state.isLoadingMore,
                  crossAxisCount:
                      ResponsiveUtils.gridCrossAxisCount(context),
                ),
        ),
      ],
    );
  }
}

class _EmptySelectionPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.touch_app_rounded,
            size: AppSizes.iconXl * 1.5,
            color: AppColors.grey300,
          ),
          const SizedBox(height: AppSizes.md),
          AppText(
            'اختر تصنيفاً لعرض المحتوى',
            variant: AppTextVariant.bodyLarge,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final HomeSearchResult state;
  const _SearchResults({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.results.isEmpty) {
      return Center(
        child: AppText(
          'لا توجد نتائج لـ "${state.query}"',
          variant: AppTextVariant.bodyLarge,
          color: AppColors.textSecondary,
        ),
      );
    }
    return ItemGridWidget(
      items: state.results,
      crossAxisCount: ResponsiveUtils.gridCrossAxisCount(context),
    );
  }
}
