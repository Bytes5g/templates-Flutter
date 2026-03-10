/// الصفحة الرئيسية
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../core/utils/screen_helper.dart';
import '../../../domain/entities/category_entity.dart';
import '../../bloc/category_bloc.dart';
import '../../widgets/atoms/app_loading_indicator.dart';
import '../../widgets/molecules/error_view.dart';
import '../../widgets/organisms/category_tree_view.dart';
import '../../widgets/templates/app_scaffold.dart';
import '../../bloc/app_states.dart';

/// الصفحة الرئيسية
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.categoryId,
    this.contentId,
    this.searchQuery,
  });

  final String? categoryId;
  final String? contentId;
  final String? searchQuery;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.categoryId;
    context.read<CategoryBloc>().add(const LoadCategoryTreeEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = ScreenHelper.isTablet(context) ||
        ScreenHelper.isDesktop(context);

    return AppScaffold(
      title: 'الرئيسية',
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return switch (state) {
            InitialState<List<CategoryEntity>>() ||
            LoadingState<List<CategoryEntity>>() => const AppLoadingPage(),
            SuccessState<List<CategoryEntity>>(:final data) =>
              _buildContent(context, data, isTablet),
            FailureState<List<CategoryEntity>>(:final failure) =>
              ErrorView(
                failure: failure,
                onRetry: () => context
                    .read<CategoryBloc>()
                    .add(const LoadCategoryTreeEvent()),
              ),
            _ => const AppLoadingPage(),
          };
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<CategoryEntity> categories,
    bool isTablet,
  ) {
    if (isTablet) {
      return Row(
        children: [
          SizedBox(
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceMd),
                  child: Text(
                    'التصنيفات',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Expanded(
                  child: CategoryTreeView(
                    categories: categories,
                    selectedCategoryId: _selectedCategoryId,
                    onCategoryTap: (cat) {
                      setState(() => _selectedCategoryId = cat.id);
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: _buildMainContent(context),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // شريط التصنيفات الأفقي للموبايل
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceMd,
            ),
            itemCount: categories.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(left: AppDimensions.spaceSm),
              child: FilterChip(
                label: Text(categories[i].name),
                selected: _selectedCategoryId == categories[i].id,
                onSelected: (_) {
                  setState(() => _selectedCategoryId = categories[i].id);
                },
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        Expanded(child: _buildMainContent(context)),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Center(
      child: Text(
        _selectedCategoryId != null
            ? 'عرض تصنيف: $_selectedCategoryId'
            : 'اختر تصنيفاً',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
