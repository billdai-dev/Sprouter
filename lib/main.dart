import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprouter/ui/check_in/check_in_page.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/today_drink_page.dart';

const int drinkPageIndex = 0;
const int checkInPageIndex = 1;

void main() {
  runApp(new MaterialApp(
    builder: (context, child) => SlackLoginBlocProvider(
          child: TodayDrinkBlocProvider(
            child: child,
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
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final StreamController<int> _currentPageIndex = StreamController();
  Map<int, GlobalKey<NavigatorState>> _navigatorKeys;

  @override
  void initState() {
    super.initState();
    _navigatorKeys = {
      drinkPageIndex: GlobalKey<NavigatorState>(),
      checkInPageIndex: GlobalKey<NavigatorState>(),
    };
  }

  @override
  void dispose() {
    _currentPageIndex?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _currentPageIndex?.stream,
      initialData: drinkPageIndex,
      builder: (context, snapshot) {
        int currentPageIndex = snapshot.data;
        return WillPopScope(
          onWillPop: () async {
            return !await _navigatorKeys[currentPageIndex]
                .currentState
                .maybePop();
          },
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Visibility(
                  visible: currentPageIndex == drinkPageIndex,
                  maintainState: true,
                  child: TabNavigator(
                    drinkPageIndex,
                    _navigatorKeys[drinkPageIndex],
                  ),
                ),
                Visibility(
                  visible: currentPageIndex == checkInPageIndex,
                  maintainState: true,
                  child: TabNavigator(
                    checkInPageIndex,
                    _navigatorKeys[checkInPageIndex],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentPageIndex,
                onTap: (index) => _currentPageIndex?.add(index),
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
      },
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
