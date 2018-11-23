import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';

class AppProvider extends InheritedWidget {
  final Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    drinkPageIndex: GlobalKey<NavigatorState>(),
    checkInPageIndex: GlobalKey<NavigatorState>(),
  };

  AppProvider({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static AppProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppProvider) as AppProvider;
  }

  @override
  bool updateShouldNotify(AppProvider old) {
    return old.navigatorKeys != navigatorKeys ||
        old.navigatorKeys[drinkPageIndex] != navigatorKeys[drinkPageIndex] ||
        old.navigatorKeys[checkInPageIndex] != navigatorKeys[checkInPageIndex];
  }
}
