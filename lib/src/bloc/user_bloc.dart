import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/src/bloc/user_event.dart';
import 'package:test_app/src/bloc/user_state.dart';
import 'package:test_app/src/get-it.dart';
import 'package:test_app/src/repository/user_repository.dart';


class UserProfileDataBloc extends Bloc<UserEvent, UserProfileDataState> {
  UserRepository _repository;

  UserProfileDataBloc({UserRepository repository}) : super(UserProfileDataUninitialized()) {
    this._repository = repository ?? getIt.get<UserRepository>();
  }

  @override
  Stream<UserProfileDataState> mapEventToState(UserEvent event) async* {
    if (event is GetUserProfileData) {
      try {
        yield UserProfileDataLoading();
        var result = await _repository.getUserProfileData(event.accessToken);
        yield UserProfileDataSuccess(result: result);
      } catch (ex) {
        yield UserProfileDataError(ex);
      }
    }
  }
}
