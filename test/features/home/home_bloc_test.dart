import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_template/core/error/failures.dart';
import 'package:flutter_template/features/home/domain/entities/category.dart';
import 'package:flutter_template/features/home/domain/entities/item.dart';
import 'package:flutter_template/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_template/features/home/domain/usecases/get_items_usecase.dart';
import 'package:flutter_template/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_template/features/home/presentation/bloc/home_event.dart';
import 'package:flutter_template/features/home/presentation/bloc/home_state.dart';

// -- Mocks --
class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}
class MockGetItemsUseCase extends Mock implements GetItemsUseCase {}

void main() {
  late HomeBloc bloc;
  late MockGetCategoriesUseCase mockGetCategories;
  late MockGetItemsUseCase mockGetItems;

  const testCategories = [
    Category(id: '1', name: 'تصنيف 1'),
    Category(id: '2', name: 'تصنيف 2'),
  ];

  setUp(() {
    mockGetCategories = MockGetCategoriesUseCase();
    mockGetItems = MockGetItemsUseCase();
    bloc = HomeBloc(
      getCategoriesUseCase: mockGetCategories,
      getItemsUseCase: mockGetItems,
    );
  });

  tearDown(() => bloc.close());

  test('الحالة الابتدائية HomeInitial', () {
    expect(bloc.state, isA<HomeInitial>());
  });

  group('HomeInitialized', () {
    blocTest<HomeBloc, HomeState>(
      'يُصدر HomeLoading ثم HomeLoaded عند نجاح جلب التصنيفات',
      build: () {
        when(
          () => mockGetCategories(
            parentId: any(named: 'parentId'),
            forceRefresh: any(named: 'forceRefresh'),
          ),
        ).thenAnswer((_) async => const Right(testCategories));
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeInitialized()),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>()
            .having((s) => s.categories.length, 'عدد التصنيفات', 2),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'يُصدر HomeError عند فشل جلب التصنيفات',
      build: () {
        when(
          () => mockGetCategories(
            parentId: any(named: 'parentId'),
            forceRefresh: any(named: 'forceRefresh'),
          ),
        ).thenAnswer(
          (_) async =>
              const Left(ServerFailure(message: 'خطأ في الخادم')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeInitialized()),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>().having((s) => s.message, 'رسالة الخطأ',
            'خطأ في الخادم'),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'يُصدر HomeError مع isNetworkError=true عند انقطاع الإنترنت',
      build: () {
        when(
          () => mockGetCategories(
            parentId: any(named: 'parentId'),
            forceRefresh: any(named: 'forceRefresh'),
          ),
        ).thenAnswer((_) async => const Left(NetworkFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeInitialized()),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>()
            .having((s) => s.isNetworkError, 'خطأ شبكة', isTrue),
      ],
    );
  });
}
