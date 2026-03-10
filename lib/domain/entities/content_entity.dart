/// كيان المحتوى العام - قابل للتوسع لأي نوع محتوى تجاري
library;

import 'package:equatable/equatable.dart';

/// كيان المحتوى العام
class ContentEntity extends Equatable {
  const ContentEntity({
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
  final String? imageUrl;
  final String? thumbnailUrl;
  final List<String> categoryIds;  // يمكن ربطه بعدة تصنيفات
  final List<String> tags;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isFeatured;
  final int viewCount;

  @override
  List<Object?> get props => [
    id, title, slug, description, body,
    imageUrl, thumbnailUrl, categoryIds, tags,
    metadata, createdAt, updatedAt, isActive, isFeatured, viewCount,
  ];

  ContentEntity copyWith({
    String? id,
    String? title,
    String? slug,
    String? description,
    String? body,
    String? imageUrl,
    String? thumbnailUrl,
    List<String>? categoryIds,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isFeatured,
    int? viewCount,
  }) =>
      ContentEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        body: body ?? this.body,
        imageUrl: imageUrl ?? this.imageUrl,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        categoryIds: categoryIds ?? this.categoryIds,
        tags: tags ?? this.tags,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        isFeatured: isFeatured ?? this.isFeatured,
        viewCount: viewCount ?? this.viewCount,
      );
}
