import 'package:http/http.dart' as http;

import 'package:get_it/get_it.dart';
import 'package:test_app/src/api/login_api_provider.dart';
import 'package:test_app/src/api/user_api.dart';
import 'package:test_app/src/bloc/login_bloc.dart';
import 'package:test_app/src/bloc/user_bloc.dart';
import 'package:test_app/src/repository/login_repository.dart';
import 'package:test_app/src/repository/user_repository.dart';

GetIt getIt = GetIt.I;

void setupLocator() {
  // Singleton

  getIt.registerSingleton(http.Client());
  getIt.registerSingleton(LoginApiProvider());
  getIt.registerSingleton(LoginRepository());

  getIt.registerSingleton(UserApiProvider());
  getIt.registerSingleton(UserRepository());



  getIt.registerFactory<LoginBloc>(() => LoginBloc());
  getIt.registerFactory<UserProfileDataBloc>(() => UserProfileDataBloc());

}