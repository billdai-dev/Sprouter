import 'package:flutter/material.dart';
import 'package:sprouter/ui/login/SlackAuthBloc.dart';

class SlackAuthBlocProvider extends InheritedWidget {
  final SlackAuthBloc bloc;

  SlackAuthBlocProvider({Key key, SlackAuthBloc bloc, Widget child})
      : bloc = bloc ?? SlackAuthBloc(),
        super(key: key, child: child);

  static SlackAuthBlocProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(SlackAuthBlocProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}