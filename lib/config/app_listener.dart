import 'package:expense_manager/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/auth/bloc/auth_state.dart';
import 'package:expense_manager/user/bloc/user_bloc.dart';
import 'package:expense_manager/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppListener extends StatelessWidget {
  const AppListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated &&
                  context.read<UserBloc>().state is UserInitial) {
                context.read<UserBloc>().add(LoadUser(id: state.user.uid));
              }
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(isError: true, message: state.errMsg),
                );
              }
              if (state is UnAuthenticated) {
                context.go("/login");
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(isError: true, message: state.errMsg),
                );
              }
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
