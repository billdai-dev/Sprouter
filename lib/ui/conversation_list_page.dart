import 'package:flutter/material.dart';
import 'package:sprouter/ui/conversation_list_bloc.dart';
import 'package:sprouter/ui/conversation_list_bloc_provider.dart';

class ConversationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConversationListBloc bloc = ConversationListBloc();
    var v = bloc.repository.getLunchConversations();
    return ConversationListBlocProvider(bloc: bloc,
      child: Container(),);
  }
}
