import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/src/model/user/user_profile_data.dart';

class LocalStorageService {
  static const String AccessToken = "access_token";
  static const String RefreshToken = "refresh_token";
  static const String CurrentUserData = "current_user";


  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = new LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }



  String get accessToken => _getFromDisk(AccessToken);

  set accessToken(String value) => _saveToDisk(AccessToken, value);
  // Refresh Token
  String get refreshToken => _getFromDisk(RefreshToken);

  set refreshToken(String value) => _saveToDisk(RefreshToken, value);

  UserProfileDataModel get currentUser {
    String dataString = _getFromDisk(CurrentUserData);
    try {
      return UserProfileDataModel.fromJson(json.decode(dataString));
    } catch (e) {
      return null;
    }
  }

  set currentUser(UserProfileDataModel user) {
    if (user == null) {
      _saveToDisk(CurrentUserData, "");
    } else {
      var dataJson = json.encode(user.toJson());
      _saveToDisk(CurrentUserData, dataJson);
    }
  }




  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
