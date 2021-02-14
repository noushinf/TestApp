import 'package:test_app/src/api/user_api.dart';
import 'package:test_app/src/get-it.dart';
import 'package:test_app/src/model/user/user_profile_data.dart';

class UserRepository {
  UserApiProvider userApiProvider;

  UserRepository({UserApiProvider apiProvider}) {
    this.userApiProvider = apiProvider ?? getIt.get<UserApiProvider>();
  }

  Future<UserProfileDataModel> getUserProfileData(String accessToken) =>
      userApiProvider.getUserProfileData(accessToken);
}
