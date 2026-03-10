// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentModel _$ContentModelFromJson(Map<String, dynamic> json) => ContentModel(
      id: json['id'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      body: json['body'] as String?,
      imageUrl: json['image_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      categoryIds: (json['category_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      isActive: json['is_active'] as bool? ?? true,
      isFeatured: json['is_featured'] as bool? ?? false,
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ContentModelToJson(ContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'body': instance.body,
      'image_url': instance.imageUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'category_ids': instance.categoryIds,
      'tags': instance.tags,
      'metadata': instance.metadata,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_active': instance.isActive,
      'is_featured': instance.isFeatured,
      'view_count': instance.viewCount,
    };

PaginatedResponseModel<T> _$PaginatedResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) =>
    PaginatedResponseModel<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      nextPage: (json['next_page'] as num?)?.toInt(),
      previousPage: (json['previous_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginatedResponseModelToJson<T>(
  PaginatedResponseModel<T> instance,
  Object? Function(T) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'total': instance.total,
      'page': instance.page,
      'per_page': instance.perPage,
      'next_page': instance.nextPage,
      'previous_page': instance.previousPage,
    };
