import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/ui/today_drink_bloc.dart';
import 'package:sprouter/ui/today_drink_bloc_provider.dart';

class TodayDrinkPage extends StatefulWidget {
  @override
  TodayDrinkPageState createState() {
    return new TodayDrinkPageState();
  }

  Widget _createReplyListView(
      BuildContext context, BuiltList<Message> drinkThread) {
    List<Message> replies;
    if (drinkThread == null ||
        (replies = drinkThread?.skip(1)?.toList(growable: false)) == null ||
        replies.isEmpty) {
      return SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()));
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
                children: <Widget>[
                  ListTile(
                    title: Text(replies[index].text),
                  ),
                  Divider(height: 2.0)
                ],
              ),
          childCount: replies.length),
    );
  }

  Widget _createTitle(AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return Text("");
    }
    BuiltList<Message> drinkThread =
        snapshot.data[TodayDrinkPageState._ARG_MESSAGES];
    List<String> parsedTitle = drinkThread[0]?.files[0]?.title?.split(" ");
    String shopName =
        parsedTitle.isEmpty || parsedTitle.length < 2 ? "" : parsedTitle[1];
    return Text(shopName);
  }

  Widget _createImage(AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return Container(
          color: Colors.grey,
          child: Center(child: CircularProgressIndicator()));
    }
    String token = snapshot.data[TodayDrinkPageState._ARG_TOKEN];
    BuiltList<Message> messages =
        snapshot.data[TodayDrinkPageState._ARG_MESSAGES];
    return Container(
        color: Colors.grey,
        child: CachedNetworkImage(
            placeholder: Center(child: CircularProgressIndicator()),
            imageUrl: messages[0].files[0].urlPrivate,
            fit: BoxFit.contain,
            httpHeaders: {"Authorization": "Bearer $token"}));
  }
}

class TodayDrinkPageState extends State<TodayDrinkPage> {
  static const String _ARG_TOKEN = "token";
  static const String _ARG_MESSAGES = "messages";

  @override
  Widget build(BuildContext context) {
    TodayDrinkBloc bloc = TodayDrinkBlocProvider.of(context);
    bloc.fetchMessage.add(null);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          StreamBuilder<Map<String, dynamic>>(
            stream:
                bloc.slackToken.zipWith(bloc.drinkMessage, (token, message) {
              return {_ARG_MESSAGES: message, _ARG_TOKEN: token};
            }),
            builder: (context, snapshot) {
              return SliverAppBar(
                  expandedHeight: 250.0,
                  pinned: true,
                  floating: true,
                  title: widget._createTitle(snapshot),
                  flexibleSpace: FlexibleSpaceBar(
                      background: widget._createImage(snapshot)));
            },
          ),
          StreamBuilder<BuiltList<Message>>(
            stream: bloc.drinkMessage,
            builder: (context, snapshot) {
              return widget._createReplyListView(context, snapshot.data);
            },
          )
        ],
      ),
    );
  }
}
