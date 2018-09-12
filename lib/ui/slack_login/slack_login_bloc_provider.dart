import 'package:flutter/material.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc.dart';

class SlackLoginBlocProvider extends StatefulWidget {
  final Widget child;

  SlackLoginBlocProvider({Key key, this.child}) : super(key: key);

  @override
  _SlackLoginBlocProviderState createState() => _SlackLoginBlocProviderState();

  static SlackLoginBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_SlackLoginBlocProvider)
              as _SlackLoginBlocProvider)
          .bloc;
}

class _SlackLoginBlocProviderState extends State<SlackLoginBlocProvider> {
  SlackLoginBloc _bloc;

  @override
  void initState() {
    _bloc = SlackLoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _SlackLoginBlocProvider(
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

class _SlackLoginBlocProvider extends InheritedWidget {
  final SlackLoginBloc bloc;

  _SlackLoginBlocProvider({Key key, SlackLoginBloc bloc, Widget child})
      : bloc = bloc ?? SlackLoginBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}
