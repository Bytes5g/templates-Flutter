/// نموذج بيانات التصنيف - يربط بين JSON والكيان
library;

import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/category_entity.dart';

part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryModel {
  const CategoryModel({
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
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'parent_id')
  final String? parentId;
  final List<CategoryModel> children;
  final int level;
  @JsonKey(name: 'item_count')
  final int itemCount;
  @JsonKey(name: 'is_active')
  final bool isActive;
  final Map<String, dynamic>? metadata;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  /// تحويل إلى كيان المجال
  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    name: name,
    slug: slug,
    description: description,
    imageUrl: imageUrl,
    parentId: parentId,
    children: children.map((c) => c.toEntity()).toList(),
    level: level,
    itemCount: itemCount,
    isActive: isActive,
    metadata: metadata,
  );

  /// إنشاء من كيان المجال
  factory CategoryModel.fromEntity(CategoryEntity entity) => CategoryModel(
    id: entity.id,
    name: entity.name,
    slug: entity.slug,
    description: entity.description,
    imageUrl: entity.imageUrl,
    parentId: entity.parentId,
    children: entity.children.map(CategoryModel.fromEntity).toList(),
    level: entity.level,
    itemCount: entity.itemCount,
    isActive: entity.isActive,
    metadata: entity.metadata,
  );
}
