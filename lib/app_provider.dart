import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;

  AppStateContainer({Key key, this.child}) : super(key: key);

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_AppStateProvider)
              as _AppStateProvider)
          .data;
}

class _AppStateContainerState extends State<AppStateContainer> {
  Map<int, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  void initState() {
    super.initState();
    navigatorKeys = {
      drinkPageIndex: GlobalKey<NavigatorState>(),
      checkInPageIndex: GlobalKey<NavigatorState>(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return _AppStateProvider(
      data: this,
      child: widget.child,
    );
  }
}

class _AppStateProvider extends InheritedWidget {
  final _AppStateContainerState data;

  _AppStateProvider({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_AppStateProvider old) => old.data != data;
}
