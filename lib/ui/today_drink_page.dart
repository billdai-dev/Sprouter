import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/ui/today_drink_bloc.dart';
import 'package:sprouter/ui/today_drink_bloc_provider.dart';

class TodayDrinkPage extends StatefulWidget {
  @override
  TodayDrinkPageState createState() {
    return new TodayDrinkPageState();
  }

  Widget _createDrinkThreadListView(BuildContext context, Message message) {
    BuiltList<Reply> replies = message?.replies;

    return replies == null || replies.isEmpty
        ? SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
        : SliverList(delegate: SliverChildBuilderDelegate((context, index) =>
        Column(
          children: <Widget>[
            ListTile(
              title: Text(replies[index].user),
            ),
            Divider(height: 2.0,)
          ],
        ),
        childCount: replies.length),
    );
  }
}

class TodayDrinkPageState extends State<TodayDrinkPage> {
  @override
  Widget build(BuildContext context) {
    TodayDrinkBloc bloc = TodayDrinkBloc();
    bloc.fetchMessage.add(null);
    return TodayDrinkBlocProvider(bloc: bloc,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(color: Colors.amber,)),
            ),
            StreamBuilder<Message>(
              stream: bloc.drinkMessage,
              builder: (context, snapshot) {
                return widget._createDrinkThreadListView(
                    context, snapshot.data);
              },
            )
          ],
        ),
      ),
    );
  }
}
