import 'package:users_bloc/data/model/post_model.dart';

sealed class PostState {}

final class PostInitialState extends PostState {

}

final class PostLoadingState extends PostState {

}

final class PostLoadedState extends PostState {
  final List<PostModel> postModel;
  PostLoadedState(this.postModel);
}

final class PostErrorState extends PostState {
  final String error;
  PostErrorState(this.error);

}