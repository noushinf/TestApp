import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/app_colors.dart';
import 'package:test_app/src/connectivity_service.dart';
import 'package:test_app/src/enum.dart';
import 'package:test_app/src/page/splash_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
        create: (context) =>
        ConnectivityService().connectionStatusController.stream,
        child: MaterialApp(
          title: 'Mulki Zerin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Roboto',
            primaryColor: AppColors.primaryColor,
            accentColor: AppColors.secondaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
        ));
  }
}