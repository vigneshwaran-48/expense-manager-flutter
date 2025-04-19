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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return SizedBox(
                    width: 110,
                    height: 110,
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (state is UserLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/images/user.png"),
                          child: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(state.user.email),
                    ],
                  );
                }
                return Center(child: Text("Error"));
              },
            ),
            SizedBox(height: 40),
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
