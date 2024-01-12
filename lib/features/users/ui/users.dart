import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_bloc/data/model/user_model.dart';
import 'package:users_bloc/features/posts/bloc/post_bloc.dart';
import 'package:users_bloc/features/posts/bloc/post_event.dart';
import 'package:users_bloc/features/posts/ui/posts.dart';
import 'package:users_bloc/features/users/bloc/user_bloc.dart';
import 'package:users_bloc/features/users/bloc/user_event.dart';
import 'package:users_bloc/features/users/bloc/user_state.dart';
import 'package:users_bloc/features/users/ui/user_details.dart';


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
        appBar: AppBar(title: const Text("Bloc: Users"),centerTitle: true),
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
              Fluttertoast.showToast(
                  msg: "Hi I am Toast from Event Bloc State",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

              /// load state e again data get na korle, page back e bloc er state update hoy nah
              List<Datum> userList = state.userModel.data;
              return _userView(context, userList);
            }

            return Container();
          },
        ),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(Icons.touch_app_sharp),
        onPressed: () {
          context.read<UserBloc>().add(UserFABEvent());       // for toast msg show
          context.read<PostBloc>().add(LoadPostEvent());
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const Posts();
              //return _details();
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
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              //onPressed: _detailsPage(userList[index]),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return UserDetails(user : userList[index]);
                  },
                ));
              },
            ),
          );
        }
    );
  }

  Widget _details() {
    return Scaffold(
      appBar: AppBar(title: Text("Bloc Event Toast"), centerTitle: true,),
      body: const Center(
        child: Text("Toast"),
      ),
    );
  }

}
