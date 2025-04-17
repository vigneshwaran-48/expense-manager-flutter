abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class SignUpUser extends AuthEvent {
  final String email;
  final String password;

  SignUpUser({required this.email, required this.password});
}
