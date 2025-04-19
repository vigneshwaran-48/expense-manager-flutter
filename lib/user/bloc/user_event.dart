part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class CreateUser extends UserEvent {
  final AppUser user;

  CreateUser({required this.user});
}

final class UpdateUser extends UserEvent {
  final AppUser user;

  UpdateUser({required this.user});
}

final class LoadUser extends UserEvent {
  final String id;

  LoadUser({required this.id});
}
