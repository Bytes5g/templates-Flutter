/// الكائنات - ContentListView: قائمة محتوى مع تحميل تدريجي وكاش
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../domain/entities/content_entity.dart';
import '../atoms/app_loading_indicator.dart';
import '../molecules/content_card.dart';
import '../molecules/empty_view.dart';

/// كائن قائمة المحتوى
class ContentListView extends StatefulWidget {
  const ContentListView({
    super.key,
    required this.items,
    this.onTap,
    this.onLoadMore,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.emptyTitle,
    this.emptyDescription,
    this.padding,
    this.crossAxisCount,
    this.childAspectRatio,
  });

  final List<ContentEntity> items;
  final void Function(ContentEntity)? onTap;
  final VoidCallback? onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;
  final String? emptyTitle;
  final String? emptyDescription;
  final EdgeInsetsGeometry? padding;
  final int? crossAxisCount;
  final double? childAspectRatio;

  @override
  State<ContentListView> createState() => _ContentListViewState();
}

class _ContentListViewState extends State<ContentListView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll  = _scrollController.position.maxScrollExtent;
    final current    = _scrollController.offset;
    // تحميل المزيد عند الوصول لـ 80% من النهاية
    if (current >= maxScroll * 0.8 &&
        widget.hasMore &&
        !widget.isLoadingMore) {
      widget.onLoadMore?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return EmptyView(
        title: widget.emptyTitle,
        description: widget.emptyDescription,
      );
    }

    final crossAxisCount = widget.crossAxisCount ?? 1;
    final isGrid = crossAxisCount > 1;

    Widget listContent = isGrid
        ? SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppDimensions.spaceSm,
              mainAxisSpacing: AppDimensions.spaceSm,
              childAspectRatio: widget.childAspectRatio ?? 0.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, index) => ContentCard(
                content: widget.items[index],
                onTap: () => widget.onTap?.call(widget.items[index]),
              ),
              childCount: widget.items.length,
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spaceSm),
                child: ContentCard(
                  content: widget.items[index],
                  onTap: () => widget.onTap?.call(widget.items[index]),
                ),
              ),
              childCount: widget.items.length,
            ),
          );

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: widget.padding as EdgeInsets? ??
              const EdgeInsets.all(AppDimensions.spaceMd),
          sliver: listContent,
        ),
        if (widget.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.spaceMd),
              child: AppLoadingPage(),
            ),
          ),
      ],
    );
  }
}
