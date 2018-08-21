import 'package:flutter/material.dart';
import 'package:sprouter/ui/today_drink_bloc.dart';
import 'package:sprouter/ui/today_drink_bloc_provider.dart';

class TodayDrinkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodayDrinkBloc bloc = TodayDrinkBloc();
    return TodayDrinkBlocProvider(bloc: bloc,
      child: Container(),);
  }
}
