import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated({required this.user});
}

class UnAuthenticated extends AuthState {}

class AuthError extends AuthState {}
