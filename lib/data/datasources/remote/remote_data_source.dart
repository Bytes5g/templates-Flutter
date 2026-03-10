/// مصدر البيانات البعيد - يتصل بـ API
library;

import 'package:dio/dio.dart';
import '../../core/errors/exceptions.dart';
import '../../core/utils/app_logger.dart';
import '../models/category_model.dart';
import '../models/content_model.dart';

/// مصدر البيانات من الخادم
class RemoteDataSource {
  const RemoteDataSource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  // ─── تصنيفات ───

  Future<List<CategoryModel>> getRootCategories() async {
    return _request<List<CategoryModel>>(
      '/categories',
      queryParameters: {'parent_id': 'null'},
      parser: (data) => (data as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    return _request<List<CategoryModel>>(
      '/categories',
      queryParameters: {'parent_id': parentId},
      parser: (data) => (data as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<CategoryModel> getCategoryById(String id) async {
    return _request<CategoryModel>(
      '/categories/$id',
      parser: (data) =>
          CategoryModel.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<List<CategoryModel>> getCategoryTree() async {
    return _request<List<CategoryModel>>(
      '/categories/tree',
      parser: (data) => (data as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<PaginatedResponseModel<CategoryModel>> searchCategories(
    Map<String, dynamic> queryParams,
  ) async {
    return _request<PaginatedResponseModel<CategoryModel>>(
      '/categories/search',
      queryParameters: queryParams,
      parser: (data) => PaginatedResponseModel.fromJson(
        data as Map<String, dynamic>,
        (e) => CategoryModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  // ─── محتوى ───

  Future<PaginatedResponseModel<ContentModel>> getContents(
    Map<String, dynamic> queryParams,
  ) async {
    return _request<PaginatedResponseModel<ContentModel>>(
      '/contents',
      queryParameters: queryParams,
      parser: (data) => PaginatedResponseModel.fromJson(
        data as Map<String, dynamic>,
        (e) => ContentModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  Future<ContentModel> getContentById(String id) async {
    return _request<ContentModel>(
      '/contents/$id',
      parser: (data) => ContentModel.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<ContentModel> getContentBySlug(String slug) async {
    return _request<ContentModel>(
      '/contents/by-slug/$slug',
      parser: (data) => ContentModel.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<List<ContentModel>> getFeaturedContents({int limit = 10}) async {
    return _request<List<ContentModel>>(
      '/contents/featured',
      queryParameters: {'limit': limit},
      parser: (data) => (data as List)
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<PaginatedResponseModel<ContentModel>> getContentsByCategory(
    String categoryId,
    Map<String, dynamic> queryParams,
  ) async {
    return _request<PaginatedResponseModel<ContentModel>>(
      '/categories/$categoryId/contents',
      queryParameters: queryParams,
      parser: (data) => PaginatedResponseModel.fromJson(
        data as Map<String, dynamic>,
        (e) => ContentModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  Future<PaginatedResponseModel<ContentModel>> searchContents(
    String query,
    Map<String, dynamic> queryParams,
  ) async {
    return _request<PaginatedResponseModel<ContentModel>>(
      '/contents/search',
      queryParameters: {'q': query, ...queryParams},
      parser: (data) => PaginatedResponseModel.fromJson(
        data as Map<String, dynamic>,
        (e) => ContentModel.fromJson(e as Map<String, dynamic>),
      ),
    );
  }

  /// طريقة عامة للطلبات - DRY
  Future<T> _request<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      final data = response.data?['data'] ?? response.data;
      return parser(data);
    } on DioException catch (e) {
      AppLogger.error('[RemoteDataSource] خطأ في $path', e);
      rethrow;
    } catch (e) {
      AppLogger.error('[RemoteDataSource] خطأ في تحليل $path', e);
      throw AppException(message: 'خطأ في معالجة البيانات: $e');
    }
  }
}
