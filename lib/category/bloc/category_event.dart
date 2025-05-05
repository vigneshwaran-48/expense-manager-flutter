part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class CategoryInitializing extends CategoryEvent {}

final class LoadCategories extends CategoryEvent {}

final class AddCategory extends CategoryEvent {
  final Category category;

  AddCategory({required this.category});
}
