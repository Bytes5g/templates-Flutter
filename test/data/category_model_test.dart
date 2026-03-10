import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/data/models/category_model.dart';
import 'package:flutter_template/domain/entities/category_entity.dart';

void main() {
  group('CategoryModel', () {
    const tJson = {
      'id': '1',
      'name': 'إلكترونيات',
      'slug': 'electronics',
      'description': 'وصف التصنيف',
      'image_url': 'https://example.com/img.jpg',
      'parent_id': null,
      'children': [],
      'level': 0,
      'item_count': 25,
      'is_active': true,
      'metadata': null,
    };

    test('fromJson يُحوّل JSON إلى CategoryModel بشكل صحيح', () {
      final model = CategoryModel.fromJson(tJson);

      expect(model.id, equals('1'));
      expect(model.name, equals('إلكترونيات'));
      expect(model.slug, equals('electronics'));
      expect(model.imageUrl, equals('https://example.com/img.jpg'));
      expect(model.itemCount, equals(25));
      expect(model.isActive, isTrue);
      expect(model.children, isEmpty);
    });

    test('toJson يُحوّل CategoryModel إلى JSON صحيح', () {
      const model = CategoryModel(id: '1', name: 'تصنيف', slug: 'slug');
      final json = model.toJson();

      expect(json['id'], equals('1'));
      expect(json['name'], equals('تصنيف'));
      expect(json['slug'], equals('slug'));
    });

    test('toEntity يُحوّل إلى CategoryEntity صحيح', () {
      final model = CategoryModel.fromJson(tJson);
      final entity = model.toEntity();

      expect(entity, isA<CategoryEntity>());
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
      expect(entity.itemCount, equals(model.itemCount));
    });

    test('fromEntity يُحوّل CategoryEntity إلى CategoryModel', () {
      const entity = CategoryEntity(
        id: '2',
        name: 'ملابس',
        slug: 'clothing',
        itemCount: 100,
      );
      final model = CategoryModel.fromEntity(entity);

      expect(model.id, equals('2'));
      expect(model.name, equals('ملابس'));
      expect(model.itemCount, equals(100));
    });

    test('يُعالج التصنيفات الفرعية بشكل صحيح', () {
      const jsonWithChildren = {
        'id': '1',
        'name': 'جذر',
        'slug': 'root',
        'children': [
          {'id': '1-1', 'name': 'فرعي', 'slug': 'child', 'children': [], 'level': 1, 'item_count': 0, 'is_active': true},
        ],
        'level': 0,
        'item_count': 5,
        'is_active': true,
      };

      final model = CategoryModel.fromJson(jsonWithChildren);
      expect(model.children.length, equals(1));
      expect(model.children.first.name, equals('فرعي'));

      final entity = model.toEntity();
      expect(entity.hasChildren, isTrue);
      expect(entity.children.first.level, equals(1));
    });
  });
}
