import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/domain/entities/category_entity.dart';
import 'package:flutter_template/domain/entities/pagination.dart';

void main() {
  group('CategoryEntity', () {
    test('يُمثّل تصنيف جذري صحيح', () {
      const cat = CategoryEntity(
        id: '1',
        name: 'إلكترونيات',
        slug: 'electronics',
      );

      expect(cat.isRoot, isTrue);
      expect(cat.hasChildren, isFalse);
      expect(cat.isActive, isTrue);
      expect(cat.level, equals(0));
    });

    test('يُمثّل تصنيف فرعي صحيح', () {
      const child = CategoryEntity(
        id: '1-1',
        name: 'هواتف',
        slug: 'phones',
        parentId: '1',
        level: 1,
      );

      expect(child.isRoot, isFalse);
    });

    test('يُمثّل شجرة من التصنيفات', () {
      const parent = CategoryEntity(
        id: '1',
        name: 'إلكترونيات',
        slug: 'electronics',
        children: [
          CategoryEntity(id: '1-1', name: 'هواتف', slug: 'phones', parentId: '1', level: 1),
          CategoryEntity(id: '1-2', name: 'أجهزة لوحية', slug: 'tablets', parentId: '1', level: 1),
        ],
      );

      expect(parent.hasChildren, isTrue);
      expect(parent.children.length, equals(2));
    });

    test('copyWith يُنشئ نسخة محدّثة', () {
      const original = CategoryEntity(id: '1', name: 'قديم', slug: 'old');
      final updated = original.copyWith(name: 'جديد', itemCount: 10);

      expect(updated.name, equals('جديد'));
      expect(updated.itemCount, equals(10));
      expect(updated.id, equals('1'));   // لم يتغير
    });

    test('يتساوى تصنيفان بنفس البيانات', () {
      const cat1 = CategoryEntity(id: '1', name: 'تصنيف', slug: 'slug');
      const cat2 = CategoryEntity(id: '1', name: 'تصنيف', slug: 'slug');

      expect(cat1, equals(cat2));
    });
  });

  group('PaginatedResult', () {
    test('يحسب الصفحات الكلية بشكل صحيح', () {
      final result = PaginatedResult<String>(
        items: List.generate(10, (i) => 'عنصر $i'),
        total: 55,
        page: 1,
        perPage: 10,
        nextPage: 2,
      );

      expect(result.totalPages, equals(6));
      expect(result.hasNextPage, isTrue);
      expect(result.hasPreviousPage, isFalse);
    });

    test('PaginationParams.toQueryParams يُضمّن جميع المعاملات', () {
      const params = PaginationParams(
        page: 2,
        perPage: 20,
        search: 'هاتف',
        sortBy: 'name',
        sortOrder: 'asc',
      );

      final query = params.toQueryParams();
      expect(query['page'], equals(2));
      expect(query['per_page'], equals(20));
      expect(query['search'], equals('هاتف'));
      expect(query['sort_by'], equals('name'));
      expect(query['sort_order'], equals('asc'));
    });
  });
}
