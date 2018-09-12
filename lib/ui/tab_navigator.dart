import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sprouter/ui/today_drink/today_drink_page.dart';

class TabNavigatorRoutes {
  static const String ROOT = '/';
  static const String ORDER_DRINK = '/order_drink';
}

class TabNavigator extends StatelessWidget {
  final int _pageIndex;

  TabNavigator(this._pageIndex, {this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  void _push(BuildContext context, int pageIndex) {
    var routeBuilders = _routeBuilders(context, pageIndex);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilders[TabNavigatorRoutes.ORDER_DRINK](context)));
  }

  Map<String, WidgetBuilder> _routeBuilders(
      BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        return {
          TabNavigatorRoutes.ROOT: (context) =>
              TodayDrinkPage(() => _push(context, pageIndex)),
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
    Map<String, WidgetBuilder> routeBuilders =
        _routeBuilders(context, _pageIndex);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.ROOT,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context));
      },
      observers: [HeroController()],
    );
  }
}
