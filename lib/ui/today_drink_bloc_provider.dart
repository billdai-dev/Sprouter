import 'package:flutter/material.dart';
import 'package:sprouter/ui/today_drink_bloc.dart';

class TodayDrinkBlocProvider extends StatefulWidget {
  final Widget child;

  TodayDrinkBlocProvider({Key key, this.child}) : super(key: key);

  @override
  _TodayDrinkBlocProviderState createState() => _TodayDrinkBlocProviderState();

  static TodayDrinkBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_TodayDrinkBlocProvider)
              as _TodayDrinkBlocProvider)
          ?.bloc;
}

class _TodayDrinkBlocProviderState extends State<TodayDrinkBlocProvider> {
  TodayDrinkBloc _bloc;

  @override
  void initState() {
    _bloc = TodayDrinkBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _TodayDrinkBlocProvider(
      bloc: _bloc,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }
}

class _TodayDrinkBlocProvider extends InheritedWidget {
  final TodayDrinkBloc bloc;

  _TodayDrinkBlocProvider({Key key, TodayDrinkBloc bloc, Widget child})
      : bloc = bloc ?? TodayDrinkBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}
