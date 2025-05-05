import 'package:expense_manager/category/bloc/category_bloc.dart';
import 'package:expense_manager/category/category_item.dart';
import 'package:expense_manager/utils/app_snackbar.dart';
import 'package:expense_manager/utils/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesContainer extends StatelessWidget {
  const CategoriesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500, minWidth: 100),
                  child: AppSearchBar(
                    onSearch: (value) {
                      print("Searched for categories $value");
                    },
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    buildSnackBar(isError: true, message: state.errMsg),
                  );
                }
              },
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (state.isSearching) {
                  return Center(child: Icon(Icons.search));
                }
                if (state.isError) {
                  return Center(child: Text(state.errMsg));
                }
                if (state.categories != null) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.categories!.length,
                    itemBuilder:
                        (context, index) =>
                            CategoryItem(category: state.categories![index]),
                  );
                }
                return Center(child: Text("Unknown expense state $state"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
