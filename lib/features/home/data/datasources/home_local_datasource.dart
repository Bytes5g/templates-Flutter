import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/category_model.dart';
import '../models/item_model.dart';

/// واجهة مصدر البيانات المحلي
abstract class HomeLocalDataSource {
  Future<void> cacheCategories(List<CategoryModel> categories);
  List<CategoryModel>? getCachedCategories();
  bool isCategoriesCacheExpired();

  Future<void> cacheItems(String categoryId, List<ItemModel> items);
  List<ItemModel>? getCachedItems(String categoryId);
  bool isItemsCacheExpired(String categoryId);
}

/// تطبيق مصدر البيانات المحلي - Offline First
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final LocalStorage _localStorage;

  HomeLocalDataSourceImpl(this._localStorage);

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    try {
      await _localStorage.saveJsonList(
        AppStorageKeys.categoriesCache,
        categories.map((c) => c.toJson()).toList(),
      );
    } catch (e) {
      throw CacheException(message: 'فشل تخزين التصنيفات: $e');
    }
  }

  @override
  List<CategoryModel>? getCachedCategories() {
    final cached = _localStorage.getJsonList(AppStorageKeys.categoriesCache);
    if (cached == null) return null;
    return cached.map(CategoryModel.fromJson).toList();
  }

  @override
  bool isCategoriesCacheExpired() =>
      _localStorage.isCacheExpired(AppStorageKeys.categoriesCache);

  @override
  Future<void> cacheItems(String categoryId, List<ItemModel> items) async {
    try {
      final key = '${AppStorageKeys.itemsCache}_$categoryId';
      await _localStorage.saveJsonList(
        key,
        items.map((item) => item.toJson()).toList(),
      );
    } catch (e) {
      throw CacheException(message: 'فشل تخزين العناصر: $e');
    }
  }

  @override
  List<ItemModel>? getCachedItems(String categoryId) {
    final key = '${AppStorageKeys.itemsCache}_$categoryId';
    final cached = _localStorage.getJsonList(key);
    if (cached == null) return null;
    return cached.map(ItemModel.fromJson).toList();
  }

  @override
  bool isItemsCacheExpired(String categoryId) {
    final key = '${AppStorageKeys.itemsCache}_$categoryId';
    return _localStorage.isCacheExpired(key);
  }
}
