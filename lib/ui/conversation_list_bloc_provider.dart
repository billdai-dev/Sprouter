import 'package:flutter/material.dart';
import 'package:sprouter/ui/conversation_list_bloc.dart';
import 'package:sprouter/ui/login/slack_auth_bloc.dart';

class ConversationListBlocProvider extends InheritedWidget {
  final ConversationListBloc bloc;

  ConversationListBlocProvider({Key key, ConversationListBloc bloc, Widget child})
      : bloc = bloc ?? ConversationListBloc(),
        super(key: key, child: child);

  static ConversationListBlocProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(ConversationListBlocProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}