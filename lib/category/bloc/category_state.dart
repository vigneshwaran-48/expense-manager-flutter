part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoriesLoaded extends CategoryState {
  final List<Category> categories;

  CategoriesLoaded({required this.categories});
}

final class CategoryError extends CategoryState {
  final String errMsg;

  CategoryError({required this.errMsg});
}

final class CategoryLoading extends CategoryState {}

final class SearchingCategory extends CategoryState {}

final class CategoryDeleted extends CategoryState {}

