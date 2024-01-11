import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc/data/model/post_model.dart';
import 'package:users_bloc/data/repository/user_repository.dart';
import 'package:users_bloc/features/posts/bloc/post_event.dart';
import 'package:users_bloc/features/posts/bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UserRepository _userRepository;

  PostBloc(this._userRepository): super(PostInitialState()) {

    on<LoadPostEvent>((event, emit) async {
      emit(PostLoadingState());

      try {
        final posts = await _userRepository.getPost();
        emit(PostLoadedState(posts));
      } catch (e) {
        emit(PostErrorState(e.toString()));
      }

    });

    on<DeletePostEvent>((event, emit) async {
      try {
        List<PostModel> posts = await _userRepository.getPost();
        posts.remove(event.postModel);
        emit(PostLoadedState(posts));
      } catch (e) {
        emit(PostErrorState(e.toString()));
      }
    });

  }
}