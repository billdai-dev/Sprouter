import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc_provider.dart';
import 'package:sprouter/ui/tab_navigator.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc_provider.dart';

void main() {
  runApp(new MaterialApp(
    builder: (context, child) => SlackLoginBlocProvider(
          child: TodayDrinkBlocProvider(
            child: child,
          ),
        ),
    theme: ThemeData(
      primaryColor: Color(0xFF93bf37),
      accentColor: Color(0xff427aa1),
      accentIconTheme: IconThemeData(color: Colors.white),
      primaryTextTheme: Typography(
              platform: Platform.isAndroid
                  ? TargetPlatform.android
                  : TargetPlatform.iOS)
          .black,
      accentTextTheme: Typography(
              platform: Platform.isAndroid
                  ? TargetPlatform.android
                  : TargetPlatform.iOS)
          .black
          .apply(
            displayColor: Color(0xfffffde7),
            bodyColor: Color(0xfffffde7),
          ),
    ),
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
  };

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKeys[_currentPage].currentState.maybePop();
      },
      child: Scaffold(
        appBar: _currentPage == 0
            ? null
            : AppBar(
                title: Text("Sprouter"),
              ),
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentPage,
            onTap: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.local_drink),
                title: Text('Drink'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.access_time,
                  color: Colors.orange,
                ),
                title: Text('Jibbler'),
              )
            ]),
      ),
    );
  }

  Widget _buildOffstageNavigator(int pageIndex) {
    return Visibility(
      visible: _currentPage == pageIndex,
      maintainState: true,
      child: TabNavigator(
        pageIndex,
        navigatorKey: navigatorKeys[pageIndex],
      ),
    );
  }
}
