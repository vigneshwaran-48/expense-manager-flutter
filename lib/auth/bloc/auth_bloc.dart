import 'package:expense_manager/auth/authentication_service.dart';
import 'package:expense_manager/auth/bloc/auth_event.dart';
import 'package:expense_manager/auth/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService _authenticationService = AuthenticationService();

  AuthBloc() : super(AuthInitial()) {
    _authenticationService.authStateChanges().listen((user) {
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(UnAuthenticated());
      }
    });

    on<AppStarted>((event, emit) async {
      emit(AuthLoading());
      final user = _authenticationService.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(UnAuthenticated());
      }
    });

    on<SignUpUser>((event, emit) async {
      emit(AuthLoading());
      final User? user = await _authenticationService.signUp(
        event.email,
        event.password,
      );
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(AuthError());
      }
    });
  }
}
