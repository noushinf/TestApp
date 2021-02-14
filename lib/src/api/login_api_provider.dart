import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_app/core/app_config.dart';
import 'package:test_app/src/get-it.dart';
import 'package:test_app/src/model/login/access_token_result.dart';

class LoginApiProvider {
  http.Client client;

  LoginApiProvider({http.Client client}) {
    this.client = client ?? getIt.get<http.Client>();
  }

  Future<AccessTokenResult> loginAsync(String username, String password) async {
    var url = "${AppConfig.identityBaseUrl}/connect/token";
    Map<String, dynamic> body = {
      'grant_type': AppConfig.grantType,
      'client_id': AppConfig.clientId,
      'client_secret': AppConfig.clientSecret,
      'scope': AppConfig.scope,
      'username': username,
      'password': password,
    };
    final response = await client.post(
      url,
      body: body,
      headers: {HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"},
    );

  }
}