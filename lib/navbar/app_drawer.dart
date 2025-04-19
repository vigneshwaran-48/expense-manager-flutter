import 'package:expense_manager/navbar/nav_list.dart';
import 'package:expense_manager/navbar/navbar_cubit.dart';
import 'package:expense_manager/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserInitial || state is UserLoading) {
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (state is UserLoaded) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage("assets/images/user.png"),
                        child: Icon(Icons.person),
                      ),
                      Text(state.user.email),
                    ],
                  );
                }
                return Center(child: Text("Error"));
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<NavbarCubit, int>(
                builder: (context, currentIndex) {
                  return NavList(selectedIndex: currentIndex, isDrawer: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
