import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc/data/model/post_model.dart';
import 'package:users_bloc/features/posts/bloc/post_bloc.dart';
import 'package:users_bloc/features/posts/bloc/post_state.dart';


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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts"), centerTitle: true),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if(state is PostLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if(state is PostErrorState) {
            return Center(child: Text(state.error));
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
          return Card(
            elevation: 0.5,
            child: ListTile(
              title: Text(postList[index].title),
              subtitle: Text(postList[index].body),
            ),
          );
        }
    );
  }
}
