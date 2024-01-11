import 'package:users_bloc/data/model/post_model.dart';

sealed class PostEvent {

}

final class LoadPostEvent extends PostEvent {

}

final class DeletePostEvent extends PostEvent {
  final PostModel postModel;
  DeletePostEvent({required this.postModel});
}