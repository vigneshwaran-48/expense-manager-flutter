part of 'category_bloc.dart';

final class CategoryState {
  final List<Category>? categories;
  final bool isLoading;
  final bool isSearching;
  final bool isAdding;
  final bool isError;
  final String errMsg;

  CategoryState({
    this.categories,
    this.isLoading = false,
    this.isSearching = false,
    this.isAdding = false,
    this.isError = false,
    this.errMsg = "",
  });
}

final class CategoryInitial extends CategoryState {}
