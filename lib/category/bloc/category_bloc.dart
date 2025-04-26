import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/category/category.dart';
import 'package:expense_manager/category/category_service.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService categoryService;

  CategoryBloc({required this.categoryService}) : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      try {
        emit(CategoryLoading());
        final categories = await categoryService.getCategories();
        emit(CategoriesLoaded(categories: categories));
      } on FirebaseException catch (err) {
        emit(
          CategoryError(
            errMsg:
                err.message != null
                    ? err.message!
                    : "Error while getting categories",
          ),
        );
      } catch (err) {
        emit(CategoryError(errMsg: "Error while getting categories"));
      }
    });
  }
}
