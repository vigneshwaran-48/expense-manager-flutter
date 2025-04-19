import 'package:expense_manager/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/auth/bloc/auth_state.dart';
import 'package:expense_manager/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  buildSnackbar(
                    context: context,
                    isError: true,
                    message: state.errMsg,
                    onClose:
                        () => ScaffoldMessenger.of(context).clearSnackBars(),
                  ),
                );
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackbar(
                    context: context,
                    isError: true,
                    message: state.errMsg,
                    onClose:
                        () => ScaffoldMessenger.of(context).clearSnackBars(),
                  ),
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

SnackBar buildSnackbar({
  required BuildContext context,
  required String message,
  required bool isError,
  required VoidCallback onClose,
}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: isError ? Colors.red : Theme.of(context).colorScheme.onPrimary,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(isError ? Icons.error : Icons.info),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
            IconButton(onPressed: onClose, icon: Icon(Icons.close)),
          ],
        ),
      ),
    ),
    behavior: SnackBarBehavior.floating,
  );
}
