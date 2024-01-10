import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc/data/provider/user_provider.dart';
import 'package:users_bloc/data/repository/user_repository.dart';
import 'package:users_bloc/features/users/bloc/user_bloc.dart';
import 'package:users_bloc/features/users/ui/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.teal
      ),
      home: RepositoryProvider(
          create: (context) => UserRepository(UserProvider()),
          child: BlocProvider(
            create: (context) => UserBloc(context.read<UserRepository>()),
            child: const Users(),
          )
      ),
    );
  }
}

