import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/app_colors.dart';
import 'package:test_app/src/page/home/fragments/profile.dart';

import 'fragments/add_new_item.dart';
import 'fragments/dashboard_fragment.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  List<Widget> _fragments = [
    DashboardFragment(),
    AddNewItem(),
    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _fragments[_currentIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        color: AppColors.primaryColor,
        backgroundColor: Colors.white,
        buttonBackgroundColor: AppColors.lightPrimaryColor,
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 24),
          Icon(Icons.add, size: 36),
          Icon(Icons.person, size: 24),
        ],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
