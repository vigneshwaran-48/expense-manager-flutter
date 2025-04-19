part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final AppUser user;

  UserLoaded({required this.user});
}

final class UserError extends UserState {
  final String errMsg;

  UserError({required this.errMsg});
}
