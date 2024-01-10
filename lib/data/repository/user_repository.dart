import 'package:users_bloc/data/model/user_model.dart';
import 'package:users_bloc/data/provider/user_provider.dart';

abstract class IUserRepository {
  Future<UserModel> getUserList();
}

class UserRepository {
  final UserProvider userProvider;
  UserRepository(this.userProvider);

  Future<UserModel> getUserList() {
    return userProvider.getUserList();
  }

  /*Future<Response> verifyEmail(String email, String token) async {
    return await apiClient.postData(AppConstants.VERIFY_EMAIL_URI, {"email": email, "token": token});
  }

  Future<Response> updateZone() async {
    return await apiClient.getData(AppConstants.UPDATE_ZONE_URL);
  }*/
}