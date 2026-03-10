/// كيان التصنيف - بنية بيانات شجرية لا محدودة المستويات
library;

import 'package:equatable/equatable.dart';

/// كيان التصنيف مع دعم التسلسل الهرمي
class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.imageUrl,
    this.parentId,
    this.children = const [],
    this.level = 0,
    this.itemCount = 0,
    this.isActive = true,
    this.metadata,
  });

  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? imageUrl;
  final String? parentId;                      // null = جذر الشجرة
  final List<CategoryEntity> children;          // تصنيفات فرعية
  final int level;                              // مستوى العمق في الشجرة
  final int itemCount;
  final bool isActive;
  final Map<String, dynamic>? metadata;

  bool get isRoot    => parentId == null;
  bool get hasChildren => children.isNotEmpty;

  @override
  List<Object?> get props => [
    id, name, slug, description, imageUrl,
    parentId, children, level, itemCount, isActive, metadata,
  ];

  CategoryEntity copyWith({
    String? id,
    String? name,
    String? slug,
    String? description,
    String? imageUrl,
    String? parentId,
    List<CategoryEntity>? children,
    int? level,
    int? itemCount,
    bool? isActive,
    Map<String, dynamic>? metadata,
  }) =>
      CategoryEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        parentId: parentId ?? this.parentId,
        children: children ?? this.children,
        level: level ?? this.level,
        itemCount: itemCount ?? this.itemCount,
        isActive: isActive ?? this.isActive,
        metadata: metadata ?? this.metadata,
      );
}
