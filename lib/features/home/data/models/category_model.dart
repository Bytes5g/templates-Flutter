import '../../domain/entities/category.dart';

/// نموذج البيانات للتصنيف - طبقة Data
/// يمتد من الكيان ويضيف التحويل من/إلى JSON
class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    super.description,
    super.imageUrl,
    super.parentId,
    super.children,
    super.itemCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final childrenJson = json['children'] as List<dynamic>? ?? [];
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      parentId: json['parent_id'] as String?,
      children: childrenJson
          .map((c) => CategoryModel.fromJson(c as Map<String, dynamic>))
          .toList(),
      itemCount: json['item_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image_url': imageUrl,
        'parent_id': parentId,
        'children': children
            .map((c) => (c as CategoryModel).toJson())
            .toList(),
        'item_count': itemCount,
      };

  /// بيانات تجريبية للتطوير
  static List<CategoryModel> get mockData => [
        const CategoryModel(
          id: '1',
          name: 'التصنيف الأول',
          description: 'وصف التصنيف الأول',
          itemCount: 10,
          children: [
            CategoryModel(id: '1-1', name: 'فرعي 1-1', parentId: '1'),
            CategoryModel(id: '1-2', name: 'فرعي 1-2', parentId: '1'),
          ],
        ),
        const CategoryModel(
          id: '2',
          name: 'التصنيف الثاني',
          description: 'وصف التصنيف الثاني',
          itemCount: 5,
        ),
        const CategoryModel(
          id: '3',
          name: 'التصنيف الثالث',
          description: 'وصف التصنيف الثالث',
          itemCount: 8,
        ),
      ];
}
