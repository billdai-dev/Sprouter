import 'package:flutter/material.dart';
import 'package:sprouter/ui/check_in/check_in_bloc.dart';

class CheckInBlocProvider extends StatefulWidget {
  final Widget child;

  CheckInBlocProvider({Key key, this.child}) : super(key: key);

  @override
  _CheckInBlocProviderState createState() => _CheckInBlocProviderState();

  static CheckInBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_CheckInBlocProvider)
              as _CheckInBlocProvider)
          .bloc;
}

class _CheckInBlocProviderState extends State<CheckInBlocProvider> {
  CheckInBloc _bloc;

  @override
  void initState() {
    _bloc = CheckInBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _CheckInBlocProvider(
      bloc: _bloc,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class _CheckInBlocProvider extends InheritedWidget {
  final CheckInBloc bloc;

  _CheckInBlocProvider({Key key, CheckInBloc bloc, Widget child})
      : bloc = bloc ?? CheckInBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}
