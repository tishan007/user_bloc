import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc/data/repository/user_repository.dart';
import 'package:users_bloc/features/users/bloc/user_event.dart';
import 'package:users_bloc/features/users/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitialState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        final users = await _userRepository.getUserList();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }

    });
  }
}