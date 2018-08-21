import 'package:flutter/material.dart';
import 'package:sprouter/ui/today_drink_bloc.dart';
import 'package:sprouter/ui/login/slack_auth_bloc.dart';

class TodayDrinkBlocProvider extends InheritedWidget {
  final TodayDrinkBloc bloc;

  TodayDrinkBlocProvider({Key key, TodayDrinkBloc bloc, Widget child})
      : bloc = bloc ?? TodayDrinkBloc(),
        super(key: key, child: child);

  static TodayDrinkBlocProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(TodayDrinkBlocProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}