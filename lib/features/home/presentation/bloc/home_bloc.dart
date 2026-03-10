import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_items_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

/// BLoC الصفحة الرئيسية - يفصل منطق الأعمال عن واجهة العرض
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetItemsUseCase getItemsUseCase;

  HomeBloc({
    required this.getCategoriesUseCase,
    required this.getItemsUseCase,
  }) : super(const HomeInitial()) {
    on<HomeInitialized>(_onInitialized);
    on<CategoriesLoadRequested>(_onCategoriesLoadRequested);
    on<CategorySelected>(_onCategorySelected);
    on<ItemsLoadRequested>(_onItemsLoadRequested);
    on<SearchRequested>(_onSearchRequested);
    on<HomeRetried>(_onRetried);
  }

  Future<void> _onInitialized(
    HomeInitialized event,
    Emitter<HomeState> emit,
  ) async {
    add(const CategoriesLoadRequested());
  }

  Future<void> _onCategoriesLoadRequested(
    CategoriesLoadRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final result = await getCategoriesUseCase(
      parentId: event.parentId,
      forceRefresh: event.forceRefresh,
    );

    result.fold(
      (failure) => emit(HomeError(
        message: _mapFailureToMessage(failure),
        isNetworkError: failure is NetworkFailure,
      )),
      (categories) => emit(HomeLoaded(categories: categories)),
    );
  }

  Future<void> _onCategorySelected(
    CategorySelected event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(current.copyWith(
        selectedCategory: event.category,
        items: [],
      ));
      add(ItemsLoadRequested(categoryId: event.category.id));
    }
  }

  Future<void> _onItemsLoadRequested(
    ItemsLoadRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoaded) return;
    final current = state as HomeLoaded;

    if (event.loadMore) {
      emit(current.copyWith(isLoadingMore: true));
    }

    final result = await getItemsUseCase(
      GetItemsParams(
        categoryId: event.categoryId,
        forceRefresh: event.forceRefresh,
      ),
    );

    result.fold(
      (failure) {
        if (event.loadMore) {
          emit(current.copyWith(isLoadingMore: false));
        } else {
          emit(HomeError(
            message: _mapFailureToMessage(failure),
            isNetworkError: failure is NetworkFailure,
          ));
        }
      },
      (items) {
        final allItems = event.loadMore
            ? [...current.items, ...items]
            : items;
        emit(current.copyWith(
          items: allItems,
          isLoadingMore: false,
          hasMoreItems: items.isNotEmpty,
        ));
      },
    );
  }

  Future<void> _onSearchRequested(
    SearchRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      add(const CategoriesLoadRequested());
      return;
    }

    emit(const HomeSearching());
    // TODO: استدعاء search use case
  }

  Future<void> _onRetried(
    HomeRetried event,
    Emitter<HomeState> emit,
  ) async {
    add(const CategoriesLoadRequested(forceRefresh: true));
  }

  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      NetworkFailure() => 'لا يوجد اتصال بالإنترنت',
      ServerFailure() => failure.message,
      CacheFailure() => failure.message,
      AuthFailure() => 'غير مصرح لك بالوصول',
      NotFoundFailure() => 'المحتوى غير موجود',
      ValidationFailure() => failure.message,
      _ => 'حدث خطأ غير متوقع',
    };
  }
}
