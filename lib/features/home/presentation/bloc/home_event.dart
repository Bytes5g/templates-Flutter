import 'package:equatable/equatable.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/item.dart';

/// أحداث BLoC الرئيسية
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// تهيئة الصفحة الرئيسية
class HomeInitialized extends HomeEvent {
  const HomeInitialized();
}

/// طلب تحميل التصنيفات
class CategoriesLoadRequested extends HomeEvent {
  final String? parentId;
  final bool forceRefresh;

  const CategoriesLoadRequested({
    this.parentId,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [parentId, forceRefresh];
}

/// اختيار تصنيف
class CategorySelected extends HomeEvent {
  final Category category;

  const CategorySelected(this.category);

  @override
  List<Object?> get props => [category];
}

/// طلب تحميل العناصر
class ItemsLoadRequested extends HomeEvent {
  final String categoryId;
  final bool forceRefresh;
  final bool loadMore;

  const ItemsLoadRequested({
    required this.categoryId,
    this.forceRefresh = false,
    this.loadMore = false,
  });

  @override
  List<Object?> get props => [categoryId, forceRefresh, loadMore];
}

/// طلب البحث
class SearchRequested extends HomeEvent {
  final String query;
  final String? categoryId;

  const SearchRequested({required this.query, this.categoryId});

  @override
  List<Object?> get props => [query, categoryId];
}

/// إعادة المحاولة عند الخطأ
class HomeRetried extends HomeEvent {
  const HomeRetried();
}
