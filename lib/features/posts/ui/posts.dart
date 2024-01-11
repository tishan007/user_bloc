import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc/data/model/post_model.dart';
import 'package:users_bloc/features/posts/bloc/post_bloc.dart';
import 'package:users_bloc/features/posts/bloc/post_event.dart';
import 'package:users_bloc/features/posts/bloc/post_state.dart';

import '../../../data/provider/user_provider.dart';
import '../../../data/repository/user_repository.dart';
import '../../users/bloc/user_bloc.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<PostBloc>().add(LoadPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Joy Volanath"), centerTitle: true),
      /*body: RepositoryProvider(
          create: (context) => UserRepository(UserProvider()),
          child: BlocProvider(
            create: (context) => UserBloc(context.read<UserRepository>()),
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if(state is PostLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if(state is PostErrorState) {
                  return const Center(child: Text("error"));
                }

                if(state is PostLoadedState) {
                  return _postView(context, state.postModel);

                }

                return Container();
              },
            ),
          )
      ),*/
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if(state is PostLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if(state is PostErrorState) {
            return const Center(child: Text("error"));
          }

          if(state is PostLoadedState) {
            return _postView(context, state.postModel);

          }

          return Container();
        },
      ),

    );
  }

  Widget _postView(BuildContext context, List<PostModel> postList) {
    return ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(postList[index].title),
            subtitle: Text(postList[index].body),
          );
        }
    );
  }
}
