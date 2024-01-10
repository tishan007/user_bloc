import 'package:http/http.dart' as http;
import 'package:users_bloc/data/model/user_model.dart';
import 'dart:convert';

class UserProvider {

  Future<UserModel> getUserList() async {

    try {
      var response = await http.get(Uri.parse("https://reqres.in/api/users"),);

      print("=== response ==== : ${response.body}");
      return UserModel.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

}