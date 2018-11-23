import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprouter/app_provider.dart';
import 'package:sprouter/ui/check_in/check_in_page.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/today_drink_page.dart';

const int drinkPageIndex = 0;
const int checkInPageIndex = 1;

void main() {
  runApp(new MaterialApp(
    builder: (context, child) => AppProvider(
          child: SlackLoginBlocProvider(
            child: TodayDrinkBlocProvider(
              child: child,
            ),
          ),
        ),
    theme: ThemeData(
      primaryColor: Color(0xff93bf37),
      primaryColorDark: Color(0xff618f00),
      primaryColorLight: Color(0xffc6f268),
      accentColor: Color(0xff3794bf),
      accentIconTheme: IconThemeData(
        color: Colors.white,
      ),
      primaryTextTheme: Typography(
              platform: Platform.isAndroid
                  ? TargetPlatform.android
                  : TargetPlatform.iOS)
          .black,
      accentTextTheme: Typography(
              platform: Platform.isAndroid
                  ? TargetPlatform.android
                  : TargetPlatform.iOS)
          .white,
    ),
    home: MainPageContainer(),
  ));
}

class MainPageContainer extends StatefulWidget {
  @override
  _MainPageContainerState createState() => new _MainPageContainerState();
}

class _MainPageContainerState extends State<MainPageContainer> {
  @override
  Widget build(BuildContext context) {
    Map<int, GlobalKey<NavigatorState>> navigatorKeys =
        AppProvider.of(context).navigatorKeys;
    List<Widget> tabs = [
      TabNavigator(drinkPageIndex, navigatorKeys[drinkPageIndex]),
      TabNavigator(checkInPageIndex, navigatorKeys[checkInPageIndex]),
    ];
    return MainPage(tabs);
  }
}

class MainPage extends StatefulWidget {
  final List<Widget> _tabs;

  MainPage(this._tabs);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Map<int, GlobalKey<NavigatorState>> navigatorKeys =
        AppProvider.of(context).navigatorKeys;
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentPageIndex].currentState.maybePop(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Visibility(
              visible: _currentPageIndex == drinkPageIndex,
              maintainState: true,
              child: widget._tabs[drinkPageIndex],
            ),
            Visibility(
              visible: _currentPageIndex == checkInPageIndex,
              maintainState: true,
              child: widget._tabs[checkInPageIndex],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentPageIndex,
            onTap: (index) => setState(() => _currentPageIndex = index),
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
}

class TabNavigator extends StatelessWidget {
  static const String routeRoot = '/';
  static const String routeOrderDrink = '/order_drink';

  final int _pageIndex;
  final GlobalKey<NavigatorState> navigatorKey;

  TabNavigator(this._pageIndex, this.navigatorKey);

  Map<String, WidgetBuilder> _routeBuilders(int pageIndex) {
    switch (pageIndex) {
      case drinkPageIndex:
        return {
          routeRoot: (context) => TodayDrinkPage(),
          routeOrderDrink: (context) => null
        };
      case checkInPageIndex:
        return {
          routeRoot: (context) => CheckInPage(),
        };
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routeBuilders = _routeBuilders(_pageIndex);
    return Navigator(
      key: navigatorKey,
      initialRoute: routeRoot,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: routeBuilders[routeSettings.name]);
      },
      observers: [HeroController()],
    );
  }
}
