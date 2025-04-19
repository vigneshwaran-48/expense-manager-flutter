abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class SignUpUser extends AuthEvent {
  final String email;
  final String password;

  SignUpUser({required this.email, required this.password});
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  LoginUser({required this.email, required this.password});
}

class LogoutUser extends AuthEvent {}
