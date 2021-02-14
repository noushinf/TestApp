import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/src/bloc/event_login.dart';
import 'package:test_app/src/bloc/login_state.dart';
import 'package:test_app/src/get-it.dart';
import 'package:test_app/src/repository/login_repository.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository _repository;

  LoginBloc({LoginRepository repository}) : super(LoginUninitialized()) {
    this._repository = repository ?? getIt.get<LoginRepository>();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      try {
        yield LoginLoading();
        var result = await _repository.loginAsync(event.username, event.password);
        yield LoginSuccess(result: result);
      } catch (ex) {
        yield LoginError(ex);
      }
    }
  }
}
