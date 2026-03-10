/// نموذج نتائج مُقسَّمة للصفحات
library;

import 'package:equatable/equatable.dart';

/// نتيجة مُقسَّمة للصفحات
class PaginatedResult<T> extends Equatable {
  const PaginatedResult({
    required this.items,
    required this.total,
    required this.page,
    required this.perPage,
    this.nextPage,
    this.previousPage,
  });

  final List<T> items;
  final int total;
  final int page;
  final int perPage;
  final int? nextPage;
  final int? previousPage;

  bool get hasNextPage => nextPage != null;
  bool get hasPreviousPage => previousPage != null;
  int get totalPages => (total / perPage).ceil();

  PaginatedResult<T> copyWith({
    List<T>? items,
    int? total,
    int? page,
    int? perPage,
    int? nextPage,
    int? previousPage,
  }) =>
      PaginatedResult<T>(
        items: items ?? this.items,
        total: total ?? this.total,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        nextPage: nextPage ?? this.nextPage,
        previousPage: previousPage ?? this.previousPage,
      );

  @override
  List<Object?> get props => [items, total, page, perPage, nextPage, previousPage];
}

/// معاملات التصفح والفرز
class PaginationParams extends Equatable {
  const PaginationParams({
    this.page = 1,
    this.perPage = 20,
    this.search,
    this.sortBy,
    this.sortOrder,
    this.filters,
  });

  final int page;
  final int perPage;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  final Map<String, dynamic>? filters;

  Map<String, dynamic> toQueryParams() => {
    'page': page,
    'per_page': perPage,
    if (search != null) 'search': search,
    if (sortBy != null) 'sort_by': sortBy,
    if (sortOrder != null) 'sort_order': sortOrder,
    ...?filters,
  };

  @override
  List<Object?> get props => [page, perPage, search, sortBy, sortOrder, filters];
}
