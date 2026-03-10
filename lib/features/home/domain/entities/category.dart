import 'package:equatable/equatable.dart';

/// كيان التصنيف - طبقة Domain (منطق الأعمال النقي)
class Category extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? parentId;
  final List<Category> children;
  final int itemCount;

  const Category({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.parentId,
    this.children = const [],
    this.itemCount = 0,
  });

  /// هل هذا تصنيف جذر؟
  bool get isRoot => parentId == null;

  /// هل له تصنيفات فرعية؟
  bool get hasChildren => children.isNotEmpty;

  @override
  List<Object?> get props => [id, name, parentId, itemCount];
}
