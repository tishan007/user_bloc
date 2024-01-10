import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc/data/model/user_model.dart';
import 'package:users_bloc/features/users/bloc/user_bloc.dart';
import 'package:users_bloc/features/users/bloc/user_event.dart';
import 'package:users_bloc/features/users/bloc/user_state.dart';

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

          return Container();
        },
      )
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
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: () {

              },
            )
          );
        }
    );
  }

}
