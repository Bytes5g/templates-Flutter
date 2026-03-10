/// BLoC التصنيفات
library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/category_usecases.dart';
import 'app_states.dart';

// ─── أحداث ───

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoryTreeEvent extends CategoryEvent {
  const LoadCategoryTreeEvent();
}

class LoadRootCategoriesEvent extends CategoryEvent {
  const LoadRootCategoriesEvent();
}

class LoadSubCategoriesEvent extends CategoryEvent {
  const LoadSubCategoriesEvent(this.parentId);
  final String parentId;

  @override
  List<Object> get props => [parentId];
}

class LoadCategoryByIdEvent extends CategoryEvent {
  const LoadCategoryByIdEvent(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

// ─── حالات ───

typedef CategoryState = AppState<List<CategoryEntity>>;

/// حالة خاصة: عرض تصنيف محدد
final class CategoryDetailState extends AppState<CategoryEntity> {
  const CategoryDetailState(this.category);
  final CategoryEntity category;

  @override
  List<Object> get props => [category];
}

// ─── BLoC ───

/// BLoC إدارة التصنيفات
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required GetCategoryTreeUseCase getCategoryTree,
    required GetRootCategoriesUseCase getRootCategories,
    required GetSubCategoriesUseCase getSubCategories,
    required GetCategoryByIdUseCase getCategoryById,
  })  : _getCategoryTree = getCategoryTree,
        _getRootCategories = getRootCategories,
        _getSubCategories = getSubCategories,
        _getCategoryById = getCategoryById,
        super(const InitialState()) {
    on<LoadCategoryTreeEvent>(_onLoadTree);
    on<LoadRootCategoriesEvent>(_onLoadRoot);
    on<LoadSubCategoriesEvent>(_onLoadSub);
    on<LoadCategoryByIdEvent>(_onLoadById);
  }

  final GetCategoryTreeUseCase _getCategoryTree;
  final GetRootCategoriesUseCase _getRootCategories;
  final GetSubCategoriesUseCase _getSubCategories;
  final GetCategoryByIdUseCase _getCategoryById;

  Future<void> _onLoadTree(
    LoadCategoryTreeEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const LoadingState());
    final result = await _getCategoryTree();
    emit(result.fold(
      (failure) => FailureState(failure),
      (data) => SuccessState(data),
    ));
  }

  Future<void> _onLoadRoot(
    LoadRootCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const LoadingState());
    final result = await _getRootCategories();
    emit(result.fold(
      (failure) => FailureState(failure),
      (data) => SuccessState(data),
    ));
  }

  Future<void> _onLoadSub(
    LoadSubCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const LoadingState());
    final result = await _getSubCategories(event.parentId);
    emit(result.fold(
      (failure) => FailureState(failure),
      (data) => SuccessState(data),
    ));
  }

  Future<void> _onLoadById(
    LoadCategoryByIdEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const LoadingState());
    final result = await _getCategoryById(event.id);
    result.fold(
      (failure) => emit(FailureState(failure)),
      (data) => emit(SuccessState([data])),
    );
  }
}
