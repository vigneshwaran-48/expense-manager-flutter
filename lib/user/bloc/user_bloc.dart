import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/user/AppUser.dart';
import 'package:expense_manager/user/user_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

final String GENERIC_ERROR_MSG = "Error while loading user";

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc({required this.userService}) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      try {
        emit(UserLoading());
        final AppUser? user = await userService.getUser(event.id);
        if (user == null) {
          emit(UserError(errMsg: "User not found with the id: ${event.id}"));
        }
        emit(UserLoaded(user: user!));
      } on FirebaseException catch (err) {
        emit(
          UserError(
            errMsg: err.message != null ? err.message! : GENERIC_ERROR_MSG,
          ),
        );
      } catch (err) {
        print(err);
        emit(UserError(errMsg: GENERIC_ERROR_MSG));
      }
    });

    on<CreateUser>((event, emit) async {
      try {
        emit(UserLoading());
        await userService.createUser(event.user);
        emit(UserLoaded(user: event.user));
      } on FirebaseException catch (err) {
        emit(
          UserError(
            errMsg: err.message != null ? err.message! : GENERIC_ERROR_MSG,
          ),
        );
      } catch (err) {
        print(err);
        emit(UserError(errMsg: GENERIC_ERROR_MSG));
      }
    });
  }
}
