import 'package:flutter/material.dart';
import 'package:users_bloc/data/model/user_model.dart';

class UserDetails extends StatefulWidget {
  final Datum user;
  const UserDetails({super.key, required this.user});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details"), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                  widget.user.avatar
            ),
            const SizedBox(height: 50,),
            Text("User ID : ${widget.user.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Name : ${widget.user.firstName} ${widget.user.lastName}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.user.email, style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
