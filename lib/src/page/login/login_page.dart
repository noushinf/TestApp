import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/app_assets.dart';
import 'package:test_app/core/app_colors.dart';
import 'package:test_app/src/bloc/event_login.dart';
import 'package:test_app/src/bloc/login_bloc.dart';
import 'package:test_app/src/bloc/login_state.dart';
import 'package:test_app/src/bloc/user_bloc.dart';
import 'package:test_app/src/bloc/user_event.dart';
import 'package:test_app/src/bloc/user_state.dart';
import 'package:test_app/src/get-it.dart';
import 'package:test_app/src/local/local_storage_service.dart';
import 'package:test_app/src/page/home/home_page.dart';
import 'package:test_app/src/widget/busy_indicator.dart';
import 'package:test_app/src/widget/primary_button.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();
  var _txtUserNameController = TextEditingController();
  var _txtPasswordController = TextEditingController();
  LoginBloc _loginBloc;
  UserProfileDataBloc _userProfileDataBloc;
  LocalStorageService _storageService;

  bool _isBusy = false;

  @override
  void initState() {
    _loginBloc = getIt<LoginBloc>();
    _userProfileDataBloc = getIt<UserProfileDataBloc>();
    super.initState();
    _fetchInitData();
  }

  _fetchInitData() async {
    try {
      _storageService = await LocalStorageService.getInstance();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _loginBloc.close();
    _userProfileDataBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: BlocListener(
          bloc: _userProfileDataBloc,
          listener: (BuildContext context, UserProfileDataState state) {
            setState(() {
              _isBusy = state is UserProfileDataLoading;
            });
            if (state is UserProfileDataSuccess) {
              _storageService.currentUser = state.result;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
            }
            if (state is UserProfileDataError) {
              _storageService.accessToken = "";
            }
          },
          child: BlocListener(
            bloc: _loginBloc,
            listener: (BuildContext context, LoginState state) {
              setState(() {
                _isBusy = state is LoginLoading;
              });
              if (state is LoginSuccess) {
                _storageService.accessToken = state.result.accessToken;
                _userProfileDataBloc.add(GetUserProfileData(state.result.accessToken));
              }
            },
            child: Form(
              key: _loginFormKey,
              child: BlocBuilder(
                bloc: _loginBloc,
                builder: (BuildContext context, LoginState state) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height / 5,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(AppAssets.screen),
                        ),
                        SizedBox(height: 16),
                        Center(child: Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),
                        SizedBox(height: 16),
                        Container(
                          child: Card(
                            elevation: 2.0,
                            color: AppColors.lightPrimaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    controller: _txtUserNameController,
                                    enabled: !(state is LoginLoading),
                                    decoration: InputDecoration(
                                        fillColor: AppColors.primaryColor,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        icon: Icon(
                                          Icons.person_outline_outlined,
                                          color: AppColors.darkPrimaryColor,
                                        ),
                                        labelText: 'UserName/Email',
                                        labelStyle: TextStyle(color: AppColors.darkPrimaryColor)),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Username is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Divider(thickness: 2),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    controller: _txtPasswordController,
                                    enabled: !(state is LoginLoading),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      focusColor: AppColors.primaryColor,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      icon: Icon(Icons.lock_outline, color: AppColors.darkPrimaryColor),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(color: AppColors.darkPrimaryColor),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Password is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: PrimaryButton(
                            child: _isBusy ? BusyIndicator() : Text('Login', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightPrimaryColor, fontSize: 16)),
                            onPressed: () {
                              if (_loginFormKey.currentState.validate() && !_isBusy) {
                                var username = _txtUserNameController.text;
                                var password = _txtPasswordController.text;
                                _loginBloc.add(Login(username, password));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
