/// نموذج بيانات المحتوى
library;

import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/content_entity.dart';

part 'content_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ContentModel {
  const ContentModel({
    required this.id,
    required this.title,
    required this.slug,
    this.description,
    this.body,
    this.imageUrl,
    this.thumbnailUrl,
    this.categoryIds = const [],
    this.tags = const [],
    this.metadata,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.isFeatured = false,
    this.viewCount = 0,
  });

  final String id;
  final String title;
  final String slug;
  final String? description;
  final String? body;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @JsonKey(name: 'category_ids')
  final List<String> categoryIds;
  final List<String> tags;
  final Map<String, dynamic>? metadata;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  @JsonKey(name: 'view_count')
  final int viewCount;

  factory ContentModel.fromJson(Map<String, dynamic> json) =>
      _$ContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentModelToJson(this);

  ContentEntity toEntity() => ContentEntity(
    id: id,
    title: title,
    slug: slug,
    description: description,
    body: body,
    imageUrl: imageUrl,
    thumbnailUrl: thumbnailUrl,
    categoryIds: categoryIds,
    tags: tags,
    metadata: metadata,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isActive: isActive,
    isFeatured: isFeatured,
    viewCount: viewCount,
  );

  factory ContentModel.fromEntity(ContentEntity entity) => ContentModel(
    id: entity.id,
    title: entity.title,
    slug: entity.slug,
    description: entity.description,
    body: entity.body,
    imageUrl: entity.imageUrl,
    thumbnailUrl: entity.thumbnailUrl,
    categoryIds: entity.categoryIds,
    tags: entity.tags,
    metadata: entity.metadata,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    isActive: entity.isActive,
    isFeatured: entity.isFeatured,
    viewCount: entity.viewCount,
  );
}

/// نموذج الاستجابة المُقسَّمة
@JsonSerializable(explicitToJson: true)
class PaginatedResponseModel<T> {
  const PaginatedResponseModel({
    required this.data,
    required this.total,
    required this.page,
    required this.perPage,
    this.nextPage,
    this.previousPage,
  });

  final List<T> data;
  final int total;
  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;
  @JsonKey(name: 'next_page')
  final int? nextPage;
  @JsonKey(name: 'previous_page')
  final int? previousPage;

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      PaginatedResponseModel<T>(
        data: (json['data'] as List).map(fromJsonT).toList(),
        total: json['total'] as int,
        page: json['page'] as int,
        perPage: json['per_page'] as int,
        nextPage: json['next_page'] as int?,
        previousPage: json['previous_page'] as int?,
      );
}
