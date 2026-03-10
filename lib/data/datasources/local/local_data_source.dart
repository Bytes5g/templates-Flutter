/// مصدر البيانات المحلي - يخزن ويسترجع من Hive
library;

import '../../../core/storage/cache_service.dart';
import '../../models/category_model.dart';
import '../../models/content_model.dart';

/// مفاتيح الكاش المحلي
class _CacheKeys {
  static const String categoryTree = 'category_tree';
  static const String rootCategories = 'root_categories';
  static String subCategories(String id) => 'sub_categories_$id';
  static String categoryById(String id) => 'category_$id';
  static String contentById(String id) => 'content_$id';
  static String contentBySlug(String slug) => 'content_slug_$slug';
  static const String featuredContents = 'featured_contents';
  static String contentsByCategory(String id, int page) =>
      'contents_cat_${id}_p$page';
}

/// مصدر البيانات المحلي
class LocalDataSource {
  const LocalDataSource();

  // ─── تصنيفات ───

  Future<void> saveCategoryTree(List<CategoryModel> data) =>
      CacheService.set(_CacheKeys.categoryTree, _serializeList(data));

  List<CategoryModel>? getCategoryTree() {
    final raw = CacheService.get<List>(_CacheKeys.categoryTree);
    return raw?.map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  Future<void> saveRootCategories(List<CategoryModel> data) =>
      CacheService.set(_CacheKeys.rootCategories, _serializeList(data));

  List<CategoryModel>? getRootCategories() {
    final raw = CacheService.get<List>(_CacheKeys.rootCategories);
    return raw?.map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  Future<void> saveSubCategories(String parentId, List<CategoryModel> data) =>
      CacheService.set(_CacheKeys.subCategories(parentId), _serializeList(data));

  List<CategoryModel>? getSubCategories(String parentId) {
    final raw = CacheService.get<List>(_CacheKeys.subCategories(parentId));
    return raw?.map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  Future<void> saveCategory(CategoryModel data) =>
      CacheService.set(_CacheKeys.categoryById(data.id), data.toJson());

  CategoryModel? getCategoryById(String id) {
    final raw = CacheService.get<Map>(_CacheKeys.categoryById(id));
    return raw == null ? null : CategoryModel.fromJson(Map<String, dynamic>.from(raw));
  }

  // ─── محتوى ───

  Future<void> saveContent(ContentModel data) =>
      CacheService.set(_CacheKeys.contentById(data.id), data.toJson());

  ContentModel? getContentById(String id) {
    final raw = CacheService.get<Map>(_CacheKeys.contentById(id));
    return raw == null ? null : ContentModel.fromJson(Map<String, dynamic>.from(raw));
  }

  Future<void> saveContentBySlug(ContentModel data) =>
      CacheService.set(_CacheKeys.contentBySlug(data.slug), data.toJson());

  ContentModel? getContentBySlug(String slug) {
    final raw = CacheService.get<Map>(_CacheKeys.contentBySlug(slug));
    return raw == null ? null : ContentModel.fromJson(Map<String, dynamic>.from(raw));
  }

  Future<void> saveFeaturedContents(List<ContentModel> data) =>
      CacheService.set(_CacheKeys.featuredContents, _serializeList(data));

  List<ContentModel>? getFeaturedContents() {
    final raw = CacheService.get<List>(_CacheKeys.featuredContents);
    return raw?.map((e) => ContentModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  Future<void> saveContentsByCategory(
    String categoryId,
    int page,
    List<ContentModel> data,
  ) =>
      CacheService.set(
        _CacheKeys.contentsByCategory(categoryId, page),
        _serializeList(data),
      );

  List<ContentModel>? getContentsByCategory(String categoryId, int page) {
    final raw = CacheService.get<List>(
      _CacheKeys.contentsByCategory(categoryId, page),
    );
    return raw?.map((e) => ContentModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  /// تسلسل قائمة النماذج
  List<Map<String, dynamic>> _serializeList<T>(List<T> items) {
    return items.map((item) {
      if (item is CategoryModel) return item.toJson();
      if (item is ContentModel) return item.toJson();
      throw ArgumentError('نوع غير مدعوم: ${item.runtimeType}');
    }).toList();
  }
}
