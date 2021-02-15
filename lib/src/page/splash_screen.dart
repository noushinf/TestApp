import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/core/app_assets.dart';
import 'package:test_app/core/app_colors.dart';
import 'package:test_app/src/page/home/home_page.dart';
import 'package:test_app/src/page/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation:0,
                      child: Center(
                        child: Container(
                          height: height / 4,

                          child:Center(

                              child: Image.asset(AppAssets.screen,width: 150,height: 150,),

                          ),



                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text("Test App",
                        style: TextStyle(
                            fontFamily: 'Blkchtry',
                            color: AppColors.darkPrimaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            Text(
              'copyright @ 2021 - Test App',
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 12),
            ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  startTimer() async {
    debugPrint("Timer started");
    var _duration = new Duration(seconds:3);
    return new Timer(_duration, navigateToMainPage);
  }

  Future<void> navigateToMainPage() async {
    debugPrint("Timer completed");
    // var screenHeight = MediaQuery.of(context).size.height;
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardPage(screenHeight: screenHeight)));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}
