import 'package:http/http.dart' as http;
import 'package:users_bloc/data/model/post_model.dart';
import 'package:users_bloc/data/model/user_model.dart';
import 'dart:convert';

class UserProvider {

  Future<UserModel> getUserList() async {

    try {
      var response = await http.get(Uri.parse("https://reqres.in/api/users"),);

      print("=== user response ==== : ${response.body}");
      return UserModel.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<PostModel>> getPost() async {

    List<PostModel> postList = [];

    try {
      var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"),);

      dynamic data = response.body;

      data.forEach((element) {
        PostModel postModel = PostModel.fromJson(json.decode(response.body));
        postList.add(postModel);
      });


      print("=== post response ==== : ${response.body}");
      //return PostModel.fromJson(json.decode(response.body));
      return postList;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

}