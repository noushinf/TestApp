
import 'package:test_app/src/api/login_api_provider.dart';
import 'package:test_app/src/get-it.dart';
import 'package:test_app/src/model/login/access_token_result.dart';

class LoginRepository {
  LoginApiProvider loginApiProvider;

  LoginRepository({LoginApiProvider loginApiProvider}) {
    this.loginApiProvider = loginApiProvider ?? getIt.get<LoginApiProvider>();
  }

  Future<AccessTokenResult> loginAsync(String username, String password) => loginApiProvider.loginAsync(username, password);
}