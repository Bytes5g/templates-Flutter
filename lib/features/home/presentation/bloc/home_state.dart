import 'package:equatable/equatable.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/item.dart';

/// حالات BLoC الرئيسية
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// جارٍ التحميل
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// تم التحميل بنجاح
class HomeLoaded extends HomeState {
  final List<Category> categories;
  final Category? selectedCategory;
  final List<Item> items;
  final bool isLoadingMore;
  final bool hasMoreItems;
  final bool isFromCache;

  const HomeLoaded({
    required this.categories,
    this.selectedCategory,
    this.items = const [],
    this.isLoadingMore = false,
    this.hasMoreItems = true,
    this.isFromCache = false,
  });

  HomeLoaded copyWith({
    List<Category>? categories,
    Category? selectedCategory,
    List<Item>? items,
    bool? isLoadingMore,
    bool? hasMoreItems,
    bool? isFromCache,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      items: items ?? this.items,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreItems: hasMoreItems ?? this.hasMoreItems,
      isFromCache: isFromCache ?? this.isFromCache,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        selectedCategory,
        items,
        isLoadingMore,
        hasMoreItems,
        isFromCache,
      ];
}

/// حالة الخطأ
class HomeError extends HomeState {
  final String message;
  final bool isNetworkError;

  const HomeError({
    required this.message,
    this.isNetworkError = false,
  });

  @override
  List<Object?> get props => [message, isNetworkError];
}

/// حالة البحث
class HomeSearching extends HomeState {
  const HomeSearching();
}

/// نتائج البحث
class HomeSearchResult extends HomeState {
  final List<Item> results;
  final String query;

  const HomeSearchResult({required this.results, required this.query});

  @override
  List<Object?> get props => [results, query];
}
