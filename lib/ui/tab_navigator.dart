import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sprouter/ui/today_drink/today_drink_page.dart';

class TabNavigatorRoutes {
  static const String ROOT = '/';
  static const String ORDER_DRINK = '/order_drink';
}

class TabNavigator extends StatelessWidget {
  final int _pageIndex;
  final GlobalKey<NavigatorState> navigatorKey;

  TabNavigator(this._pageIndex, {this.navigatorKey});

  Map<String, WidgetBuilder> _routeBuilders(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return {
          TabNavigatorRoutes.ROOT: (context) => TodayDrinkPage(),
          TabNavigatorRoutes.ORDER_DRINK: (context) => null
        };
      case 1:
        return {TabNavigatorRoutes.ROOT: (context) => null};
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routeBuilders = _routeBuilders(_pageIndex);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.ROOT,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: routeBuilders[routeSettings.name]);
      },
      observers: [HeroController()],
    );
  }
}
