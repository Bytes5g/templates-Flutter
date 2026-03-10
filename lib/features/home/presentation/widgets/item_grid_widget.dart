import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/route_names.dart';
import '../../../../widgets/atoms/app_loading_indicator.dart';
import '../../../../widgets/molecules/app_card.dart';
import '../../../../widgets/molecules/app_error_widget.dart';
import '../../domain/entities/item.dart';

/// شبكة عرض العناصر مع التحميل الكسول
class ItemGridWidget extends StatelessWidget {
  final List<Item> items;
  final bool isLoadingMore;
  final int crossAxisCount;
  final VoidCallback? onLoadMore;

  const ItemGridWidget({
    super.key,
    required this.items,
    this.isLoadingMore = false,
    this.crossAxisCount = 2,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && !isLoadingMore) {
      return const AppEmptyWidget(
        title: 'لا توجد عناصر',
        message: 'لا توجد عناصر في هذا التصنيف حالياً',
        icon: Icons.inbox_rounded,
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 200 &&
            onLoadMore != null) {
          onLoadMore!();
        }
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(AppSizes.md),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSizes.sm,
          mainAxisSpacing: AppSizes.sm,
          childAspectRatio: 0.75,
        ),
        itemCount: items.length + (isLoadingMore ? 2 : 0),
        itemBuilder: (context, index) {
          // عناصر التحميل المزيفة (Shimmer)
          if (index >= items.length) {
            return const _LoadingItemPlaceholder();
          }
          final item = items[index];
          return AppCard(
            title: item.title,
            subtitle: item.description,
            imageUrl: item.imageUrl,
            onTap: () => context.push(
              RouteBuilders.itemDetail(item.id),
            ),
          );
        },
      ),
    );
  }
}

class _LoadingItemPlaceholder extends StatefulWidget {
  const _LoadingItemPlaceholder();

  @override
  State<_LoadingItemPlaceholder> createState() =>
      _LoadingItemPlaceholderState();
}

class _LoadingItemPlaceholderState extends State<_LoadingItemPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          ),
        ),
      ),
    );
  }
}
