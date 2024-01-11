import 'package:users_bloc/data/model/user_model.dart';

sealed class UserState {}

final class UserInitialState extends UserState {

}

final class UserLoadingState extends UserState {

}

final class UserLoadedState extends UserState {
  final UserModel userModel;
  UserLoadedState(this.userModel);
}

final class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);

}

final class UserFABClickState extends UserState {
  final UserModel userModel;
  UserFABClickState(this.userModel);
}