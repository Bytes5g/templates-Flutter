import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/category_model.dart';
import '../models/item_model.dart';

/// واجهة مصدر البيانات البعيد
abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories({String? parentId});
  Future<List<ItemModel>> getItems({
    required String categoryId,
    int page = 1,
    int pageSize = 20,
  });
  Future<ItemModel> getItemById(String id);
  Future<List<ItemModel>> searchItems({
    required String query,
    String? categoryId,
  });
}

/// تطبيق مصدر البيانات البعيد
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<CategoryModel>> getCategories({String? parentId}) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        '/categories',
        queryParameters: {
          if (parentId != null) 'parent_id': parentId,
        },
      );
      final data = response.data?['data'] as List<dynamic>? ?? [];
      return data
          .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'فشل جلب التصنيفات: $e');
    }
  }

  @override
  Future<List<ItemModel>> getItems({
    required String categoryId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        '/items',
        queryParameters: {
          'category_id': categoryId,
          'page': page,
          'page_size': pageSize,
        },
      );
      final data = response.data?['data'] as List<dynamic>? ?? [];
      return data
          .map((json) => ItemModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'فشل جلب العناصر: $e');
    }
  }

  @override
  Future<ItemModel> getItemById(String id) async {
    try {
      final response =
          await _dioClient.get<Map<String, dynamic>>('/items/$id');
      final data = response.data?['data'] as Map<String, dynamic>?;
      if (data == null) throw NotFoundException();
      return ItemModel.fromJson(data);
    } on NotFoundException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'فشل جلب العنصر: $e');
    }
  }

  @override
  Future<List<ItemModel>> searchItems({
    required String query,
    String? categoryId,
  }) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        '/items/search',
        queryParameters: {
          'q': query,
          if (categoryId != null) 'category_id': categoryId,
        },
      );
      final data = response.data?['data'] as List<dynamic>? ?? [];
      return data
          .map((json) => ItemModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(message: 'فشل البحث: $e');
    }
  }
}
