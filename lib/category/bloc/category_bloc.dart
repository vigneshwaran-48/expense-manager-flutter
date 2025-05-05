import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/category/category.dart';
import 'package:expense_manager/category/category_service.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService categoryService;

  CategoryBloc({required this.categoryService})
    : super(CategoryState(isLoading: true)) {
    on<CategoryInitializing>((event, emit) {
      emit(CategoryInitial());
    });
    on<LoadCategories>((event, emit) async {
      try {
        emit(CategoryState(isLoading: true));
        final categories = await categoryService.getCategories();
        emit(CategoryState(categories: categories));
      } on FirebaseException catch (err) {
        emit(
          CategoryState(
            isError: true,
            errMsg:
                err.message != null
                    ? err.message!
                    : "Error while getting categories",
          ),
        );
      } catch (err) {
        emit(
          CategoryState(
            isError: true,
            errMsg: "Error while getting categories",
          ),
        );
      }
    });

    on<AddCategory>((event, emit) async {
      try {
        final addedCategory = await categoryService.addCategory(event.category);
      } on FirebaseException catch (err) {
        emit(
          CategoryState(
            isError: true,
            errMsg:
                err.message != null
                    ? err.message!
                    : "Error while getting categories",
          ),
        );
      } catch (err) {
        emit(
          CategoryState(
            isError: true,
            errMsg: "Error while getting categories",
          ),
        );
      }
    });
  }
}
