import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_app/core/app_config.dart';
import 'package:test_app/src/get-it.dart';
import 'package:test_app/src/model/user/user_profile_data.dart';

class UserApiProvider {
  http.Client client;

  UserApiProvider({http.Client client}) {
    this.client = client ?? getIt.get<http.Client>();
  }

  Future<UserProfileDataModel> getUserProfileData(String accessToken) async {
    var url = "${AppConfig.baseUrl}/api/mulkizerin/user/profile/data";
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
  }
}
