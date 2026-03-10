import '../../domain/entities/item.dart';

/// نموذج البيانات للعنصر - طبقة Data
class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.title,
    super.description,
    super.imageUrl,
    required super.categoryId,
    super.tags,
    super.createdAt,
    super.metadata,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      categoryId: json['category_id'] as String,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'category_id': categoryId,
        'tags': tags,
        'created_at': createdAt?.toIso8601String(),
        'metadata': metadata,
      };

  /// بيانات تجريبية للتطوير
  static List<ItemModel> mockDataForCategory(String categoryId) => [
        ItemModel(
          id: '${categoryId}_1',
          title: 'عنصر 1 في التصنيف $categoryId',
          description: 'وصف تفصيلي للعنصر الأول',
          categoryId: categoryId,
          tags: ['وسم1', 'وسم2'],
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        ItemModel(
          id: '${categoryId}_2',
          title: 'عنصر 2 في التصنيف $categoryId',
          description: 'وصف تفصيلي للعنصر الثاني',
          categoryId: categoryId,
          tags: ['وسم3'],
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        ItemModel(
          id: '${categoryId}_3',
          title: 'عنصر 3 في التصنيف $categoryId',
          categoryId: categoryId,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ];
}
