import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_template/core/errors/failures.dart';
import 'package:flutter_template/core/utils/either.dart';
import 'package:flutter_template/domain/entities/category_entity.dart';
import 'package:flutter_template/domain/usecases/category_usecases.dart';
import 'package:flutter_template/presentation/bloc/category_bloc.dart';
import 'package:flutter_template/presentation/bloc/app_states.dart';

class MockGetCategoryTreeUseCase extends Mock
    implements GetCategoryTreeUseCase {}

class MockGetRootCategoriesUseCase extends Mock
    implements GetRootCategoriesUseCase {}

class MockGetSubCategoriesUseCase extends Mock
    implements GetSubCategoriesUseCase {}

class MockGetCategoryByIdUseCase extends Mock
    implements GetCategoryByIdUseCase {}

void main() {
  late MockGetCategoryTreeUseCase mockGetCategoryTree;
  late MockGetRootCategoriesUseCase mockGetRootCategories;
  late MockGetSubCategoriesUseCase mockGetSubCategories;
  late MockGetCategoryByIdUseCase mockGetCategoryById;

  setUp(() {
    mockGetCategoryTree = MockGetCategoryTreeUseCase();
    mockGetRootCategories = MockGetRootCategoriesUseCase();
    mockGetSubCategories = MockGetSubCategoriesUseCase();
    mockGetCategoryById = MockGetCategoryByIdUseCase();
  });

  CategoryBloc buildBloc() => CategoryBloc(
    getCategoryTree: mockGetCategoryTree,
    getRootCategories: mockGetRootCategories,
    getSubCategories: mockGetSubCategories,
    getCategoryById: mockGetCategoryById,
  );

  const tCategories = [
    CategoryEntity(id: '1', name: 'إلكترونيات', slug: 'electronics'),
    CategoryEntity(id: '2', name: 'ملابس', slug: 'clothing'),
  ];

  group('CategoryBloc', () {
    test('الحالة الأولية هي InitialState', () {
      expect(buildBloc().state, isA<InitialState<List<CategoryEntity>>>());
    });

    blocTest<CategoryBloc, CategoryState>(
      'LoadCategoryTreeEvent يُصدر LoadingState ثم SuccessState',
      build: buildBloc,
      setUp: () {
        when(() => mockGetCategoryTree()).thenAnswer(
          (_) async => right(tCategories),
        );
      },
      act: (bloc) => bloc.add(const LoadCategoryTreeEvent()),
      expect: () => [
        isA<LoadingState<List<CategoryEntity>>>(),
        isA<SuccessState<List<CategoryEntity>>>(),
      ],
    );

    blocTest<CategoryBloc, CategoryState>(
      'LoadCategoryTreeEvent يُصدر FailureState عند فشل الشبكة',
      build: buildBloc,
      setUp: () {
        when(() => mockGetCategoryTree()).thenAnswer(
          (_) async => left(const NetworkFailure()),
        );
      },
      act: (bloc) => bloc.add(const LoadCategoryTreeEvent()),
      expect: () => [
        isA<LoadingState<List<CategoryEntity>>>(),
        isA<FailureState<List<CategoryEntity>>>(),
      ],
    );

    blocTest<CategoryBloc, CategoryState>(
      'LoadSubCategoriesEvent يجلب التصنيفات الفرعية',
      build: buildBloc,
      setUp: () {
        when(() => mockGetSubCategories('1')).thenAnswer(
          (_) async => right(tCategories),
        );
      },
      act: (bloc) => bloc.add(const LoadSubCategoriesEvent('1')),
      expect: () => [
        isA<LoadingState<List<CategoryEntity>>>(),
        isA<SuccessState<List<CategoryEntity>>>(),
      ],
    );
  });
}
