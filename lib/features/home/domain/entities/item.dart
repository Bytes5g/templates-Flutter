import 'package:equatable/equatable.dart';

/// كيان العنصر - طبقة Domain
class Item extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String categoryId;
  final List<String> tags;
  final DateTime? createdAt;
  final Map<String, dynamic> metadata;

  const Item({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    required this.categoryId,
    this.tags = const [],
    this.createdAt,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [id, title, categoryId];
}
