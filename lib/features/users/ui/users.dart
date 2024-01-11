import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_bloc/data/model/user_model.dart';
import 'package:users_bloc/features/posts/bloc/post_bloc.dart';
import 'package:users_bloc/features/posts/bloc/post_event.dart';
import 'package:users_bloc/features/posts/bloc/post_state.dart';
import 'package:users_bloc/features/posts/ui/posts.dart';
import 'package:users_bloc/features/users/bloc/user_bloc.dart';
import 'package:users_bloc/features/users/bloc/user_event.dart';
import 'package:users_bloc/features/users/bloc/user_state.dart';

import '../../../data/provider/user_provider.dart';
import '../../../data/repository/user_repository.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserBloc>().add(LoadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Bloc"),centerTitle: true),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if(state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if(state is UserErrorState) {
              return const Center(child: Text("error"));
            }

            if(state is UserLoadedState) {
              List<Datum> userList = state.userModel.data;
              return _userView(context, userList);

            }

            if(state is UserFABClickState) {
              //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('FBA click')));
              /*Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Posts();
                },
              ));*/
              Fluttertoast.showToast(
                  msg: "Hi I am Toast from Event Bloc State",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              List<Datum> userList = state.userModel.data;
              return _userView(context, userList);
            }

            return Container();
          },
        ),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          context.read<UserBloc>().add(UserFABEvent());
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              //return Posts();
              return _details();
            },
          ));
        },
      ),

    );
  }

  Widget _userView(BuildContext context, List<Datum> userList) {
    return ListView.builder(
      itemCount: userList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(userList[index].firstName),
            subtitle: Text(userList[index].email),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                userList[index].avatar
              ),
            ),
          );
        }
    );
  }

  Widget _details() {
    return Scaffold(
      appBar: AppBar(title: Text("User Details"), centerTitle: true,),
      body: Center(
        child: Container(
          color: Colors.yellow,
          child: Text("my details"),
        ),
      ),
    );
  }

}
